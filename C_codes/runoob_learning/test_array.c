#include <stdio.h>

int main(void){

    int a[3][3]={{1,2,3},{4,5,6},{7,8,9}};
    for(int i=0;i<3;i++){
        for(int j=0;j<3;j++){
            printf("a[%d][%d]的值是%d\n",i,j,a[i][j]);
        }
    }
}
