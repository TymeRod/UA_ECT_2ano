#include <detpic32.h>

void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void){

    TRISE = TRISE & 0xFF03;    //1111 1111 0000 0011
    
    TRISB = TRISB | 0x0005;    //0000 0000 0000 0101

    int value = 0b110000;
    double x = 1000.0/10.5;

    while(1){
        LATE = (LATE & 0xFF03) | (value << 2);


        value = value >> 1;
        
       if(value <= 1) value = 0b110000;

        if(PORTBbits.RB2 == 1 && PORTBbits.RB0 == 1){
            x = 1000.0/3.5;
        } else if (PORTBbits.RB2 == 0 && PORTBbits.RB0 == 0){
            x = 1000.0/10.5;
        }
        
        delay( (int) x);
    }

    return 0;

}
