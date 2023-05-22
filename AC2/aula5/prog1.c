#include <detpic32.h>

void delay(int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);

}



void send2displays(unsigned char value)
{
    static const char display7Scodes[]= {0x3F,0x06,0x5b,0x4F,0x66,0x6D,0x7D,0x27,0x7F,0x6f,0x77,0x7C,0x39,0x5E,0x79,0x71};
    static char displayFlag = 0;

    if(displayFlag == 0){
        // select display high
        LATD = (LATD & 0xFF9F) | 0xFFDF;        //1111 1111 1011 1111
        // send digit_high (dh) to display: dh = value >> 4
        LATB = (LATB & 0x80FF) | (display7Scodes[(value >> 4)] << 8);

        displayFlag = 1;

    }else{
        // select display low
        LATD = (LATD & 0xFF9F) | 0xFFBF;
        // send digit_low (dl) to display: dl = value & 0x0F
        LATB = (LATB & 0x80FF) | (display7Scodes[(value & 0x0F)] << 8);

        displayFlag = 0;

    }

}

int main(void)
{
    // configure RB8-RB14 as outputs
    TRISB = TRISB & 0x80FF;
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;
    int counter = 0; 
    while (1)
    {

        int i = 0;
        do{
            send2displays(counter);
            delay(10);

        }while(i++ < 10);
        counter ++;
        if (counter > 255) counter = 0;

    }

    return 0;
}