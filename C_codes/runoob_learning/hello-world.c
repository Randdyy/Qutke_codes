#include <stdio.h>
 int fun()
 { 

    static int x =1;
    x+=1;
    return x;

 }
int main(void)
{
    int i ,s=1;
    for (i=1;i<=5;i++){
        // printf("s:\n");
        s+=fun();
    printf("%d\n",s);
    }
    return 0;
}



