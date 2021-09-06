#include <stdio.h>
 
 
 
int main(void)
{
    // extern char a[];
    // char a[6]= "123123";
    // printf("%d\n", *a);
    // printf("%c\n", a[3]);
    // printf("%p\n", *a);
    // int a = 0b00111101;
    // printf("%s\n",a);


    // int b[5] = {1000, 2, 3, 17, 50};
    // int i;
    // for(i=0;i<5;i++){

    //     printf("%d\n",b[i]);

    // }
    // char x[10]="hello";
    // printf("%s\n",x);
    // printf("%p  %p\n",x,&x[0]);
    char *a [ ] = {"China","French","America","German"};
    printf("%p %p %p %p\n",a[0],a[1],a[2],a[3]); //数组元素中保存的地址
    printf("%p %p %p %p\n",&a[0],&a[1],&a[2],&a[3]);//数组元素单元本身的地址
    printf("%s %s %s %s\n",a[0],a[1],a[2],a[3]);//数组元素单元本身的地址
    printf("%p\n", &a);

    char x ="a";
    printf("%p,%p",x,&x);
	
	return 0;	
}
