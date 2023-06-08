#include <detpic32.h>

void DutyCycle(unsigned int dc){
    OC1RS = ((PR2 + 1)*dc)/100;
}



int main(void){

    TRISB = TRISB | 0x0009; // RB0 e RB3 como entrada

    T2CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc = 5Mhz)
    PR2 = 33332; // Fout = 20Mhz / (4 * (49999 + 1)) = 100 Hz
    TMR2 = 0; // Reset timer T2 count register
    T2CONbits.TON = 1; // Enable timer T2 (must be the last command of the timer configuration sequence)

    OC1CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 0; // Use timer T2 as the time base for PWM generation
    DutyCycle(25);
    OC1CONbits.ON = 1; // Enable OC1 module

    while(1){
        unsigned int value = PORTB & 0x0009;
        if(value == 0x0001){
            DutyCycle(25);
        }
        else if(value == 0x0008){
            DutyCycle(70);
        }

        resetCoreTimer();
        while(readCoreTimer() < 5000);
    }

    return 0;
}
