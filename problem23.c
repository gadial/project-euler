// A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
// 
// A number whose proper divisors are less than the number is called deficient and a number whose proper divisors exceed the number is called abundant.
// 
// As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
// 
// Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
#include <stdio.h>
#define MAX 28123
int is_abundant(int number){
	int sum = 0;
	int i;
	for (i=2; i<number; i++)
		if (number % i ==0)
			sum+=i;
	return (sum > number);
}

int sum_of_two_from(int number, int number_array[], int length){
	int i;
	for (i=0; i<length; i++){
		if (number <= number_array[i])
			return 0;
		if (is_abundant(number - number_array[i]))
			return 1;
	}
	return 0;
}

int main(){
	int abundant_numbers[MAX];
	int counter = 0;
	int i;
	int sum = 0;

	for (i=12; i<MAX; i++)
		if (is_abundant(i))
			abundant_numbers[counter++]=i;
	for (i=1; i<MAX; i++)
		if (!sum_of_two_from(i, abundant_numbers, counter))
			sum += i;
	printf("%d\n",sum);
	return 0;
}
