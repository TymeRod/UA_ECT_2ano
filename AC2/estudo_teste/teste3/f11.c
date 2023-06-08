#include <detpic32.h>

void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000000 / ms);
}

int main(void){

    TRISB = TRISB | 0x000F; // RB0-RB3 as input  0000 0000 0000 1111

    TRISE = TRISE & 0xFF00; // RE0-RE7 as output 1111 1111 0000 0000 

    unsigned int count = 0x89FF;

    while(1){
        
        if((count & 0x00FF) >= 0x00FF)
            count = ~PORTB & 0x000F;

        LATE = (LATE & 0xFF00) | count;

        count = count << 1;
        count = count | 0x0001;

        

        delay(1);


    }

}
