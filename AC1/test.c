#include <stdio.h>

#define SIZE 20

 int main(void)
 {
  static char str[SIZE+1];
  char *p;
  printf("Introduza uma string: \n");
  scanf("%s",str);
  p = str;
  while (*p != '\0')
   {
       *p = *p - 'a' + 'A'; // 'a'=0x61, 'A'=z, 'a'-'A'=0x20
       p++;
   }
  printf("%s\n",str);
  return 0;
}