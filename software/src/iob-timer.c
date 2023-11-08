#include "iob-timer.h"

// System clock frequency in Hz
uint32_t sys_freq;
// Base Address
static uint32_t base;

void timer_reset() {	
    IOB_TIMER_SET_RESET(1);
    IOB_TIMER_SET_RESET(0);
}

void timer_init(uint32_t base_address, uint32_t freq) {
    sys_freq = freq;
    base = base_address;
    //capture base address for good
    IOB_TIMER_INIT_BASEADDR(base_address);
    timer_reset();
    IOB_TIMER_SET_ENABLE(1);
}

uint64_t timer_get_count() {

    uint64_t timer_total, timer_high, timer_low;

    // sample timer
    IOB_TIMER_SET_SAMPLE(1);
    IOB_TIMER_SET_SAMPLE(0);

    // get count
    timer_high = IOB_TIMER_GET_DATA_HIGH();
    timer_low = IOB_TIMER_GET_DATA_LOW();
    timer_total = timer_high;
    timer_total <<= 32;
    timer_total |= timer_low;

    return timer_total;
}

// TODO: find why the below version does not work 
uint64_t timer_get_count2() {
  return (*( (volatile uint64_t *) ( (base) + (IOB_TIMER_DATA_HIGH_ADDR)) ));
}


//get time in specified time unit (inverse of sample rate)
// timer_time_tu(1):        time in seconds
// timer_time_tu(1000):     time in milliseconds
// timer_time_tu(1000000):  time in microseconds
uint64_t timer_time_tu(uint32_t scale_factor) {

  //get time count
  uint64_t time_count = timer_get_count();

  //number of clocks per time unit
  uint64_t time_tu = (scale_factor * time_count)/sys_freq;
 
  return (uint64_t) time_tu;
}

//get time in us
uint64_t timer_time_us() {
    return timer_time_tu(1000000);
}

//get time in ms
uint64_t timer_time_ms() {
    return timer_time_tu(1000);
}

//get time in s
uint64_t timer_time_s() {
    return timer_time_tu(1);
}
