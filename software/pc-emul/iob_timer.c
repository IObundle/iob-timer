#include "iob_timer.h"
#include <time.h>

static clock_t start, end;
//base address
static int base;

void timer_reset() {	
  start = clock();
}

void timer_start() {	
  start = clock();
}

void timer_stop() {	
  end = clock();
}

void timer_init(int base_address) {
  //capture base address for good
  base = base_address;
  timer_reset();
  timer_start();
}

unsigned long long timer_get_count() {
  
  //get current time
  end  = clock();
  //get diference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return number of cycles
  return (unsigned long long) (time_dif_secs * FREQ);
} 

//get time in specified time unit (inverse of sample rate)
unsigned int timer_time_tu(int sample_rate) {

  //get time count
  unsigned long long timer_total = timer_get_count();

  //number of clocks per time unit
  unsigned long long ticks_per_tu = ((long long) FREQ)/sample_rate;
 
  //time in us
  unsigned long long time_tu = timer_total/ticks_per_tu;
 
  return (int) time_tu;
}

//counter with 1us resolution and max value of 1h11
unsigned int timer_time_us() {

  // get current time
  end  = clock();
  // get difference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return time in us
  return (unsigned int) (time_dif_secs * 1000000);
}

//counter with 1ms resolution and max value of over 49 days
unsigned int timer_time_ms() {

  // get current time
  end  = clock();
  // get difference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return time in ms
  return (unsigned int) (time_dif_secs * 1000);
}

//counter with 1s resolution and max value of over 136 years
unsigned int timer_time_s() {

  // get current time
  end  = clock();
  // get difference in seconds
  double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC;
  //return time in us
  return (unsigned int) (time_dif_secs);
}
