#include <math.h>
#include <string.h>
#include "segregated_list.h"

struct heap_t heap = { 0, NULL, NULL };

// Private functions

static size_t align(size_t size);
static pages_pool_t *pages_pool_alloc();
static page_t *page_alloc();
static block_t *block_alloc();
static pages_pool_t *get_pages_pool(size_t block_size);
static pages_pool_t *get_empty_pages_pool();
static block_t *get_empty_block(page_t *page);
static pages_pool_t *unshift_pages_pool(pages_pool_t *pages_pool);
static page_t *segregate_page(page_t *page, size_t size);
static page_t *shift_page(pages_pool_t *pages_pool);
static page_t *unshift_page(pages_pool_t *pages_pool, page_t *page);
static bool is_page_free(page_t *page);
static page_t *cut_page(pages_pool_t *pages_pool, page_t *page);
static void *get_end_of_page(void *begin);

// Implementation of public functions

bool mem_pool_alloc_size(size_t size) {
  if (heap.paylaod != NULL) {
    return false;
  }

  size = align(size);
  if (size < PAGE_SIZE) {
    size = PAGE_SIZE * 1024;
  }

  heap.size = size;
  heap.paylaod = malloc(heap.size);
  if (heap.paylaod == NULL) {
    heap.size = 0;
    return false;
  }

  pages_pool_t *pages_pool = pages_pool_alloc();
  if (pages_pool == NULL) {
    return false;
  }

  void *curr = heap.paylaod;
  void *tail = (void *)((size_t)heap.paylaod + heap.size);
  page_t *last_page = pages_pool->pages;

  while (curr != tail) {
    page_t *page = page_alloc();
    block_t *block = block_alloc();
    if (page == NULL || block == NULL) {
      return false;
    }

    page->blocks = block;
    page->blocks->payload = curr;
    page->prev = last_page;
  
    if (last_page == NULL) {
      pages_pool->pages = page;
    } else {
      last_page->next = page;
    }

    curr = (void *)((size_t)curr + PAGE_SIZE);
    last_page = page;
  }

  heap.pages_pool = pages_pool;

  return true;
};

bool mem_pool_alloc(void) {
  return mem_pool_alloc_size(PAGE_SIZE * 1024);
};

void mem_pool_free(void) {
  if (heap.paylaod != NULL) {
    pages_pool_t *pages_pool = heap.pages_pool;
    while (pages_pool != NULL) {
      heap.pages_pool = pages_pool->next;

      page_t *page = pages_pool->pages;
      while (page != NULL) {
        pages_pool->pages = page->next;
        if (pages_pool->pages != NULL) {
          pages_pool->pages->prev = NULL;
        }

        block_t *block = page->blocks;
        while (block != NULL) {
          page->blocks = block->next;
          free(block);
          block = page->blocks;
        }
        

        free(page);
        page = pages_pool->pages;
      }

      free(pages_pool);
      pages_pool = heap.pages_pool;
    }

    free(heap.paylaod);
    heap.paylaod = NULL;
    heap.size = 0;
  }
};

struct heap_t get_heap(void) {
  return heap;
}

void *mem_alloc(size_t size) {
  size_t block_size = align(size);
  if (size > PAGE_SIZE) {
    return NULL;
  }
  pages_pool_t *pages_pool = get_pages_pool(block_size);
  if (pages_pool == NULL) {
    pages_pool_t *empty_pages_pool = get_empty_pages_pool();
    pages_pool = pages_pool_alloc();

    if (pages_pool == NULL) {
      return pages_pool;
    }
  
    pages_pool->size = block_size;
    unshift_pages_pool(pages_pool);
  }

  page_t *page = pages_pool->pages;
  block_t *empty_block = get_empty_block(page);
  while (page != NULL && page->next != NULL && empty_block == NULL) {
    page = page->next;
    empty_block = get_empty_block(page);
  }

  if (empty_block == NULL) {
    pages_pool_t *empty_pages_pool = get_empty_pages_pool();

    page = shift_page(empty_pages_pool);
    if (page == NULL) {
      return page;
    }
    page = segregate_page(page, block_size);
    unshift_page(pages_pool, page);

    empty_block = page->blocks;
  }

  empty_block->free = false;
  return empty_block->payload;
};

void *mem_realloc(void *addr, size_t size) {
  // pages_pool_t *pages_pool = heap.pages_pool;
  // while (pages_pool != NULL) {
  //   page_t *page = pages_pool->pages;
  //   while (page != NULL &&
  //     !(addr >= page->blocks->payload &&
  //       addr < get_end_of_page(page->blocks->payload)
  //     )
  //   ) {
  //     page = page->next;
  //   }
    
  //   if (page != NULL) break;

  //   pages_pool = pages_pool->next;
  // }

  // if (pages_pool == NULL) {
  //   return NULL;
  // }

  size_t block_size = align(size);
  void *new_addr = mem_alloc(block_size);
  if (new_addr == NULL) {
    return NULL;
  }

  memcpy(new_addr, addr, block_size);
  mem_free(addr);
  return new_addr;
};

void mem_free(void *addr) {
  pages_pool_t *pages_pool = heap.pages_pool;
  page_t *page = NULL;
  while (pages_pool != NULL) {
    page = pages_pool->pages;
    while (page != NULL &&
      !(addr >= page->blocks->payload &&
        addr < get_end_of_page(page->blocks->payload)
      )
    ) {
      page = page->next;
    }
    
    if (page != NULL) break;

    pages_pool = pages_pool->next;
  }

  if (pages_pool != NULL && page != NULL) {
    block_t *block = page->blocks;
    while (block != NULL && block->payload != addr) {
      block = block->next;
    }

    if (block != NULL) {
      block->free = true;
      if (is_page_free(page)) {
        page = cut_page(pages_pool, page);
        unshift_page(get_empty_pages_pool(), page);
      }
    }
  }
};

// Implementation of private functions

static size_t align(size_t size) {
  size = size > 8 ? size : 16;
  return (size_t) pow(2, ceil(log2(size)));
};

static pages_pool_t *pages_pool_alloc() {
  pages_pool_t *pages_pool = malloc(sizeof(pages_pool_t));
  if (pages_pool == NULL) {
    return pages_pool;
  }

  pages_pool->size = 0;
  pages_pool->pages = NULL;
  pages_pool->next = NULL;

  return pages_pool;
};

static page_t *page_alloc() {
  page_t *page = malloc(sizeof(page_t));
  if (page == NULL) {
    return page;
  }
  
  page->blocks = NULL;
  page->prev = NULL;
  page->next = NULL;

  return page;
};

static block_t *block_alloc() {
  block_t *block = malloc(sizeof(block_t));
  if (block == NULL) {
    return block;
  }

  block->free = true;
  block->payload = NULL;
  block->next = NULL;

  return block;
};

static pages_pool_t *get_pages_pool(size_t block_size) {
  pages_pool_t *pages_pool = heap.pages_pool;
  while (block_size != pages_pool->size) {
    pages_pool = pages_pool->next;
    if (pages_pool == NULL) {
      return NULL;
    }
  }

  return pages_pool;
};

static pages_pool_t *get_empty_pages_pool() {
  return get_pages_pool(0);
};

static block_t *get_empty_block(page_t *page) {
  if (page == NULL) {
    return NULL;
  }

  block_t *block = page->blocks;
  while (!block->free) {
    block = block->next;
    if (block == NULL) {
      return NULL;
    }
  }

  return block;
};

static pages_pool_t *unshift_pages_pool(pages_pool_t *pages_pool) {
  pages_pool_t *next = heap.pages_pool;

  pages_pool->next = next;
  heap.pages_pool = pages_pool;

  return pages_pool;
};

static page_t *segregate_page(page_t *page, size_t size) {
  block_t *block = page->blocks;
  void *payload = (void *)((size_t)block->payload + size);
  void *tail = (void *)((size_t)payload + PAGE_SIZE);

  while (payload != tail) {
    block->next = block_alloc();
    block = block->next;
    block->payload = payload;
    payload = (void *)((size_t)payload + size); 
  }

  return page;
};

static page_t *shift_page(pages_pool_t *pages_pool) {
  page_t *page = pages_pool->pages;
  if (page != NULL) {
    pages_pool->pages = pages_pool->pages->next;
    if (pages_pool->pages != NULL) {
      pages_pool->pages->prev = NULL;
    }
    page->next = NULL;
  }

  return page;
};

static page_t *unshift_page(pages_pool_t *pages_pool, page_t *page) {
  page_t *next = pages_pool->pages;

  page->next = next;
  if (next != NULL) {
    next->prev = page;
  }
  pages_pool->pages = page;

  return page;
};

static bool is_page_free(page_t *page) {
  block_t *block = page->blocks;
  while (block != NULL) {
    if (!block->free) {
      return block->free;
    }
    block = block->next;
  }
  
  return true;
};

static page_t *cut_page(pages_pool_t *pages_pool, page_t *page) {
  page_t *prev = page->prev;
  page_t *next = page->next;

  if (prev == NULL) {
    return shift_page(pages_pool);
  }

  prev->next = next;
  if (next != NULL) {
    next->prev = prev;
  }

  page->prev = NULL;
  page->next = NULL;

  return page;
};

static void *get_end_of_page(void *begin) {
  return (void *)((size_t)begin + PAGE_SIZE);
};
