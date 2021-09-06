#include <stdio.h>

int  main(void){
    int a = 0X3;
    printf("%#X\n",a);
    printf("%X\n",a);

    double b= 2.34E07;
    printf("%e\n",b);

    float c = 0x5.b6p12;
    printf("%a",c);


    int d = 012;
    printf("%d\n",d);

    long double e = 2.9e05L;
    printf("%Le",e);

}