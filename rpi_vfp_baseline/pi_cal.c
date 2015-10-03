#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define METHOD_SIZE 3

float baseline(size_t dt)
{
	float pi = 0.0;
	float delta = 1.0/dt;
	size_t i;
	for(i=0; i< dt;i++){
		float x = (float) i/dt;
		pi += delta/(1.0 + x * x);	
	}
	return(pi * 4.0);
}

float leibniz(size_t n){
	float sum = 0.0;
	size_t i;
	int sign;
	for(i=0; i < n;i++){
		sign = (i & 0x01) == 0 ? 1 : -1;
		sum += (sign / (2.0 * (float)i +1.0));

	}
	return(sum * 4.0);
}

extern float vfp_baseline(size_t x);

int main(int argc, char **argv)
{
  size_t method = atoi(argv[1]);	
  unsigned int number = atoi(argv[2]);
  
  float result=0.0;
  clock_t start, end;
  double time_diff;  

  float (*compute_pi_method)(size_t) = NULL;		 
 	
  switch(method){
	case 0:
	       compute_pi_method = &baseline; 	
	       break;
	case 1:
	       compute_pi_method = &leibniz;
	       break;
	case 2:		
	       compute_pi_method = &vfp_baseline;
	       break;
	default:
		break;
               
  }	  
  
   	
  	start = clock();	
  	result = (*compute_pi_method)(number);
  	end = clock();	   
  	time_diff = (double)(end - start)/ CLOCKS_PER_SEC;	
   
	printf("Method %d Input number = %d Compute pi = %f time is %lf\n",method,number,result,time_diff);
 
	return(0);
}

