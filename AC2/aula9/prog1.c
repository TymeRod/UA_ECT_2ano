#include <detpic32.h>

void delay(int ms);
int voltageConversion(int VAL_AD);
void send2displays(unsigned char value);
unsigned char toBcd(unsigned char value);

volatile int voltage = 0;

int main(void)
{

    configureAll();
    IFS1bits.AD1IF = 0;                     // Reset AD1IF
    IFS0bits.T1IF = 0;
    IFS0bits.T3IF = 0;

    EnableInterrupts();

    int  i, sum, j = 0;

    while (1)
    {
        if (j == 0)
        {
            sum = 0;
            AD1CON1bits.ASAM = 1;               // Start conversion
            while ( IFS1bits.AD1IF == 0 );      // Wait while conversion not done
            
            int *p = (int *)(&ADC1BUF0);

            for (i = 0; i < 5; i++)             // Get the values for the 5 samples
            {
                sum += p[i*4];                  // Sum the values of the 5 buffers
            }

            voltage = voltageConversion(sum) / 5;   //Average the voltage value to decimal
        }
        send2displays(toBcd(voltage));          // Print the value in BCD

        delay(10);                              // wait 10ms
        j = (j + 1) % 25;
        IFS1bits.AD1IF = 0;                     // Reset AD1IF
    }
    
    return 0;
}

void send2displays(unsigned char value)
{
    static const char display7Scodes[] = {
                                        0x3F, //0
                                        0x06, //1
                                        0x5B, //2
                                        0x4F, //3
                                        0x66, //4
                                        0x6D, //5
                                        0x7D, //6
                                        0x07, //7
                                        0x7F, //8
                                        0x6F, //9
                                        0x77, //A
                                        0x7C, //b
                                        0x39, //C
                                        0x5E, //d
                                        0x79, //E
                                        0x71  //F
                                        };
    
    static char displayFlag = 0;

    unsigned char dh = value >> 4;      // Get the index of the decimal part
    unsigned char dl = value & 0x0F;    // Get the index of the unitary part
    
    // Get the correct hex code for the number
    dh = display7Scodes[dh];
    dl = display7Scodes[dl];
    
    if (displayFlag == 0)
    {
        LATD = (LATD | 0x0040) & 0xFFDF;    // Dipslay High active and Display Low OFF
        LATB = (LATB & 0x80FF) | ((unsigned int)(dh)) << 8; // Clean the display and set the right value
    } else {
        LATD = (LATD | 0x0020) & 0xFFBF;    // Display High OFF and Display High active
        LATB = (LATB & 0x80FF) | ((unsigned int)(dl)) << 8; // Clean the display and set the right value
    }

    displayFlag = !displayFlag;
}

int voltageConversion(int VAL_AD)
{
    return (VAL_AD * 33 + 511) / 1023;
}

unsigned char toBcd(unsigned char value) 
{
    return ((value / 10) << 4) + (value % 10);
}

void delay(int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < ms * 20000);
}


void configureAll(){


    T1CONbits.TCKPS = 6 ;    // 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR1 = 62499;            // Fout = 20MHz / (256 * (62499 + 1)) = 2 Hz
    TMR1 = 0;               // Clear timer T3 count register
    T1CONbits.TON = 1;      // Enable timer T3 (must be the last command of the
                            // timer configuration sequence)

    IPC1bits.T1IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1; // Enable timer T2 interrupts
    IFS0bits.T1IF = 0; // Reset timer T2 interrupt flag

    T3CONbits.TCKPS = 2 ;    // 1:32 prescaler (i.e. fout_presc = 625 KHz)
    PR3 = 49999;            // Fout = 20MHz / (256 * (62499 + 1)) = 2 Hz
    TMR3 = 0;               // Clear timer T3 count register
    T3CONbits.TON = 1;      // Enable timer T3 (must be the last command of the
                            // timer configuration sequence)

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag


    TRISBbits.TRISB4 = 1;       // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;      // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;       // Conversion trigger constant
    AD1CON1bits.CLRASAM = 1;    // Stop conversion when the 1st A/D converter intetupr is generated.
                                // At the same time, hardware clears ASAM bit
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100ns)
    AD1CON2bits.SMPI = 4;       // Interrupt is generated after 5 samples
    AD1CHSbits.CH0SA = 4;       // analog channel input 4
    AD1CON1bits.ON = 1;         // Enable the A/d configuration sequence

    TRISB = TRISB & 0x80FF;         // RB14 to RB8 as output
    TRISD = TRISD & 0xFF9F;         // Displays high/low as output

}

void _int_(4) isr_T1(void)
{
    AD1CON1bits.ASAM = 1;               // Start conversion
     while ( IFS1bits.AD1IF == 0 );      // Wait while conversion not done

// Start A/D conversion
// Reset T1IF flag
}