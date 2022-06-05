#include <interrupts.h>
#include <avr/interrupt.h>
#include <avr/io.h>

ISR(TIMER0_OVF_vect)
{
    if (counter>=50) {
        PORTB ^= (1 << PB5);
        counter = 0;
    } else counter++;
}