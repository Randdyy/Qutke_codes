#include <stdio.h>
int main(void){
    float x;
    scanf("%f",&x);
    printf("%f\n",x);
    printf("%e\n",x);

    printf("the input is %2.1f or %.1e\n",x,x);
    printf("the input is %+2.3f or %1.3e",x,x);

}