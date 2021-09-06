#include <stdio.h>


int get_jiecheng(int start_num){

    int i ;
    i = start_num;

    while(i>1){
        i--;

        start_num = start_num*i;

    }
    return start_num;
}


int factorial(int i){
    if (i<=1){
        return 1;
    }
    return i*factorial(i-1);
}



int fibonaci(int i){ //斐波那契
    if(i==0){
        return 0;
    }else if (i==1)
    {
        return 1;
    }
    return fibonaci(i-2)+fibonaci(i-1);
    
    
}


int main(){
    int s,result,result2,result3;
    s=10;
    result = get_jiecheng(s);
    result2 = factorial(s);

    printf("%d 的阶乘 = %d\n",s,result);
    printf("递归法 ：%d 的阶乘 = %d\n",s,result2);



    for(int i=0;i<s;i++){
        result3 = fibonaci(i);
        printf("递归法 ：%d 的斐波那契 = %d\n",s,result3);
    }


    return 0;


}