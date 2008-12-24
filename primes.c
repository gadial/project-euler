#include <stdio.h>
#include <stdlib.h>
#define MAX 50000000
int main(){
  int i,j;
  int* nums;
  nums = malloc(sizeof(int)*MAX);
  for (i=0; i<MAX; i++){
      nums[i]=1;
    }
  for (i=2; i<MAX; i++){
    if (nums[i] == 1){
      printf("%d\n",i);
      for (j=2*i; j<MAX; j+=i)
	nums[j]=0;
    }
  }
  free (nums);
  return 0;
}
