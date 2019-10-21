#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

#define PAGE_SIZE (size_t)sysconf(_SC_PAGESIZE)

typedef struct block {
  bool free;
  void *payload;
  struct block *next;
} block_t;

typedef struct page {
  block_t *blocks;
  struct page *prev;
  struct page *next;
} page_t;

typedef struct pages_pool {
  size_t size;
  page_t *pages;
  struct pages_pool *next;
} pages_pool_t;

bool mem_pool_alloc(void);

void *mem_alloc(size_t size);

void *mem_realloc(void *addr, size_t size);

void mem_free(void *addr);

void mem_pool_free(void);
