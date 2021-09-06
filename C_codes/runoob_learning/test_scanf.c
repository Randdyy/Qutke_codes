#include <stdio.h>

// int main()
// {
//     int num;
//     char arr[20];
//     char arr2;
//     printf("请输入一个数字:  ");
//     scanf("%d",&num);
//     (num%2==0)? printf("偶数\n"):printf("奇数\n");


//     printf("请输入一个字符串:  ");
//     scanf("%s",arr);
//     printf("%s\n",arr);

//     printf("请输入一个字符串:  ");
//     scanf("%c",arr2);
//     printf("%c\n",&arr2);

// }


// int main(void) {
//     char arr[20];
//     char a;
//     int n;
//     int x=1;

//     printf("Input a number:");

//     scanf("%d", &n);
//     // getchar();

//     printf("Input a char:");

//     scanf("%c", &a);

//     printf("%d %c", n,a);

    
//     return 0;
// }





// int main(void) {
//     char arr[20];
//     char a;
//     int n;

//     printf("Input a number:");
//     scanf("%d", &n);
//     printf("Input a string:");
//     scanf("%s", arr);

//     printf("%d %s", n, arr);

//     return 0;
// }


int A=10;
int B=20;
char buy;
int sum,number;

int main(){
    printf("以下是本店的商品及价格：\n A 商品每个十元；\n B 商品每个二十元；\n\n");
    printf("请输入你所需的产品(A 或 B):");
    scanf("%c",&buy);
    printf("请输入所需的数量：");
    scanf("%d",&number);
    sum=buy=='A'?A*number:B*number;
    printf("\n你所需要的%d个%c商品总共%d元。\n",number,buy,sum);
    return 0;
}