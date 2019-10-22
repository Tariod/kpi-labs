#include <stdbool.h>
#include <stdlib.h>

bool mem_pool_alloc(void);

bool mem_pool_alloc_size(size_t size);

void *mem_alloc(size_t size);

void *mem_realloc(void *addr, size_t size);

void mem_free(void *addr);

void mem_dump(void);

void mem_pool_free(void);
