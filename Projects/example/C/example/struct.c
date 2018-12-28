#include <stdio.h>

// Structs have public methods and properties by default
typedef struct {
	int x; // x is public
} sTest;

int main() { 
	sTest st;
	st.x = 30; // works because x i public
	printf("created a class with a property equal to %d\n", st.x);
	// getchar(); 
	return 0; 
} 
