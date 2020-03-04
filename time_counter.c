#include "time_counter.h"

//UART functions
void timer_reset(int base) {	
  MEMSET(base, TIMER_RESET, 1);
  MEMSET(base, TIMER_RESET, 0);

}

unsigned long get_count(int base) {
  return ( (unsigned long) MEMGET(base, TIMER_DATA));
}
