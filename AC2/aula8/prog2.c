#include <detpic32.h>
#define VECTOR 12

int main(void){

    T3CONbits.TCKPS = 7 ;    // 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 39061;            // Fout = 20MHz / (256 * (39061 + 1)) = 2 Hz
    TMR3 = 0;               // Clear timer T3 count register
    T3CONbits.TON = 1;      // Enable timer T3 (must be the last command of the
                            // timer configuration sequence)

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag

    EnableInterrupts();
    while(1);
    return 0;
}


void _int_(VECTOR) isr_T3(void){ 
    putChar('.');
    IFS0bits.T3IF = 0;

}
