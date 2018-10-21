#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>


void simple_bug(FILE* f) {
  size_t len;

  size_t n = fscanf(f, "%lu", &len);
  if (n != 1) {
    printf("No length\n");
    return;
  }

  char* buf = malloc(len+1);
  size_t bytes = fread(buf, 1, len, f);
  if (bytes != len) {
    printf("Wrong data length (%lu != %lu)\n", bytes, len);
    return;
  }

  printf("%s\n", buf);
}



int main(int argc, const char** argv) {

  FILE* fd = fopen(argv[1], "r");

  simple_bug(fd);

  fclose(fd);

}
