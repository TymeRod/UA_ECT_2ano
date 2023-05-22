#include <detpic32.h>

void delay(int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);

}

int main(void){

    TRISEbits.TRISE0 = 0;   // RB4 digital output 
    TRISEbits.TRISE1 = 0;   // RB4 digital output
    LATEbits.LATE0 = 0;     // RB4 = 0
    LATEbits.LATE1 = 0;     // RB4 = 0

    delay(5);
while(1){
    
    PORTEbits.RE0 = !LATEbits.LATE0;
    delay(500);
    LATEbits.LATE1 = !LATEbits.LATE1;
    }
}