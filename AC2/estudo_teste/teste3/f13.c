#include <detpic32.h>

volatile int m;

int main(void){

    U2BRG = (PBCLK + 8 * 9600) / (16 * 9600) - 1;
    U2MODEbits.BRGH = 0; // 16
    U2MODEbits.PDSEL = 0b01; // 8 bits, even parity
    U2MODEbits.STSEL = 0; // 1 stop bit
    U2STAbits.UTXEN = 1; // Enable transmitter
    U2STAbits.URXEN = 1; // Enable receiver
    U2MODEbits.ON = 1; // Enable UART2

    IPC8bits.U2IP = 2;
    IEC1bits.U2RXIE = 1;
    IFS1bits.U2RXIF = 0;

    EnableInterrupts();

    m = 0;

    while(1);
    return 0;

}

void putc(char byte2send){

    while(U2STAbits.UTXBF == 1);
    U2TXREG = byte2send;

}

void putstr(char *str){

    while(*str != '\0'){
        putc(*str);
        str++;
    }

}

void _int_(32) isr_uart2(void){

    if(IFS1bits.U2RXIF == 1){
        char str[10];
        char c;
        int i, j;
        c = U2RXREG;

        putc(c);

        if(c >= 'a' && c <= 'z'){
            m++;
        }

        if(c == 0x0A){

            while(m != 0){
                str[i++] = m % 10 + '0';
                m = m / 10;

            }

            str[i] = '\0';


            putstr("o número de minusculas digitado foi ");
            
            for(j = i - 1; j >= 0; j--){
                putc(str[j]);
            }

            putc('\n');
            m = 0;
        }

        IFS1bits.U2RXIF = 0;
    }



}