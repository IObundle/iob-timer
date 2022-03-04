#include "iob-lib.h"
#include "TIMERsw_reg.h"
#include <time.h>

/* convert clock values from PC CLOCK FREQ to EMBEDDED FREQ */
#define PC_TO_FREQ_FACTOR ((1.0*FREQ)/CLOCKS_PER_SEC)

static clock_t start, end, time_counter, counter_reg;
static int timer_enable;

void pc_timer_reset(int value) {	
    // use only reg width
    int rst_int = (value & 0x01);
    if(rst_int){
        start = end = 0;
        time_counter = 0;
        timer_enable = 0;
    }
    return;
}

void pc_timer_enable(int value){
    // use only reg width
    int en_int = (value & 0x01);
    // manage transitions
    // 0 -> 1
    if(timer_enable == 0 && en_int == 1){
        // start counting time
        start = clock();
    } else if(timer_enable == 1 && en_int == 0){
        // accumulate enable interval
        end = clock();
        timer_enable += (end - start);
        start = end = 0; // reset aux clock values
    }
    // store enable en_int
    timer_enable = en_int;
    return;
}

void pc_timer_sample(int value) {	
    // use only reg width
    int sample_int = (value & 0x01);
    if(sample_int){
        counter_reg = time_counter;
        if(start != 0)
            counter_reg += (clock() - start);
    }
    return;
}

int pc_timer_data_high(){
    /* convert clock from PC CLOCKS_PER_CYCLE to FREQ */
    double counter_freq = (1.0*counter_reg)*PC_TO_FREQ_FACTOR;
    return ( (int) (((unsigned long long) counter_freq) >> 32));
}

int pc_timer_data_low(){
    /* convert clock from PC CLOCKS_PER_CYCLE to FREQ */
    double counter_freq = (1.0*counter_reg)*PC_TO_FREQ_FACTOR;
    return ( (int) (((unsigned long long) counter_freq) & 0xFFFFFFFF));
}


void MEM_SET(int type, int location, int value){
    return;
}

int MEM_GET(int type, int location){
    return 0;
}

void IO_SET(int base, int location, int value){
    switch(location){
        case TIMER_RESET:
            pc_timer_reset(value);
            break;
        case TIMER_ENABLE:
            pc_timer_enable(value);
            break;
        case TIMER_SAMPLE:
            pc_timer_sample(value);
            break;
        default:
            // do nothing
            break;
    }
    return;
}

int IO_GET(int base, int location){
    int ret_val = 0;
    switch(location){
        case TIMER_DATA_HIGH:
            ret_val = pc_timer_data_high();
            break;
        case TIMER_DATA_LOW:
            ret_val = pc_timer_data_low();
            break;
        default:
            // do nothing
            break;
    }

    return ret_val;
}

/* //counter with 1us resolution and max value of 1h11 */
/* unsigned int timer_time_us() { */

/*   // get current time */
/*   end  = clock(); */
/*   // get difference in seconds */
/*   double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC; */
/*   //return time in us */
/*   return (unsigned int) (time_dif_secs * 1000000); */
/* } */

/* //counter with 1ms resolution and max value of over 49 days */
/* unsigned int timer_time_ms() { */

/*   // get current time */
/*   end  = clock(); */
/*   // get difference in seconds */
/*   double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC; */
/*   //return time in ms */
/*   return (unsigned int) (time_dif_secs * 1000); */
/* } */

/* //counter with 1s resolution and max value of over 136 years */
/* unsigned int timer_time_s() { */

/*   // get current time */
/*   end  = clock(); */
/*   // get difference in seconds */
/*   double time_dif_secs = (double) (end - start) / CLOCKS_PER_SEC; */
/*   //return time in us */
/*   return (unsigned int) (time_dif_secs); */
/* } */
