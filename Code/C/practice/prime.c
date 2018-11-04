#include <stdio.h>

int isPrime (int num) {
	int denom;
	for(denom=2; denom<num; denom++) {
		// Still not proven not prime
		if (num%denom == 0) {
			printf("Not Prime\n");
			return 0;
		}
		// Evidence found proving not prime
		else {
			continue;
			//denom++;
		}
	}
	// For loop complete, the number is prime
	printf("Prime\n");
	return 1;
}

int main() {
	int num, ans;
	while (1) {
		printf("Choose a number: ");
		scanf("%d", &num);
		ans = isPrime(num);
	}
	return 0;
}
