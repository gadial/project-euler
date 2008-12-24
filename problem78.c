// Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can separated into piles in exactly seven different ways, so p(5)=7.
// OOOOO
// OOOO   O
// OOO   OO
// OOO   O   O
// OO   OO   O
// OO   O   O   O
// O   O   O   O   O
// 
// Find the least value of n for which p(n) is divisible by one million.

//we relay on Euler's formula:
// P\left(n\right)=\sum_{k=1}^{n}\left(-1\right)^{k+1}\left[P\left(n-\frac{1}{2}k\left(3k-1\right)\right)+P\left(n-\frac{1}{2}k\left(3k+1\right)\right)\right]
#include <stdio.h>
#include <stdlib.h>
#define MAX_SIZE 100000
#define MOD 1000000
int* P;

int main(){
	int n=0;
	int k;
	int sum;
	int pos_1,pos_2;
	int mul;
	P=(int*)malloc(sizeof(int)*MAX_SIZE);
	P[0] = 1;
	while (P[n] != 0 && n < MAX_SIZE){
		n++;
		sum = 0;
		for (k=1; k<=n; k++){
			mul = (k % 2 == 0)?(-1):(1);
			pos_1 = n-((3*k*k-k)/2);
			pos_2 = n-((3*k*k+k)/2);
			if (pos_1 < 0) break;
// 			printf("pos1 = %d\n",pos_1);
			sum+=(pos_1>=0)?(mul*P[pos_1]):(0);
			sum+=(pos_2>=0)?(mul*P[pos_2]):(0);
		}
		while (sum<0)
			sum+=MOD;
		P[n] = (sum % MOD);
// 		printf("%d: %d\n",n, P[n]);
	}
	printf("%d\n",n);
	return 0;
}
