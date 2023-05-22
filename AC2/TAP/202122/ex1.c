#include <detpic32.h>

void delay(int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);

}

int main(void){

    unsigned int x, value;
    TRISE = TRISE & 0xFFC0;     //RE0 - RE5 config as output
    TRISBbits.TRISB2 = 1;

    value = 1;

    while(1){

        LATE = (LATE & 0xFFC0) | value;    

        value = value << 1;

        if(value == 0b100000){
            value = 1;
        }

        if(PORTBbits.RB2 == 1){
            x = 1000/7;  
        } else{
            x = 1000/3;    
        }

        delay(x);
    }

    return 0;

}

