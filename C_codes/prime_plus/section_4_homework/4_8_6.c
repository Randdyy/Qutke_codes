#include <stdio.h>
#include <string.h>

int main(){
    char name[20],first_name[20];
    int width_name,width_first;

    printf("input your name\n");
    scanf("%s",name);
    printf("input your first name\n");
    scanf("%s",first_name);
    width_name = strlen(name);
    width_first = strlen(first_name);


    printf("%s %s\n",first_name,name);
    printf("%*d %*d\n",width_first,width_first,width_name,width_name);

    printf("%s %s\n",first_name,name);
    printf("%-*d %-*d\n",width_first,width_first,width_name,width_name);
}