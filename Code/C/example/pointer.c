#include <stdio.h>

int main() {
	
	int num = 10;
	printf("int num = 10;\n");
	printf("\tvalue of num: %d \n", num);
	
	int *p;
	printf("int *p;\n");
	printf("\toriginal address of p: %p \n", p);

	p = &num;
	printf("p = &num;\n");
	printf("\tnew address of p: %p \n", p);
	
	*p = 200;
	printf("*p = 200;\n");
	printf("\tnew value of num: %d \n", num);

	return 0;
}
