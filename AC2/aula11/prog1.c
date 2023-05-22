#include <detpic32.h>

int main(void)
{

    TRISCbits.TRISC14 = 0; // Configure RD14 to output

    // Configure UART2: 115200, N, 8, 1

    U2ABRG = ((PBCLK + 8 * 115200) / (16 * 115200)) - 1;
    U2MODEbits.BRGH = 0;  // Divisão por 16
    U2MODEbits.PDSEL = 0; // 8 bits sem paridade
    U2MODEbits.STSEL = 0; // 1 stop bit
    U2STAbits.UTXEN = 1;  // Enable do módulo de transmissão
    U2STAbits.URXEN = 1;  // Enable do módulo de receção
    U2MODEbits.ON = 1;      // Enable do UART2



    // Configure UART2 interrupts, with RX interrupts enabled
    // and TX interrupts disabled:
    // enable U2RXIE, disable U2TXIE (register IEC1)
    // set UART2 priority level (register IPC8)
    // clear Interrupt Flag bit U2RXIF (register IFS1)
    // define RX interrupt mode (URXISEL bits)


    IEC1bits.U2RXIE = 1;   // Enable U2RX interrupt
    IEC1bits.U2TXIE = 0;   // Disable U2TX interrupt
    IPC8bits.U2IP = 1;       // Configure priority of interrupts
    IFS1bits.U2RXIF = 0;   // Clear U2RX interrupt flag
    U2STAbits.URXISEL = 0; // Configure U2RX interrupt mode



    // Enable global Interrupts

    



    EnableInterrupts();

    while (1)
        ;
    return 0;
}

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U2STAbits.UTXBF == 1)
        ;
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
}

void _int_(32) isr_uart2(void)
{
    if (IFS1bits.U2RXIF == 1)
    {
        // Read character from FIFO (U2RXREG)
        // Send the character using putc()
        // Clear UART2 Rx interrupt flag
        char c;
        c = U2RXREG;

        putc(c);

        if(c == 'T'){
            LATCbits.LATC14 = 1;
        }else if(c == 't'){
            LATCbits.LATC14 = 0;
        }

        IFS1bits.U2RXIF = 0;
    }
}

