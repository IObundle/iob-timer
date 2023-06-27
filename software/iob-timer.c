#include "iob-timer.h"

void timer_reset() {	
    IOB_TIMER_SET_RESET(1);
    IOB_TIMER_SET_RESET(0);
}

void timer_init(int base_address) {
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

//get time in specified time unit (inverse of sample rate)
// timer_time_tu(1):        time in seconds
// timer_time_tu(1000):     time in milliseconds
// timer_time_tu(1000000):  time in microseconds
uint64_t timer_time_tu(uint64_t sample_rate) {

    //get time count
    uint64_t timer_total = timer_get_count();

    //number of clocks per time unit
    uint64_t ticks_per_tu = (FREQ)/sample_rate;

    //time in us
    uint64_t time_tu = timer_total / ticks_per_tu;

    return time_tu;
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
