#include <stdio.h>



int insert_sort(int array[],int len){

    int current,tmp;

    for(int i=1;i<len;i++){
        current = array[i];
        while(current<array[i-1]){
            array[i]=array[i-1];
            i--;
            if(i==-1){
                break;
            }
        }
        array[i]=current;
        printf("第%d次排序 ",i);

        for(int x=0;x<len;x++){
        printf("%d ",array[x]);

    }
    printf("\n",i);

}}




int main(){
    int len;

    int arr[] = { 22, 34, 3, 32, 82, 55, 89, 50, 37, 5, 64, 35, 9, 70 };
    len = (int)sizeof(arr)/(int)sizeof(*arr);
    insert_sort(arr,len);
    for (int i=0;i<len;i++){
        printf("%d ",arr[i]);
    }
    return 0;

}