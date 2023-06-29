#pragma once

#include "iob_timer_swreg.h"

//Functions
void timer_reset();
void timer_init( int base_address);	

uint64_t timer_get_count();
uint64_t timer_time_tu(uint64_t sample_rate);
uint64_t timer_time_us();
uint64_t timer_time_ms();
uint64_t timer_time_s();
