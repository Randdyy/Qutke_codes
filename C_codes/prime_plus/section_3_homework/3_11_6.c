#include <stdio.h>
int main(void){
    float weight;

    printf("input weight of water(quark) :");
    scanf("%f",&weight);
    printf("the water %f quark transform to gram is %fg\n",weight,950*weight);
    printf("the number of hydrone is %e",(950*weight)/3.0e-23);

}