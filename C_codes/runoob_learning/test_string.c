#include <stdio.h>
#include <string.h>

int main(){
    char a[20]="Phoenix  ";
    char b[]="Lady Gaga";
    char c[]="ix";
    char d='o';
    char e[20];
    int len;
    int  i;
    int  j;
    

    strcpy(e,a);
    printf("%s\n",e);

    strcat(a,b);
    printf("a b 拼接后为%s\n",a);
    len = strlen(a);
    printf("length of a is %d\n",len);

    i = strcmp(a,b);
    printf("%d-%d=%d\n",a[0],b[0],i);

    // j = strchr(a,'o');
    // printf("'o'在%s第一次出现的位置是%p\n",a,j);

    j = strstr(a,c);
    printf("%s在%s第一次出现的位置是%p\n",c,a,j);

}