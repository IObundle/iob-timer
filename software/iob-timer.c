#include "iob-lib.h"
#include "iob-timer.h"
#include "TIMERsw_reg.h"

//base address
static int base;

void timer_reset() {	
  IO_SET(base, TIMER_RESET, 1);
  IO_SET(base, TIMER_RESET, 0);
}

void timer_start() {	
  IO_SET(base, TIMER_ENABLE, 1);
}

void timer_stop() {	
  IO_SET(base, TIMER_ENABLE, 0);
}


void timer_init(int base_address) {
  //capture base address for good
  base = base_address;
  timer_reset();
  timer_start();
}

unsigned long long timer_get_count() {

  unsigned long long timer_total;
  unsigned int timer_high, timer_low;
  
  // sample timer
  IO_SET(base, TIMER_SAMPLE, 1);
  IO_SET(base, TIMER_SAMPLE, 0);

  // get count
  timer_high = (unsigned int) IO_GET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) IO_GET(base, TIMER_DATA_LOW);
  timer_total = timer_high;
  timer_total <<= 32;
  timer_total |= timer_low;
  
  return timer_total;
} 

//get time in specified time unit (inverse of sample rate)
// timer_time_tu(1):        time in seconds
// timer_time_tu(1000):     time in milliseconds
// timer_time_tu(1000000):  time in microseconds
unsigned int timer_time_tu(int sample_rate) {

  //get time count
  unsigned long long timer_total = timer_get_count();

  //number of clocks per time unit
  float ticks_per_tu = ( (float) FREQ)/sample_rate;
 
  //time in us
  float time_tu = timer_total / ticks_per_tu;
 
  return (unsigned int) time_tu;
}

//get time in us
unsigned int timer_time_us() {
  return timer_time_tu(1000000);
}

//get time in ms
unsigned int timer_time_ms() {
  return timer_time_tu(1000);
}

//get time in s
unsigned int timer_time_s() {
  return timer_time_tu(1);
}
