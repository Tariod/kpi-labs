#include <stdio.h>
#include "src/allocator.h"

int main (int argc, char *argv[]) {
  mem_pool_alloc();
  void *test1 = mem_alloc(32);
  mem_dump();
  void *test2 = mem_alloc(32);
  mem_dump();
  void *test3 = mem_alloc(16);
  mem_dump();
  mem_free(test1);
  mem_dump();
  mem_free(test2);
  mem_dump();
  mem_free(test3);
  mem_dump();
  mem_pool_free();
  return 0;
}
