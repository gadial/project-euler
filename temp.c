#include <stdio.h>
int main (void) {

double People_including_kids=0;

char is_a_vip;

double kids_invovled=0;
int people_not_including_kids=0;

int PriceForDay=0;
char room_kind;
int discount=0;

char c;
int out=0;
int enter=0;
int Days=0;
double Extra=0;
double TotalPrice=0;
double TotalPrice_vip=0;
int TotalPrice_normal=0;



printf ("Welcome to Turbo_C Hotel.\n\n");

printf ("How many people you are?\n\n");
scanf ("%lf", &People_including_kids);
  if (People_including_kids < 0) { /*if the tottal number of people including kids is not possitive we end the program*/
    printf ("ERROR\n");
    return 0;
  }
  if (People_including_kids != (int)People_including_kids) {  /*if the the tottal number of people is a fraction we end the program*/
    printf ("ERROR\n");
    return 0;
  }
  else {
    printf ("Are you a VIP client?\n\n");
}
printf("End\n");
}