#include <stdio.h>
 
// int main( )
// {
//    int c;
 
//    printf( "Enter a value :");
//    c = getchar( );
 
//    printf( "\nYou entered: ");
//    putchar( c );
//    printf( "\n");
//    return 0;
// }


int main( )
{
   char str[100];
 
   printf( "Enter a value :");
   gets( str );
 
   printf( "\nYou entered: ");
   puts( str );
   return 0;
}
