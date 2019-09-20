#include <string.h>
#include "allocator.h"

struct mem_pool_t {
  void *data;
  size_t size;
} mem_pool;

// Private functions
static block_header_t *get_head(struct mem_pool_t pool);
static size_t block_size(block_header_t *block);
static void *split_block(block_header_t *block, size_t size);
static block_header_t *get_block_header(void *addr);
static block_header_t *merge_blocks(block_header_t *base, block_header_t *appendix);
static void *get_block_payload(block_header_t *block);
static size_t align(size_t size);

// Implementation

bool mem_pool_alloc(size_t size) {
  if (mem_pool.data != NULL) {
    return false;
  }

  if (size < 2 * sizeof(block_header_t)) {
    size = DEFAULT_POOL_SIZE;
  }
  mem_pool.size = size;

  mem_pool.data = malloc(mem_pool.size);
  if (mem_pool.data == NULL) {
    return false;
  }

  block_header_t *head = get_head(mem_pool);
  block_header_t *tail = (block_header_t *)(
    (size_t)mem_pool.data + mem_pool.size - sizeof(block_header_t)
  );

  head->allocated = false;
  head->prev = NULL;
  head->next = tail;
  head->size = block_size(head);

  tail->allocated = true;
  tail->size = 0;
  tail->prev = tail;
  tail->next = NULL;

  return true;
}

void mem_pool_free(void) {
  if (mem_pool.data != NULL) {
    free(mem_pool.data);
    mem_pool.data = NULL;
    mem_pool.size = 0;
  }
};

void *mem_alloc(size_t size) {
  size = align(size);
  block_header_t *block = get_head(mem_pool);
  while (block->allocated || block->size < size) {
    if (block->next == NULL) {
      return NULL;
    }
    block = block->next;
  }

  block = split_block(block, size);
  block->allocated = true;

  return get_block_payload(block);
};

void *mem_realloc(void *addr, size_t size) {
  if (addr == NULL) {
    return mem_alloc(size);
  }
  size = align(size);

  block_header_t *block = get_block_header(addr);
  if (block->size >= size) {
    split_block(block, size);
    return addr;
  }

  const size_t block_header_size = sizeof(block_header_t);
  block_header_t *next_block = block->next;
  if (
    next_block != NULL &&
    !next_block->allocated &&
    block->size + next_block->size + block_header_size >= size
  ) {
    merge_blocks(block, next_block);
    split_block(block, size);
    
    return addr;
  }

  block_header_t *prev_block = block->prev;
  if (
    prev_block != NULL &&  
    !prev_block->allocated &&
    block->size + prev_block->size + block_header_size >= size
  ) {
    size_t data_size = block->size;

    block->allocated = false;
    block = merge_blocks(prev_block, block);

    block->allocated = true;
    void *block_data = get_block_payload(block);
    memcpy(block_data, addr, data_size);
    split_block(block, size);

    return block_data;
  }

  void *temp = mem_alloc(size);
  if (temp != NULL) {
    memcpy(temp, addr, block->size);
    mem_free(addr);
  }

  return temp;
};

void mem_free(void *addr) {
  block_header_t *block = get_block_header(addr);
  block->allocated = false; 

  if (!block->next->allocated) {
    merge_blocks(block, block->next);
  }

  if (block->prev != NULL && !block->prev->allocated) {
    merge_blocks(block->prev, block);
  }
};

blocks_status_t get_blocks_status(void) {
  block_header_t *block = get_head(mem_pool);
  
  size_t count = 1;
  while (block->next != NULL) {
    count++;
    block = block->next;
  }

  blocks_status_t info = {
    get_head(mem_pool),
    mem_pool.size,
    count
  };

  return info;
};

static block_header_t *get_head(struct mem_pool_t pool) {
  return (block_header_t *)pool.data;
};

static size_t block_size(block_header_t *block) {
  if (block->next == NULL) {
    return 0;
  }

  size_t begin = (size_t)block + sizeof(block_header_t);
  size_t end = (size_t)(block->next);
  return end - begin;
};

static void *split_block(block_header_t *block, size_t size) {
  if (block->size < size) {
    return NULL;
  }
  
  size_t remaining = block->size - size; 
  if (remaining >= sizeof(block_header_t)) {
    block_header_t *new_block = (block_header_t *)(
      (size_t)get_block_payload(block) + size
    );

    new_block->allocated = false;

    new_block->prev = block;
    new_block->next = block->next;
    block->next->prev = new_block;
    block->next = new_block;
  
    new_block->size = block_size(new_block);
    block->size = size;
  }

  return block;
};

static block_header_t *merge_blocks(block_header_t *base, block_header_t *appendix) {
  if (appendix->allocated || base->next != appendix) {
    return NULL;
  }

  block_header_t *next = appendix->next;
  base->next = next;
  next->prev = base;

  base->size = block_size(base);
  return base;
};

static block_header_t *get_block_header(void *addr) {
  return (block_header_t *)((size_t)addr - sizeof(block_header_t));
};

static void *get_block_payload(block_header_t *block) {
  return (void *)((size_t)block + sizeof(block_header_t));
};

static size_t align(size_t size) {
  size_t offset = size % 4;
  return offset ? size + (4 - offset) : size;
};