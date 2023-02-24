int main(void)
{
int counter = 0;
int i = 0;
int k = 0;
while(1)
{
    resetCoreTimer();




    while(readCoreTimer() < 2000000);
    printInt(counter++, 10 | 4 << 16); // Ver nota1
    putChar('\r'); // cursor regressa ao inicio da linha

    while(readCoreTimer() < 4000000);
    putChar('\n');
    printInt(counter++, 10 | 4 << 16); // Ver nota1
    putChar('\r'); // cursor regressa ao inicio da linha

    while(readCoreTimer() < 20000000);
    putChar('\n');
    printInt(counter++, 10 | 4 << 16); // Ver nota1
    putChar('\r'); // cursor regressa ao inicio da linha


    }
return 0;
}