CC 		= avr-gcc
OBJCOPY	= avr-objcopy
SIZE	= avr-size
DUMP	= avr-objdump
SRC_DIR = src
INC_DIR = inc
BIN_DIR = bin
OBJ_DIR = obj

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# includes
INC	 = -Iinc

# defines
DEF 	 = -D__AVR_ATmega328P__
DEF 	+= -DF_CPU=16000000UL

# cflags
CFLAGS	 = -mmcu=atmega328p
CFLAGS	+= -Wall
CFLAGS	+= -Os

# ldflags
LDFLAGS	= -Wl,-Tld/linker_script_atmega328p.ld,--cref

.PHONY: all clean dump flash

all: $(BIN_DIR)/main.bin

$(BIN_DIR)/main.bin: $(BIN_DIR)/main.elf
	$(OBJCOPY) -j .text -j .data -O binary $(BIN_DIR)/main.elf $(BIN_DIR)/main.bin
	$(SIZE) $(BIN_DIR)/main.elf

$(BIN_DIR)/main.elf: $(OBJS) | $(BIN_DIR)
	@$(CC) $(CFLAGS) $(OBJS) --output $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(DEF) $(INC) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir $@

clean:
	rm -rf bin obj

dump: $(BIN_DIR)/dump.lst
	$(SIZE) $(BIN_DIR)/main.elf

$(BIN_DIR)/dump.lst: $(BIN_DIR)/main.elf
	$(DUMP) -d .text -d .data $(BIN_DIR)/main.elf > $(BIN_DIR)/dump.lst

flash: $(BIN_DIR)/main.bin
	avrdude -c usbasp -p m328p -U flash:w:$(BIN_DIR)/main.bin:a 