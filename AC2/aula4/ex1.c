#include <detpic32.h>
int main(void)
    {
    // Configure port RC14 as output
    TRISCbits.TRISC14 = 0;
    //TRISC = TRISC & 0xBFFF;
    LATCbits.LATC14 = 0;
    while(1)
    {
        // Wait 0.5s
        resetCoreTimer();
        while(readCoreTimer() < 10000000);

        // Toggle RC14 port value
        LATCbits.LATC14 = !LATCbits.LATC14;
        //LATC = LATC ^ 0x4000;

    }
    return 0;
}