#pragma once

//Functions
void timer_reset();
void timer_start();	
void timer_stop();
void timer_init( int base_address);	

unsigned long long timer_get_count();
unsigned int timer_time_tu(int sample_rate);
unsigned int timer_time_us();
unsigned int timer_time_ms();
unsigned int timer_time_s();
