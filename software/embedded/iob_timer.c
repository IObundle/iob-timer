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

//counter with 10us resolution and max value of almost 12 hours
unsigned int timer_time_us(int base) {
  unsigned int timer_high, timer_low, timer, calc; //, aux;
  //  unsigned long long timer_total;
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);
  //  timer = (timer_high << 22) | (timer_low >> 10); // (=) /1024

  calc = FREQ/1000; //freq in kHz //ideally FREQ/1000000
  calc /= 1000; //freq in MHz
  timer = timer_low/calc;         //ideally timer_total
  return timer;
}

//counter with 10ms resolution and unreachable max value
unsigned int timer_time_ms(int base) {
  unsigned int timer_high, timer_low, timer, calc;
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);
  //  timer = (timer_high << 12) | (timer_low >> 20); // (=) /(1024*1024)

  calc = FREQ/1000;
  //  calc /= 1000;
  timer = timer_low/calc; //ideally timer_total
  return timer;
}

//counter with 10s resolution and unreachable max value
unsigned int timer_time_s(int base) {
  unsigned int timer_high, timer_low, timer, calc;
  MEMGET(base, TIMER_STOP);
  timer_high = (unsigned int) MEMGET(base, TIMER_DATA_HIGH);
  timer_low = (unsigned int) MEMGET(base, TIMER_DATA_LOW);
  //  timer = (timer_high << 12) | (timer_low >> 20);
  calc = FREQ;
  timer = timer_low/calc; //ideally timer_total
  return timer;
}
