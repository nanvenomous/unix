#include <stdio.h>

int main() {
	int array[5] = {2, 3, 4, 5, 6};
	array[0] = 1;
	printf("%d\n", array[0]);
	return 0;
}
