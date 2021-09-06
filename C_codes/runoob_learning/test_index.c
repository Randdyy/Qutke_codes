#include <stdio.h>
#include <time.h>
 
// void getSeconds(unsigned long *par)
// {
//    /* 获取当前的秒数 */
//    *par = time( NULL );
//    return;
// }
// int main ()
// {
//    unsigned long sec;


//    getSeconds( &sec );

//    /* 输出实际值 */
//    printf("Number of seconds: %ld\n", sec );

//    return 0;
// }


// int main(){
//     float PI = 3.14159;
//     int s1, r = 5;
//     double s2;
//     s1 = r * r * PI;
//     s2 = r * r * PI;
//     (double)s1;
//     printf("s1=%f, s2=%f\n", s1, s2);
//     return 0;
// }


 
/* 函数声明 */
//  double getAverage(int *arr, int size)
// {
//   int    i, sum = 0;      
//   double avg;          
 
//   for (i = 0; i < size; ++i)
//   {
//     sum += arr[i];
//   }
 
//   avg = (double)sum/ size;
 
//   return avg;
// }


// int main ()
// {
//    /* 带有 5 个元素的整型数组  */
//    int balance[5] = {1000, 2, 3, 17, 50};
//    double avg;
 
//    /* 传递一个指向数组的指针作为参数 */
//    avg = getAverage(balance, 5 ) ;
 
//    /* 输出返回值  */
//    printf("Average value is: %f\n", avg );
   
//    return 0;
// }


int main(void){
    int a=20;
    int b=11;
    double c;
    double d=1;

    c = (double)a/b;
    printf("%f\n",c);
    printf("%f\n",d);

}