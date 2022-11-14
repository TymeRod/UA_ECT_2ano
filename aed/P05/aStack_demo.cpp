//
// Tomás Oliveira e Silva, AED, November 2021
//
// matched-parenthesis verification
//

#include <iostream>
#include <string.h>
#include "aStack.h"

using std::cout;
using std::cerr;
using std::endl;

int check_parenthesis(const char *s)
{
  // put your code here (20 lines of code should be enough)
  int i = 0;
  
  aStack<char> Stack(50);
  int Bopen = 0;
  int Bclose = 0;

  for(i = 0; s[i] != '\0'; i++){

    if(s[i] == '('){
      
      Bopen++;
    }

    if(s[i] == ')'){
      Bclose++;
    }

    
  }

  if(Bopen == Bclose){
    return 0;

  } else {
    return 1;

  }


  return -1;
}

int main(int argc,char **argv)
{
  if(argc == 1)
  {
    cerr << "usage: " << argv[0] << " [arguments...]" << endl;
    cerr << "example: " << argv[0] << " 'abc(def)ghi' 'x)(y'" << endl;
    return 1;
  }
  for(int i = 1;i < argc;i++)
  {
    cout << argv[i] << endl;
    if(check_parenthesis(argv[i]) == 0)
      cout << "  good" << endl;
    else
      cout << "  bad" << endl;
  }
  return 0;
}
