#include <stdio.h>

int main() {
	int a = 1; 
	char b ='G'; 
	double c = 3.14; 

	//printing the variables defined above along with their sizes 
	printf("Character:\n");
	printf("\tValue: %c, Size: %lu byte.\n", b,sizeof(char)); 
	//can use sizeof(b) above as well 

	printf("Hello! I am an integer. My value is %d and "
	   "my size is %lu  bytes.\n", a,sizeof(int)); 
	//can use sizeof(a) above as well 

	printf("Hello! I am a double floating point variable."
	   " My value is %lf and my size is %lu bytes.\n",c,sizeof(double)); 
	//can use sizeof(c) above as well 

	return 0; 
}
