#include <detpic32.h>

int main(void)
{
    // Configure all (digital I/O, analog input, A/D module)
    TRISBbits.TRISB4 = 1;   // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;  // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;   // Conversion trigger selection bits: in this
                            // mode an internal counter ends sampling and
                            // starts conversion
    AD1CON1bits.CLRASAM = 1;// Stop conversions when the 1st A/D converter
                            // interrupt is generated. At the same time,
                            // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;  // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 3;   // Interrupt is generated after XX samples
                            // (replace XX by the desired number of
                            // consecutive samples)
    AD1CHSbits.CH0SA = 4;   // replace x by the desired input
                            // analog channel (0 to 15)
    AD1CON1bits.ON = 1;     // Enable A/D converter
                            // This must the last command of the A/D
                            // configuration sequence

    TRISDbits.TRISD11 = 0;  // RD11 configured as output
    LATDbits.LATD11 = 0;    // reset RD11


    // Configure interrupt system

    IPC6bits.AD1IP = 2;     //configure priority of A/D interrupts
    IFS1bits.AD1IF = 0;     // clear A/D interrup flag
    IEC1bits.AD1IE = 1;     // enable A/D interrupts

    EnableInterrupts(); // Global Interrupt Enable
    // Start A/D conversion
    AD1CON1bits.ASAM = 1;


    
    while(1) // all activity is done by the ISR
        LATDbits.LATD11 = 0;        // set RD11 (LATD11 = 1)
    return 0;
}


void _int_(27) isr_adc(void){
    volatile int adc_value;
    //reset RD11 (LATD11 = 0)
    LATDbits.LATD11 = 0;

    adc_value = ADC1BUF0;

    AD1CON1bits.ASAM = 1;       // Start conversion
    IFS1bits.AD1IF = 0;         // Reset AD1IF flag
    LATDbits.LATD11 = 1;        // set RD11 (LATD11 = 1)

    
}
