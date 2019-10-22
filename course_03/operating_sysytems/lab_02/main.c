#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "src/allocator.h"

void print_array(int *array, int size) {
    printf("[");
  for (int j = 0; j < size; j++) {
    printf(" %i ", array[j]);
  }
  printf("]\n");
}

int main (int argc, char *argv[]) {
  srand(time(NULL));
  mem_pool_alloc();
  int number_of_arrays = rand() % 4 + 1;
  int **arrays = malloc(number_of_arrays * sizeof(int *));
  int arrays_size[number_of_arrays];

  printf("               ALLOC\n");
  for (int i = 0; i < number_of_arrays; i++) {
    arrays_size[i] = rand() % 65 + 1;
    arrays[i] = mem_alloc(arrays_size[i] * sizeof(int));

    printf("Alloc array №%i with size %i.\n", i, arrays_size[i]);
    for (int j = 0; j < arrays_size[i]; j++) {
      arrays[i][j] = rand() % 100;
    }
    print_array(arrays[i], arrays_size[i]);
    
    mem_dump();
  }

  printf("               REALLOC\n");
  for (int i = 0; i < number_of_arrays; i++) {
    size_t new_size = rand() % 65 + 1;
    printf("Realloc array №%i with size %i to size %ld.\n", i, arrays_size[i], new_size);
    arrays_size[i] = new_size;
    arrays[i] = mem_realloc(arrays[i], new_size * sizeof(int));
    print_array(arrays[i], arrays_size[i]);
    mem_dump();
  }

  printf("               FREE\n");
  for (int i = 0; i < number_of_arrays; i++) {
    printf("Free array №%i with size %i.\n", i, arrays_size[i]);
    print_array(arrays[i], arrays_size[i]);
    mem_free(arrays[i]);
    mem_dump();
  }
  mem_pool_free();
  return 0;
}
