#include "iob_timer.h"

void timer_reset(int base) {	
  MEMSET(base, TIMER_RESET, 1);
  MEMSET(base, TIMER_RESET, 0);

}

long long timer_get_count(int base) {
  long long timer_total;
  int timer_high, timer_low;
  
  MEMGET(base, TIMER_STOP);
  timer_high = (int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (int) MEMGET(base, TIMER_DATA_LOW);
  timer_total = ((long long) timer_high) << 32;
  timer_total = timer_total + timer_low;
  
  return (timer_total);
} 
