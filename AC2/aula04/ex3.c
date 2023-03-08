#include <detpic32.h>

int main(void)
{

    TRISB = TRISB & 0x80FF; // 1000 0000 1111 1111
    TRISD = TRISD & 0xFF9F; // 1111 1111 1001 1111

    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;

    while (1)
    {

        char letra = getChar();
        putChar(letra);

        switch (letra)
        {
        case 'A':
            LATB = LATB & 0xFEFF; // 1111 1110 1111 1111
            break;
        }
    }
}