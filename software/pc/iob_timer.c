#include "iob_timer.h"
#include <time.h>

static clock_t start, end;

void timer_reset(int base) {	
  start = clock();
}

unsigned long long timer_get_count(int base) {
  
  //get current time
  end  = clock();
  //get diference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return number of cycles
  return (unsigned long long) (time_dif_secs * UART_CLK_FREQ);
} 

//counter with 10us resolution and max value of almost 12 hours
unsigned int timer_get_count_us(int base) {

  //get current time
  end  = clock();
  //get diference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return time in us
  return (unsigned long long) (time_dif_secs * 1000000);
}
