#include "iob_timer.h"

void timer_reset(int base) {	
  MEMSET(base, TIMER_RESET, 1);
  MEMSET(base, TIMER_RESET, 0);

}

unsigned long long timer_get_count(int base) {
  unsigned long long timer_total;
  unsigned int timer_high, timer_low;
  
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);
  timer_total = timer_high;
  timer_total = timer_total << 32;
  timer_total |= timer_low;
  
  return timer_total;
} 

//deprecated
//unsigned int timer_get_count_us(int base) {return 0;}

//counter with 1us resolution and max value of 1h11
unsigned int timer_time_us(int base) {
  unsigned int timer_high, timer_low, timer, ticks_per_us, timer_high_period_us;

  // stop timer and get counter
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);

  // number of clocks per us
  ticks_per_us = FREQ/1000000;
  // us for each tick in TIMER_DATA_HIGH = ((2^32) - 1)/(ticks_per_us)
  timer_high_period_us = ((1<<31)/ticks_per_us)*2;

  // calculate time in us
  timer = timer_low/ticks_per_us;
  timer += timer_high*timer_high_period_us;
  return timer;
}

//counter with 1ms resolution and max value of over 49 days
unsigned int timer_time_ms(int base) {
  unsigned int timer_high, timer_low, timer, ticks_per_ms, timer_high_period_ms;

  // stop timer and get counter
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);

  // number of clocks per ms
  ticks_per_ms = FREQ/1000;
  // us for each tick in TIMER_DATA_HIGH = ((2^32) - 1)/(ticks_per_ms)
  timer_high_period_ms = ((1<<31)/ticks_per_ms)*2;

  // calculate time in us
  timer = timer_low/ticks_per_ms;
  timer += timer_high*timer_high_period_ms;
  return timer;
}

//counter with 1s resolution and max value of over 136 years
unsigned int timer_time_s(int base) {
  unsigned int timer_high, timer_low, timer, timer_high_period_s;

  // stop timer and get counter
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);

  // FREQ = number of clocks per s
  // us for each tick in TIMER_DATA_HIGH = ((2^32) - 1)/(FREQ)
  timer_high_period_s = ((1<<31)/FREQ)*2;

  // calculate time in us
  timer = timer_low/FREQ;
  timer += timer_high*timer_high_period_s;
  return timer;
}
