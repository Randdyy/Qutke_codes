#include <stdio.h>
#include <float.h>
#include <limits.h>
int main(void){
    // unsigned short a = 65535;
    // unsigned short b = a+1;

    // printf("%d+1=%d",a,b);

    int big_int =2147483647;//2的31次方减一
    float big_float = 3.4e38;//浮点数最大值
    float small_float = 10.0/3;  //浮点数有效位数为6位

    printf("big int +1 = %d\n",big_int+1);
    printf("big float *10 = %f\n",big_float);
    printf("small float  = %f\n",small_float);


    printf("the max float data is %f\n",FLT_MAX);
    printf("the max int data is %ld\n",INT_MAX);

    return 0;



}