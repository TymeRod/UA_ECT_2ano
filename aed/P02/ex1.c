#include <stdio.h>
#include <stdlib.h>


int main(int argc, char **argv){

    int i,n, count;
    count = 0;
    for(i = 1;i < argc;i++){
        n = atoi(argv[i]);

        do{
            n /=  10;
            count += 1;

        }while(n != 0);

        if(count == 10){
            printf("%d",atoi(argv[i]));
            printf("%s: = ", "count");
            printf("%d \n",count);

        }

        
    }

    return 0;
}