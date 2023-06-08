#include <detpic32.h>

#define NSamples 4

void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000000 / ms);
}

void send2displays(unsigned char value)
{
    static const char display7Scodes[] = { 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71 };
    
    static char displayFlag = 0;

    unsigned char dh = value >> 4;      // Get the index of the decimal part
    unsigned char dl = value & 0x0F;    // Get the index of the unitary part
    
    // Get the correct hex code for the number
    dh = display7Scodes[dh];
    dl = display7Scodes[dl];

    if (displayFlag == 0) {
        LATD = (LATD | 0x0040) & 0xFFDF;    // Dipslay High active and Display Low OFF
        LATB = (LATB & 0x80FF) | ((unsigned int)(dh)) << 8; // Clean the display and set the right value
    } else {
        LATD = (LATD | 0x0020) & 0xFFBF;    // Display High OFF and Display High active
        LATB = (LATB & 0x80FF) | ((unsigned int)(dl)) << 8; // Clean the display and set the right value
    }

    displayFlag = !displayFlag;
}

unsigned char toBcd(unsigned char value) 
{
    return ((value / 10) << 4) + (value % 10);
}



volatile int value_LED = 0;
volatile int value_7seg = 0;
volatile int counter = 0;

int main(void){

    TRISE = TRISE & 0xFF00; // RE0-RE7 as output 1111 1111 0000 0000 

    TRISB = TRISB & 0x80FF;         // RB14 to RB8 as output
    TRISD = TRISD & 0xFF9F;         // Displays high/low as output

    TRISBbits.TRISB4 = 1;       // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;      // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;       // Conversion trigger constant
    AD1CON1bits.CLRASAM = 1;    // Stop conversion when the 1st A/D converter intetupr is generated.
                                // At the same time, hardware clears ASAM bit
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100ns)
    AD1CON2bits.SMPI = 7;       // Interrupt is generated after 8 samples
    AD1CHSbits.CH0SA = 4;       // analog channel input 4
    AD1CON1bits.ON = 1;         // Enable the A/d configuration sequence

    IPC6bits.AD1IP = 2;			// configure priority of A/D interrupts to 2
    IFS1bits.AD1IF = 0;			// clear A/D interrupt flag
    IEC1bits.AD1IE = 1;			// enable A/D interrupts

    
    T2CONbits.TCKPS = 2;
    PR2 = 49999;
    TMR2 = 0;
    T2CONbits.TON = 1;

    IPC2bits.T2IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T2IE = 1; // Enable timer T2 interrupts
    IFS0bits.T2IF = 0; // Reset timer T2 interrupt flag

    EnableInterrupts();     // Global Interrupt Enable


    AD1CON1bits.ASAM = 1;


    while(1);
    return 0;
}

void _int_(27) isr_adc(void){

    int *p = (int *)(&ADC1BUF0);
    int i, val_ad = 0;
    for(i = 0; i < NSamples; i++){
        val_ad += p[i*4];
    }

    val_ad = val_ad / NSamples;

    int value;
    value_7seg = (val_ad * 15 + 511) /1023;
    value_7seg = value_7seg + 1;

    value_LED = (val_ad * 7 + 511)/ 1023;
    value_LED = value_LED + 1;

    switch(value_LED){
        case 1:
            value = 0x0001;
            break;
        case 2:
            value = 0x0003;
            break;
        case 3:
            value = 0x0007;
            break;
        case 4:
            value = 0x000F;
            break;
        case 5:
            value = 0x001F;
            break;
        case 6:
            value = 0x003F;
            break;
        case 7:
            value = 0x007F;
            break;
        case 8:
            value = 0x00FF;
            break;
        default:
            value = 0x0001;
            break;
        }

    LATE = (LATE & 0xFF00) | value;
    IFS1bits.AD1IF = 0;                // Reset AD1IF flag

    
}

void _int_(8) isr_T2(void){
    send2displays(toBcd(value_7seg));
    if(counter == 10){
        AD1CON1bits.ASAM = 1;
        counter = 0;
    }
    counter++;
    IFS0bits.T2IF = 0;          // Reset T2IF flag
}



