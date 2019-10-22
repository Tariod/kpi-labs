#include "src/segregated_list.h"
#include <stdio.h>

int main (int argc, char *argv[]) {
  mem_pool_alloc();
  void *test1 = mem_alloc(32);
  printf("test1: %p\n", test1);
  void *test2 = mem_alloc(32);
  printf("test2: %p\n", test2);
  void *test3 = mem_alloc(16);
  printf("test3: %p\n", test3);
  printf("mem_free test1\n");
  mem_free(test1);
  printf("mem_free test2\n");
  mem_free(test2);
  mem_pool_free();
  return 0;
}
