# Simple Arduino Interrupt Blink

Timer0 Simple Atmega328p C Program compiled with [avr-gcc](https://gcc.gnu.org/wiki/avr-gcc)

Compile with [make](https://www.gnu.org/software/make/):

```bash
make
```

Use [avrdude](https://www.nongnu.org/avrdude/) for flashing

Linux needs (Debian based): 

```
sudo apt install avr-libc gcc-avr
```

## Debug

If you want a Debug Release binary for a GDB session, run:

```bash
make DEBUG=1
```