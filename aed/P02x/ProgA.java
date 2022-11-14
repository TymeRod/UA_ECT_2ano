/**
Crie um programa em C equivalente a este em Java.

Note que na linguagem C:

- Uma função tem de ser definida (ou declarada) antes da primeira invocação.
- Um array é declarado com uma sintaxe diferente.
- É possível saber a dimensão de um array A usando `sizeof(A)/sizeof(A[0])`
- Quando um array é passado como argumento a uma função,
  a função recebe apenas o ponteiro para o início do array
  e não tem forma de saber quantos elementos tem.
  Por isso é necessário passar também o número de elementos ocupados
  ou ter outra forma de determinar isso (com um terminador, por exemplo).
- Pode concatenar strings usando a função `strcat` ou `strncat` (man:strcat),
  mas se vai apenas imprimir o resultado, é mais simples imprimir as strings
  diretamente com um `printf`.

*/

public class ProgA {
    
    public static void main(String[] args) {
        int[] a = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        printArray("a", a);
        int[] b = new int[a.length];
        cumsum(a, b);
        printArray("b", b);
        
        int[] c = new int[6];
        c[0] = 1;
        printArray("c", c);
        while (c[1] < 10) {
            cumsum(c, c);
            printArray("c", c);
        }
    }

    public static void printArray(String s, int[] a) {
        System.out.print(s + ":");
        for (int i = 0; i < a.length; i++) {
            System.out.print(" " + a[i]);
        }
        System.out.println();
    }

    public static void cumsum(int[] a, int[] b) {
        // Requires: b.length >= a.length
        int c = 0;
        for (int i = 0; i < a.length; i++) {
            c += a[i];
            b[i] = c;
        }
    }
}
