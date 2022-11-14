#include <stdio.h>

void PrintArray(char s[], int a[], size_t n){
    printf("%s%c\n", s, ':'); 

    
    for (size_t i = 0; i < n ;i++){
        printf("%d ", a[i]);

    }
    printf("\n");
}

void CumulativeSum(int a[], int b[], size_t n){
    int c = 0;

    for(size_t i=0; i < n; i++){
        c+= a[i];

        b[i] = c;
    }
}

int main(void){
    int a[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    size_t size = 12;

    PrintArray("a", a, size);

    int b[size];

    CumulativeSum(a, b, size); 

    PrintArray("b", b, size);

    return 0;
}