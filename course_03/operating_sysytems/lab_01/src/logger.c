#include <stdio.h>
#include "allocator.h"

void mem_dump(void) {
  blocks_status_t info = get_blocks_status();

  printf("========================================\n");
  printf("Memory pool size: %ld\n", info.size);
  printf("Number of blocks: %ld\n", info.length);

  block_header_t *block = info.head;
  for (size_t id = 1; id <= info.length; id++) {
    printf("----------------------------------------\n");
    printf(
      "Block #%ld\n"
      "Address:  %p\n"
      "Previous: %p\n"
      "Next:     %p\n"
      "Size:     %ld\n"
      "Status:   %s\n",
      id,
      block, block->prev, block->next,
      block->size,
      block->allocated ? "allocated" : "free"
    );
    block = block->next;
  }
  printf("========================================\n");
};