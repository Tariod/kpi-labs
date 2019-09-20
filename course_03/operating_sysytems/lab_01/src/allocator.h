#include <stdlib.h>
#include <stdbool.h>

#define DEFAULT_POOL_SIZE 100 * 1024 *1024

typedef struct block_header {
  bool allocated;
  size_t size;
  struct block_header *prev;
  struct block_header *next;
} block_header_t;

bool mem_pool_alloc(size_t size);

void *mem_alloc(size_t size);

void *mem_realloc(void *addr, size_t size);

void mem_free(void *addr);

void mem_pool_free(void);

typedef struct {
  block_header_t *head;
  size_t size;
  size_t length;
} blocks_status_t;

blocks_status_t get_blocks_status(void);
