#include <stdio.h>
#include <time.h>
#include <stdlib.h> 
 
int * getRandom(){
    static int list[10];
    int i ;

    srand((unsigned)time(NULL));
    for(i=0;i<10;i++){
        list[i] = rand();
        printf("%d\n",list[i]);
    }
    return list;
}

int main(){
    int *p;
    int i;
    p = getRandom();
    // printf("%d\n",*p);
    for (i=0;i<10;i++){
        printf("*(p+[%d])= %d\n",i,*(p+i));
        printf("*p[%d]    =%d\n",i,p[i]);
    }return 0;

}