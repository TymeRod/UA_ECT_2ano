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

  aStack<int> Stack(50);

	for(i = 0; s[i] != '\0'; i++){


		if(s[i] == '('){

		Stack.push(i);

		} else if(s[i] == ')'){

			if(!Stack.is_empty()){
		
				cout << "'(' at position " << Stack.top() << " and matching ')' at position " << i << endl;
				Stack.pop();

			} else {
				cout << "unmatched ')' at position " << i << endl;
				return -1;
			}
		}
	}

	if(!Stack.is_empty()){
		while(!Stack.is_empty()){
		int position = Stack.top();
		
		cout << "unmatched '(' at position " << position << endl;
		Stack.pop();
	} 
		return -1;
	}

  	return 0;



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
