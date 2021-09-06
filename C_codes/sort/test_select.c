#include <stdio.h>

int select_sort(int array[],int len){
    int temp;


    for(int i=0;i<len;i++){
        // temp_num = array[i];
        for(int j=i+1;j<len;j++){

            if(array[j]<array[i]){
                temp=array[i];
                array[i]=array[j];
                array[j]=temp;
            }
        }
        printf("第%d次排序 ",i);

        for(int x=0;x<len;x++){
        printf("%d ",array[x]);

    }
        printf("\n",i);

        
    }
        


}






int main(){
    int len ;


    int arr[] = { 22, 34, 3, 32, 82, 55, 89, 50, 37, 5, 64, 35, 9, 70 };
    len  = (int) sizeof(arr)/(int)sizeof(*arr);

    select_sort(arr,len);

    for(int i=0;i<len;i++){
        printf("%d ",arr[i]);
    }

    return 0;
}