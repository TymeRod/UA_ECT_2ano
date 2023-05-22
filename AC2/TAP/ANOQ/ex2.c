#include <detpic32.h>

#define N 4

void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
    
}

void send2display(unsigned char value){

    static const char display[] = {
                0b0111111, // 0
                0b0000110, // 1
                0b1011011, // 2
                0b1001111, // 3
                0b1100110, // 4
                0b1101101, // 5
                0b1111101, // 6
                0b0000111, // 7
                0b1111111, // 8
                0b1101111, // 9
                0b1110111, // A
                0b1111100, // B
                0b0111001, // C
                0b1011110, // D
                0b1111001, // E
                0b1110001  // F
        };
     LATB = (LATB & 0x80FF) | (display[value + 4] << 8);
}


int main(void){

    TRISBbits.TRISB4 = 1;   // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;  // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;   // Conversion trigger selection bits: in this
                            // mode an internal counter ends sampling and
                            // starts conversion
    AD1CON1bits.CLRASAM = 1;// Stop conversions when the 1st A/D converter
                            // interrupt is generated. At the same time,
                            // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;  // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = N - 1;   // Interrupt is generated after N samples
                            // (replace XX by the desired number of
                            // consecutive samples)
    AD1CHSbits.CH0SA = 4;   // replace x by the desired input
                            // analog channel (0 to 15)
    AD1CON1bits.ON = 1;     // Enable A/D converter
                            // This must the last command of the A/D
                            // configuration sequence

    TRISB  = TRISB & 0x80FF;     //1000 0000 1111 1111
    TRISDbits.TRISD5 = 0;
    TRISDbits.TRISD6 = 0;
    TRISBbits.TRISB3 = 1;
    TRISE = TRISE & 0xFFBD;     //1111 1111 1011 1101

    LATEbits.LATE1 = 0;
    LATEbits.LATE6 = 1;

    while(1){
        AD1CON1bits.ASAM = 1;
        while(IFS1bits.AD1IF == 0);

        int media = 0;
        int *p = (int *) &ADC1BUF0;         
        int i;

        for(i = 0; i < N; i++){

            media += p[i*4];

        }

        media = media / N;
        putChar('\r');
        printInt(~media, 2 | 12 << 16);


        //ii)

        if(PORTBbits.RB3 == 1){
            LATDbits.LATD5 = 1;
            LATDbits.LATD6 = 0;
        } else {
            LATDbits.LATD5 = 0;
            LATDbits.LATD6 = 1;
        }

        int value = (media * 10) / 1023;

        send2display(value);

        //iii)

        LATEbits.LATE1 = !LATEbits.LATE1;
        LATEbits.LATE6 = !LATEbits.LATE6;

        IFS1bits.AD1IF = 0;
        delay(250);


    }


}