#include <stdio.h>
#include "logger.h"
#include "segregated_list.h"

// Private functions
static void *get_begin_of_heap(struct heap_t heap);
static void *get_end_of_heap(struct heap_t heap);

// Implementation of public functions

void mem_dump(void) {
  struct heap_t heap = get_heap();
  printf("               MEMORY DUMP               \n");
  printf("-----------------------------------------\n");
  printf("Begin of memory pool: %p\n", get_begin_of_heap(heap));
  printf("End of memory pool: %p\n", get_end_of_heap(heap));
  pages_pool_t *pages_pool = heap.pages_pool;
  while(pages_pool != NULL) {
    if (pages_pool->size == 0 || pages_pool->pages == NULL) {
      pages_pool = pages_pool->next;
      continue;
    }
    printf("Pool of blocks size %ld bytes:\n", pages_pool->size);
    page_t *page = pages_pool->pages;
    while (page != NULL) {
      block_t *block = page->blocks;
      while (block != NULL) {
        if(!block->free) {
          printf(
            "\tAllocated block of memory:\n"
            "\t\tAddress: %p.\n",
            block->payload
          );
        }
        block = block->next;
      }
      page = page->next;
    }
    pages_pool = pages_pool->next;
  }
  printf("=========================================\n\n");
};

// Implementation of private functions

static void *get_begin_of_heap(struct heap_t heap) {
  return heap.paylaod;
};

static void *get_end_of_heap(struct heap_t heap) {
  return (void *)((size_t )heap.paylaod + heap.size);
};
