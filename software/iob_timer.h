#ifndef TIMER_H
#define TIMER_H

#include <time.h>

#ifndef MEMSET
#define MEMSET(base, location, value) (*((volatile int*) (base + (sizeof(int)) * location)) = value)
#endif

#ifndef MEMGET
#define MEMGET(base, location)        (*((volatile int*) (base + (sizeof(int)) * location)))
#endif

//Memory Map
#define TIMER_RESET 0
#define TIMER_STOP 1
#define TIMER_DATA_HIGH 2
#define TIMER_DATA_LOW 3

//Functions
//Reset the timer
void timer_reset(int base);
//Gets the current number of cycles since reset
unsigned long long timer_get_count(int base);
unsigned int timer_get_count_us(int base);
unsigned int timer_time_us(int base);
unsigned int timer_time_ms(int base);
unsigned int timer_time_s(int base);

#endif
