#include <stdio.h>

int main(){
    FILE *fp =NULL;
    char buff[255];
    fp = fopen("/Users/chentianbo/Desktop/test.txt","r");
    fscanf(fp,"%s", buff);
    printf("1:%s\n",buff);
    fscanf(fp,"%s", buff);
    printf("2:%s\n",buff);

    fgets(buff,255,(FILE*)fp);
    printf("3:%s",buff);


    fgets(buff,255,(FILE*)fp);
    printf("4:%s",buff);
    fclose(fp);
}