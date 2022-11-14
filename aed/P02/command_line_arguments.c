//
// Tomás Oliveira e Silva, AED, October 2021
//
// list all command line arguments
//

#include <stdio.h>
#include <stdlib.h>


int IsInteger(char*string)
{
  int possible_integer = (string[0] == '+')||(string[0] == '-')||((string[0]>='0')&&(string[0]<='9'));

  if (possible_integer == 0){
    
    return 0;
  }
  
  for(size_t i = 1; string[i] != '\0';i++){
    if ((string[i] < '0') || (string[i] > '9')){

      return 0;
    }
  }

  return 1;
}

int main(int argc,char *argv[argc])
{
  for(int i = 0;i < argc;i++){
    char* token = argv[i];
    if (IsInteger(token)){
      printf("argv[%2u] = \"%s\" integer value: %d\n", i, token, atoi(token));
    }else {
      printf("argv[%2u] = \"%s\"\n", i, token);
    }
  

}
return 0;
}
