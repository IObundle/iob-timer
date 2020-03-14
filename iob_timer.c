#include "iob_timer.h"

//UART functions
void timer_reset(int base) {	
  MEMSET(base, TIMER_RESET, 1);
  MEMSET(base, TIMER_RESET, 0);

}

int timer_get_count(int base) {
  return ( (unsigned long) MEMGET(base, TIMER_DATA));
}
