#pragma once

#include "iob_timer_swreg.h"

//Functions
void timer_reset();
void timer_init(uint32_t base_address, uint32_t freq);

uint64_t timer_get_count();
uint64_t timer_time_tu(uint32_t scale_factor);
uint64_t timer_time_us();
uint64_t timer_time_ms();
uint64_t timer_time_s();
