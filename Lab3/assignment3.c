#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
  float sum = 0;
  if(argc > 1) {
    for(int i = 0; i < 23; i++) {
      int x = argv[1][i] - '0';
      sum += x * (2 ^ (-1 * (23 - i)));
      printf("%d\n",argv[1][i] * (2 ^ (-i)));
    }
    printf("%f\n",sum);
  }
}
