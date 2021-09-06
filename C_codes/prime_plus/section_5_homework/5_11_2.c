#include <stdio.h>

int main(void){
    int num,num_10;
    printf("input a number\n");
    scanf("%d",&num);
    num_10 = num+10;
    while (num<num_10){
        printf("%d\t",num);
        num++;
    }
    printf("%d\t",num);


}