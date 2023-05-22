#include <detpic32.h>

void putc(char byte2send){

    // wait while UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // Copy byte2send to the UxTXREG register
    U2TXREG = byte2send;
}

void delay(int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

void putstr(char *str){

    // use putc() function to send each charater ('\0' should not be sent)
    for(; *str != '\0'; str++)
        putc(*str);

}

char getc(void){
    while(U2STAbits.URXDA == 0); // wait while URXDA == 0
    return U2RXREG; // Return U2RXREG
}


int main(void){

    // Configure UART2:
    // 1 - Configure BaudRate Generator
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    // 4 – Enable UART2 (see register U2MODE)

    // Configure UART2:
    U2BRG = (PBCLK + 8 * 115200) / (16 * 115200) - 1;
    U2MODEbits.BRGH = 0; // 16
    U2MODEbits.PDSEL = 0b00; // 8 bits, no parity
    U2MODEbits.STSEL = 0; // 1 stop bit
    U2STAbits.UTXEN = 1; // Enable transmitter
    U2STAbits.URXEN = 1; // Enable receiver
    U2MODEbits.ON = 1; // Enable UART2

    while(1)
    {
        char a = getc();
        putc(a);

    }

    return 0;

    




}