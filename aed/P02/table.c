//
// Tomás Oliveira e Silva, AED, October 2021
//
// program to print a table of the squares and square roots of some integers
//
// on GNU/Linux, run the command
//   man 3 printf
// to see the manual page of the printf function
//

#include <math.h>
#include <stdio.h>

void do_it(int N)
{
  int i;
  double angle;
  FILE* file;

  file = fopen("table.txt", "w");

  fprintf(file," n  n*n      sqrt(n)           cos(n)            sin(n)\n");
  fprintf(file,"-- ----- ----------------- ----------------- -----------------\n");
  for(i = 0;i <= N;i++){
    angle = i*(M_PI/180);
    fprintf(file,"%2d %5d %17.15f %17.15f %17.15f\n",i,i * i,sqrt((double)i),cos(angle),sin(angle));
  }

  fclose(file);

}

int main(void)
{   
  do_it(90);
  return 0;
}
