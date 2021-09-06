#include <stdio.h>

// int main()
// {
//     int a;
//     printf("input integer number: ");
//     scanf("%d",&a);
//     switch(a)
//     {
//         case 1:printf("Monday\n");
//         break;
//         case 2:printf("Tuesday\n");
//         break;
//         case 3:printf("Wednesday\n");
//         break;
//         case 4:printf("Thursday\n");
//         break;
//         case 5:printf("Friday\n");
//         break;
//         case 6:printf("Saturday\n");
//         break;
//         case 7:printf("Sunday\n");
//         break;
//         case 8:printf("星期八休息");
//         break;
//         default:printf("error\n");
//     }
// }

int main(){
    int a='ye';
    printf("16进制 %x\n",a);
    printf("10进制 %d\n",a);


    char b[]="y";
    printf("1 %p\n",b);
    printf("2 %x\n",b);

    printf("3 %p\n",&b);
    printf("4 %x\n",&b);

    }

