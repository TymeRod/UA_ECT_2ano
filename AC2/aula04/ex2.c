#include <detpic32.h>

int delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < ms*20000);
}



int main(void){

    TRISE = TRISE & 0xFF87; // 1111 1111 1000 0111

    int count = 0;

    while(1){

        LATE = (LATE & 0xFF87) | (count << 3); // 1111 1111 1000 0111

        // LATE = LATE | (count << 3);

        delay(250);

        count = (count + 1) % 10;
    }

    return 0;

}