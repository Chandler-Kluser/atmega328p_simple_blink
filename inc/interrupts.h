#ifndef INTERRUPTS_H
#define INTERRUPTS_H
#include <avr/interrupt.h>

extern char counter;

ISR(TIMER0_OVF_vect);

#endif