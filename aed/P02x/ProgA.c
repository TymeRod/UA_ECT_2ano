#include <stdio.h>

void PrintArray(char s[],int a[],size_t size){
    printf("%s%c",s,':');

    for(size_t i = 0; i < size; i++){
        printf("%d ",a[i]);
    }
    printf("\n");


}

void cumsum(int a[], int b[], size_t size){
    int c = 0;

    for(size_t i = 0; i < size; i++){
        c += a[i];

        b[i] = c;
    }

}

int main(void){

    int a[12]= {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    size_t size = 12;
    PrintArray("a", a, size);

    int b[size];
    cumsum(a, b, size);
    PrintArray("b", b, size);

    int c[6] = {0};
    c[0] = 1;
    PrintArray("c",  c, (size_t)6);

    while (c[1] < 10){
        cumsum(c,c,(size_t)6);
        PrintArray("c",c,(size_t)6);
    }
    


    return 0;
}
