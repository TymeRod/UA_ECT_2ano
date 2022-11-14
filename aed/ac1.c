#define SIZE 10
#define TRUE 1
#define FALSE 0
void main(void)
{
    static int lista[SIZE];
    int houveTroca, i, aux; // declara um array de inteiros
    // residente no segmento de dados
    static char str[]="\nIntroduza um numero: ";
    int *p;

    for(p = lista; p < lista + SIZE; p++)
    {
        print_string(str);
        *p = read_int();
    }

do
{
    houveTroca = FALSE;
    for (i=0; i < SIZE-1; i++)
    {
        if (lista[i] > lista[i+1])
        {
            aux = lista[i];
            lista[i] = lista[i+1];
            lista[i+1] = aux;
            houveTroca = TRUE;
        }
    }
} while (houveTroca==TRUE);



    static int lista[]={8, -4, 3, 5, 124, -15, 87, 9, 27, 15};
    // Declara um ponteiro para inteiro (reserva
    // espaço para o ponteiro, mas não o inicializa)
    print_string("\nConteudo do array:\n");
    for(i = 0; i < SIZE; i++)
    {
        print_int10( lista[i] ); // Imprime o conteúdo da posição do
        // array cujo endereço é "p"
        print_string("; ");
    }
}