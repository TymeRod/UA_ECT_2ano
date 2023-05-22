#include <detpic32.h>

void putc1(char byte);
void delay(unsigned int ms);

int main(void)
{
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    // 4 – Enable UART2 (see register U2MODE)
    U1BRG = 10;//((PBCLK + 8 * 100000) / (16 * 100000)) - 1;
    U1MODEbits.BRGH = 0; // Divisão por 16
    U1MODEbits.PDSEL = 0; // 8 bits sem paridade
    U1MODEbits.STSEL = 0; // 1 stop bit
    U1STAbits.UTXEN = 1; // Enable do módulo de transmissão
    U1STAbits.URXEN = 1; // Enable do módulo de receção
    U1MODEbits.ON = 1; // Enable do UART2

    while (1)
    {
        putc1(0x5A);
        delay(10);
    }
}

void putc1(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U1STAbits.UTXBF == 1);
    // Copy "byte" to the U1TXREG register
    U1TXREG = byte;
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < ms * 20000);
}