#include <stdio.h>

int main() {
	int a = 1; 
	char b ='G'; 
	double c = 3.14; 

	//printing the variables defined above along with their sizes 
	printf("Character:\n");
	printf("\tValue: %c, Size: %lu bytes.\n", b, sizeof(b)); 

	printf("Integer:\n");
	printf("\tValue: %d, Size: %lu bytes.\n", a, sizeof(a)); 

	printf("Floating Point:\n");
	printf("\tValue: %lf, Size: %lu bytes.\n", c, sizeof(c)); 

	return 0; 
}
