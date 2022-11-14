#include <stdio.h>
#include <stdlib.h>

void main(void)
{
    int soma, value, i;
    for(i=0, soma=0; i < 5; i++)
    {
        printf("Introduza um numero: ");
        value = read_int();
        if(value > 0)
            soma = soma + value;
        else
        printf("Valor ignorado\n");
    }
    printf("A soma dos positivos e': ");
    printf(soma);
}