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
        case 'A' | 'a':
            LATB = (LATB & 0x80FF)| 0x0100; 
            break;

        case 'B' | 'b':
            LATB = (LATB & 0x80FF) | 0x0200;
            break;

        case 'C' | 'c':
            LATB = (LATB & 0x80FF) | 0x0400;
            break;

        case 'D' | 'd':
            LATB = (LATB & 0x80FF) | 0x0800;
            break;

        case 'E' | 'e':
            LATB = (LATB & 0x80FF) | 0x1000;
            break;

        case 'F' | 'f':
            LATB = (LATB & 0x80FF) | 0x2000;
            break;
        
        case 'G' | 'g':
            LATB = (LATB & 0x80FF) | 0x4000;
            break;
        }
        
    }
    return 0;
}