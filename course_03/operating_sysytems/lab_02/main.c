#include "src/segregated_list.h"
#include <stdio.h>

int main (int argc, char *argv[]) {
  mem_pool_alloc();
  mem_alloc(32);
  mem_alloc(16);
  mem_pool_free();
  return 0;
}
