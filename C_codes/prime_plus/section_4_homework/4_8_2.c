#include <stdio.h>
#include <string.h>

int main(void){

    char name[20];
    int width;
    printf("please input a name\n");
    scanf("%s",name);
    width = strlen(name)+3;
    printf("your name is \" %s \"\n",name);
    printf("your name is \"%20s\"\n",name);
    printf("your name is \"%-20s\"\n",name);
    printf("your name is \"%*s\"\n",width,name);


}