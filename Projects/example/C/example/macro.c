#include <stdio.h>

#define LEFT 1
#define RIGHT 0

#define ABS(a) (a) < 0 ? -(a): (a)

int main() {
	printf("%d %d %d\n", RIGHT, LEFT, LEFT+1);

	printf("abs of -1 and 1: %d %d\n", ABS(-1), ABS(1));
	return 0;
}
