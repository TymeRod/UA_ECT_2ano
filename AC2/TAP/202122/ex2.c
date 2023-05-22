#include <detpic32.h>

#define N 2

void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

void send2display(unsigned char value){

    static const char display[] = {
                    0b0111111, //0
                    0b0000110, //1
                    0b1011011, //2
                    0b1001111, //3
                    0b1100110, //4
                    0b1101101, //5
                    0b1111101, //6
                    0b0100111, //7
                    0b1111111, //8
                    0b1101111  //9
                };


    LATB = (LATB & 0x80FF) | (display[value] << 8);

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

    TRISB = TRISB & 0x80FF;                        
    TRISD = TRISD & 0xFF9F;

    TRISEbits.TRISE1 = 0;
    LATEbits.LATE1 = 0;

    while(1){
        
        AD1CON1bits.ASAM = 1;
        while(IFS1bits.AD1IF == 0);

        //i)
        int media = 0;
        int *p = (int*) &ADC1BUF0;
        int i;
        for(i = 0; i < N; i++){
            media += p[i*4];
        }
        media = media/N;
        printInt(media, 16 | 3 << 16);
        putChar('\n');

        //ii)

        LATDbits.LATD5 = 1;
        LATDbits.LATD6 = 0;

        int value = (media * 9)/ 1023;
        send2display(value);

        //iii)

        LATEbits.LATE1 = !LATEbits.LATE1;


        IFS1bits.AD1IF = 0;
        delay(200);
        
    }
    return 0;
}
