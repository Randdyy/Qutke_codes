#include <stdio.h>

int main(void){
    int days,week_day;
    while (days>0){
        printf("input a number of days\n");

        scanf("%d",&days);

        printf("%d days is %d weeks and %d days\t",days,days/7,days%7);
    }


}