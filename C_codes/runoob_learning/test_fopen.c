#include <stdio.h>
 
int main()
{
   FILE *fp = NULL;
   char abc[] = "abcdefg";
 
   fp = fopen("/Users/chentianbo/Desktop/test.txt", "w+");
   fprintf(fp, "This is testing for fprintf...\n %s",abc);
   fputs("This is testing for fputs...\n", fp);
   fclose(fp);
}
