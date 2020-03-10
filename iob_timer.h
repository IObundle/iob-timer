#ifndef TIMER_H
#define TIMER_H


#ifndef MEMSET
#define MEMSET(base, location, value) (*((volatile int*) (base + (sizeof(int)) * location)) = value)
#endif

#ifndef MEMGET
#define MEMGET(base, location)        (*((volatile int*) (base + (sizeof(int)) * location)))
#endif

//Memory Map
#define TIMER_DATA  0
#define TIMER_RESET 1

//Functions
//Reset the timer
void timer_reset(int base);
//Gets the current number of cycles since reset
unsigned long timer_get_count(int base);


#endif
