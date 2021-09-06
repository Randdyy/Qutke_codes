#include <stdio.h>

int main(void){
    int age;
    printf("please input your age:");
    scanf("%d",&age);
    printf("your age in seconds is %e seconds",age*3.156e7);
}