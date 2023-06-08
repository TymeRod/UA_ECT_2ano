#include <detpic32.h>

volatile int counter;

void putc(char byte){
    while(U2STAbits.UTXBF == 1);
    U2TXREG = byte;
}

void putstr(char *str){

    while(*str != '\0'){
        putc(*str++);   
    }
}



int main(void){

    TRISE = TRISE & 0xFFE1;

    U2BRG = (PBCLK + 8 * 9600) / (16 * 9600) - 1;
    U2MODEbits.BRGH = 0;
    U2MODEbits.PDSEL = 2;
    U2MODEbits.STSEL = 1;
    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;
    U2MODEbits.ON = 1;

    U2STAbits.UTXISEL = 0;
    U2STAbits.URXISEL = 0;
    
    IPC8bits.U2IP = 2;
    IEC1bits.U2RXIE = 1;
    IFS1bits.U2RXIF = 0;

    EnableInterrupts();

    counter = 15;
    
    while(1);
    return 0;

}

void _int_(32) isr_uart2(void){

    char c;
    c = U2RXREG;

    if(c == 'U'){
        if(counter >= 15){
            counter = 0;
        }
        else{
            counter++;
        }

        LATE = (LATE & 0xFFE1) | counter << 1;
    
    }else if(c == 'R'){

        counter = 0;
        LATE = (LATE & 0xFFE1) | counter << 1;


    }




}