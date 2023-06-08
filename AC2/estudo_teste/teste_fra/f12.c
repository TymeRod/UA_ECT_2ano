#include <detpic32.h>

#define N 2

volatile unsigned int temp;

void delay(unsigned int hz){
    resetCoreTimer();
    while(readCoreTimer() < PBCLK/hz);
}

void send2displays(unsigned char value){
    const char codes[] = { 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71 };

    static int flag = 0;

    if(flag){

        LATDbits.LATD5 = 1;
        LATDbits.LATD6 = 0;
        LATB = (LATB & 0x80FF) | codes[value % 10] <<8;

    } else {

        LATDbits.LATD5 = 0;
        LATDbits.LATD6 = 1;
        LATB = (LATB & 0x80FF) | codes[value / 10] <<8;

    }

    flag = !flag;

}


int main(void){

    TRISBbits.TRISB4 = 1; // RBx digital output disconnected
    AD1PCFGbits.PCFG4= 0; // RBx configured as analog input
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = N-1; // Interrupt is generated after N samples
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    AD1CON1bits.ON = 1; // Enable A/D converter

    T2CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc = 5Mhz)
    PR2 = 41666;
    TMR2 = 0;
    T2CONbits.TON = 1;

    IPC2bits.T2IP = 2;
    IEC0bits.T2IE = 1;
    IFS0bits.T2IF = 0;

    TRISB = TRISB & 0x80FF; // RB14-RB8 as outputs
    TRISDbits.TRISD5 = 0; // RD5 as output
    TRISDbits.TRISD6 = 0; // RD6 as output

    EnableInterrupts();

    temp = 0;

    while(1){
        AD1CON1bits.ASAM = 1; // Start conversion
        while(IFS1bits.AD1IF == 0); // Wait while conversion not done (AD1IF == 0)

        int *p = (int *)(&ADC1BUF0);
        int i, media;
        for(i = 0, media = 0; i < N; i++){
            media += p[i*4];
        }

        media = media / N;

        temp = (media * 50 + 511)/ 1023 + 15;
        IFS1bits.AD1IF = 0; // Reset AD1IF
        delay(10);

    }
}

void _int_(8) isr_T2(void){

    send2displays(temp);
    IFS0bits.T2IF = 0;
}
