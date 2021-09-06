#include <stdio.h>
#include <stdlib.h>
 

 int times=3;

 int main(void){
     int *ptr;
     int i;
     int data_list[] = {10,100,1000};
     int *x;
     x = data_list;
     printf("x:%p\n",x);
     printf("x:%d\n",*x);

    //  ptr = &data_list[0];
    //  for (i=0;i<times;i++){
    //      printf("存储地址[%d]=%p\n",i,ptr);
    //      printf("存储内容[%d]=%d\n",i,*ptr);
    //      ptr++;
    //  }
     return 0;
 }

