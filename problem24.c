// A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
// 
// 012   021   102   120   201   210
// 
// What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

#include <stdio.h>
#include <stdlib.h>

int number_to_digits(long long number, int digit_array[], int length){
	int i;
	for (i=length-1; i>=0; i--){
		digit_array[i]=number % 10;
		number /= 10;
	}
}

int is_permutation(int array[], int length){
	int* temp_array = malloc(sizeof(int)*length);
	int i;
	int result=1;
	for (i=0; i<length; i++)
		temp_array[i]=0;

	for (i=0; i<length; i++)
		if (temp_array[array[i]]++ != 0)
			result = 0;
	free(temp_array);
	return result;
}

int print_array(int array[], int length){
	int i;
	printf("[");
	for (i=0; i<length; i++)
		printf("%d, ",array[i]);
	printf("]\n");
}

int main(){
	int digits[10];
	long long number;
	int counter = 0;

	for (number = 123456789; number<=9876543210LL; number++){
		number_to_digits(number, digits, 10);
		if (is_permutation(digits,10)){
			counter++;
			if (counter == 1000000){
				printf("%d\n",number);
				break;
			}
		}
	}
	return 0;
}
