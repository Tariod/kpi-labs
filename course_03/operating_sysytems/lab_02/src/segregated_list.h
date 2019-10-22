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

struct heap_t {
  size_t size;
  pages_pool_t *pages_pool;
  void *paylaod;
};

bool mem_pool_alloc(void);

bool mem_pool_alloc_size(size_t size);

struct heap_t get_heap(void);

void *mem_alloc(size_t size);

void *mem_realloc(void *addr, size_t size);

void mem_free(void *addr);

void mem_pool_free(void);
