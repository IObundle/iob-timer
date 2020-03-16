#include "iob_timer.h"

//UART functions
void timer_reset(int base) {	
  MEMSET(base, TIMER_RESET, 1);
  MEMSET(base, TIMER_RESET, 0);

}

long long timer_get_count(int base) {
  long long *cycles_ptr;
  int timer_high, timer_low;
  
  timer_high = (int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (int) MEMGET(base, TIMER_DATA_LOW);
  
  *(((int *) cycles_ptr)) = timer_high;
  *(((int *) cycles_ptr) + sizeof(int)) = timer_low;
  
  return (*cycles_ptr);
}
