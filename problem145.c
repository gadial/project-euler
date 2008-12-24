#include <stdio.h>
#define MAX 1000000000
int reversible(int num){
	int reverse = 0;
	int temp = num;
	int result;
	if (num % 10 == 0)
		return 0;
	while (temp > 0){
		reverse = (reverse * 10) + (temp % 10);
		temp /= 10;
	}
	result = num + reverse;
	while (result > 0)
		if (((result % 10) % 2) == 0)
			return 0;
		else
			result /= 10;
	return 1;
}

int main(){
	int i,count=0;
	for (i=1; i<MAX; i++)
		if (reversible(i))
			count++;
	printf("%d\n",count);
	return 0;
}
