#include <stdio.h>
// int main()
// {
    // unsigned short int a=32767,b=a+1;//定义短整型无符号
    // printf("a=%u\nb=%u\n",a,b);//以无符号输出
    // return 0;



//     short int a=32767,b,c,d;//定义无符号类型。
// b=a+1;
// c=a+2;
// d=a+3;
//    printf("a=%d\nb=%d\nc=%d\nd=%d\n",a,b,c,d);

//    int a=75;
//    printf("%c",a);


// }
static void func(unsigned char uc)
{
    char c;
    int i, j;
    unsigned int ui, uj;

    c = uc;
    i = (int)c;
    j = (int)uc;
    ui = (unsigned int)c;
    uj =(unsigned int)uc;
    printf("%%c: %c, %c\n", c, uc);
    printf("%%x: %x, %x\n", c, uc);
    printf("%%u: %u, %u\n", ui, uj);
    printf("%%d: %d, %d\n", i, j);
    printf("\n");
}

int main(int argc, char *argv[])
{
    func(0x80);//128
    func(0x7f);
    func(0x7e);
    return 0;
}
