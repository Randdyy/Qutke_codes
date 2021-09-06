#include <stdio.h>

#define MIN_PER_H 60
const int per_h = 60;

int main(void){
    // printf("%d",MIN_PER_H);
    // printf("%d",per_h);
    int mins;

    while(mins>0){
        printf("please input a number of minutes:\n");
        scanf("%d",&mins);
        printf("%d mins is %d hours and %d mins\n",mins,mins/MIN_PER_H,mins%MIN_PER_H);
    }

}