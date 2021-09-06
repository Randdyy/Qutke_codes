#include <stdio.h>
int main(void){
    float speed,size;

    printf("input a speed of download !\n");
    scanf("%f",&speed);
    printf("input size of file !\n");
    scanf("%f",&size);
    printf("At %.2f megabits per second, a file of %.2f megabytes\ndownloads in %.2f seconds",speed,size,(size*8)/speed);


}