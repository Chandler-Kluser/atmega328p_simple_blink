#include <avr/io.h>
#include <util/delay.h>

char counter;

int main()
{
    DDRB |= (1 << DDB5);
    // PRESCALER F/1024
    TCCR0B = (1<<CS02) | (1<<CS00);
    // INTERRUPT IN OVERFLOW
    TIMSK0 = (1<<TOIE0);
    asm volatile("sei"::); // set global interrupts
    counter = 0;
    while (1) {}
}