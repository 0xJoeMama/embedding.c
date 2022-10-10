#include <stdio.h>
#include <errno.h>
#include <string.h>

extern const char _binary_cat_pic_jpg_start;
extern const char _binary_cat_pic_jpg_end;

typedef struct {
  const char* ptr;
  const int size;
} cat_pic;

void close_file(FILE* fd) {
  if (fclose(fd) == EOF) {
    fprintf(stderr, "Could not close file: %s", strerror(errno));
  }
}

int main(void) {
  const cat_pic pic = {
    .ptr = &_binary_cat_pic_jpg_start,
    .size = &_binary_cat_pic_jpg_end - &_binary_cat_pic_jpg_start
  };

  FILE* fd = fopen("./new_file.jpg", "w+");

  if (fd == NULL) {
    fprintf(stderr, "Error: %s", strerror(errno));
    return -1;
  }

  if (fwrite(pic.ptr, 1, pic.size, fd) != pic.size) {
    fprintf(stderr, "Error: Could not write the whole file!");
    close_file(fd);

    return -1;
  }

  printf("Successfully wrote : %d bytes!\n", pic.size);

  close_file(fd);
  return 0;
}
