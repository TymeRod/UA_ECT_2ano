#include <detpic32.h>

volatile unsigned char voltage = 0; // Global variable

int main(void)
{
    unsigned int cnt = 0;
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
    AD1CON2bits.SMPI = 7;   // Interrupt is generated after XX samples
                            // (replace XX by the desired number of
                            // consecutive samples)
    AD1CHSbits.CH0SA = 4;   // replace x by the desired input
                            // analog channel (0 to 15)
    AD1CON1bits.ON = 1;     // Enable A/D converter
                            // This must the last command of the A/D
                            // configuration sequence


    // Configure interrupt system

    IPC6bits.AD1IP = 2;     //configure priority of A/D interrupts
    IFS1bits.AD1IF = 0;     // clear A/D interrup flag
    IEC1bits.AD1IE = 1;     // enable A/D interrupts

    EnableInterrupts(); // Global Interrupt Enable

    while(1) // all activity is done by the ISR
    {
        if(cnt == 0){
            AD1CON1bits.ASAM = 1;
        }

        //send "voltage" value to displays
        
        cnt = (cnt + 1) % 25;
        delay(10);


    }
    return 0;
}


void _int_(27) isr_adc(void){
    
    int *p = (int *)(&ADC1BUF0);
    int i;
    for(i = 0; i < 8; i++){
        printInt(p[i*4], 10 | 4 << 16);   // Read conversion result (ADC1BUF0 value) and print it
        putChar(' ');
    }
    
    
    IFS1bits.AD1IF = 0;                // Reset AD1IF flag
    AD1CON1bits.ASAM = 1;       // Start conversion
}
