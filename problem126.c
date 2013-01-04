// The minimum number of cubes to cover every visible face on a cuboid measuring 3 x 2 x 1 is twenty-two.
// 
// If we then add a second layer to this solid it would require forty-six cubes to cover every visible face, the third layer would require seventy-eight cubes, and the fourth layer would require one-hundred and eighteen cubes to cover every visible face.
// 
// However, the first layer on a cuboid measuring 5 x 1 x 1 also requires twenty-two cubes; similarly the first layer on cuboids measuring 5 x 3 x 1, 7 x 2 x 1, and 11 x 1 x 1 all contain forty-six cubes.
// 
// We shall define C(n) to represent the number of cuboids that contain n cubes in one of its layers. So C(22) = 2, C(46) = 4, C(78) = 5, and C(118) = 8.
// 
// It turns out that 154 is the least value of n for which C(n) = 10.
// 
// Find the least value of n for which C(n) = 1000.
// 
// for a cuboid of dimensions a x b x c, the number of cubes on layer n>=1 is given by
// 2*(a*b+a*c+b*c)+4*(n-1)*(a+b+c+n-2)

// 16400
#include <stdio.h>
int f(int a,int b,int c,int n){
  return 2*(a*b+a*c+b*c)+4*(n-1)*(a+b+c+n-2);
}

int C(int k){
  int count = 0;
  int a = 1;
  while (4*a < k){
    int b = 1;
    while (2*(a*b) <= k && b <= a){
      int n = 1;
      while (k-2*a*b-4*(n-1)*(a+b+n-2) > 0){
	if ((k-2*a*b-4*(n-1)*(a+b+n-2)) % (2*a+2*b+4*(n-1)) == 0){
	  int c = (k-2*a*b-4*(n-1)*(a+b+n-2)) / (2*a+2*b+4*(n-1));
	  if (c <= b){
	    count += 1;
	  }
	}
	n += 1;
      }
      b += 1;
    }
    a += 1;
  }
  return count;
}

int main(){
  int n = 2;
  while(1){
    int val = C(n);
    if (val == 1000)
      break;
    n += 2;
  }
  printf("%d\n",n);
  return 0;
}
