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
  timer_total = ((unsigned long long) timer_high) << 32;
  timer_total |= timer_low;
  
  return (timer_total);
} 

//counter with 10us resolution and max value of almost 12 hours
unsigned int timer_get_count_us(int base) {
  unsigned int timer_high, timer_low, timer;
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);
  timer = (timer_high << 22) | (timer_low >> 10);
  return (timer*((1024*1000000)/FREQ));
}
