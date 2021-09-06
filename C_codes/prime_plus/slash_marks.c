#include <stdio.h>

int main(void){

    float salary;
    printf("\a enter a number");
    printf("$_____\b\b\b");
    scanf("%f",&salary);
    printf("\n\t$%.2f a mounth is %.2f a year",salary,salary*12);
    printf("\rGree!\n");
}