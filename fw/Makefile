MCU = atmega8
# Preserve EEPROM during chip-erase cycle
# Set hfuse to 0xD9 to clear eeprom using avrdude -e
FUSES = -U lfuse:w:0x14:m -U hfuse:w:0xD1:m -U lock:w:0xFF:m
F_CPU = 8000000
FORMAT = ihex
BUILDDIR = build
TARGET = $(BUILDDIR)/hwexla
OBJDIR = obj
SRC = $(wildcard src/*.c)
OPT = s
CSTANDARD = c99
DEBUG = dwarf-2

CDEFS = -DF_CPU=$(F_CPU)UL

CFLAGS = -g$(DEBUG)
CFLAGS += $(CDEFS)
CFLAGS += -O$(OPT)
CFLAGS += -Wall
CFLAGS += -pedantic
CFLAGS += -Wa,-adhlns=$(<:%.c=$(OBJDIR)/%.lst)
CFLAGS += -std=$(CSTANDARD)

LDFLAGS = -Wl,-Map=$(TARGET).map,--cref

#---------------- Programming Options (avrdude) ----------------

AVRDUDE_PROGRAMMER = stk500
AVRDUDE_PORT = /dev/ttyUSB0
AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
AVRDUDE_WRITE_EEPROM = -U eeprom:w:$(TARGET).eep
AVRDUDE_FLAGS = -p $(MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER)

#============================================================================

# Define programs and commands.
CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE = avr-size
AR = avr-ar rcs
NM = avr-nm
AVRDUDE = avrdude
REMOVE = rm -f
REMOVEDIR = rm -rf
COPY = cp

COMMA = ,

# Define Messages
# English
MSG_ERRORS_NONE = Errors: none
MSG_SIZE_BEFORE = Size before:
MSG_SIZE_AFTER = Size after:
MSG_FLASH = Creating load file for Flash:
MSG_EEPROM = Creating load file for EEPROM:
MSG_EXTENDED_LISTING = Creating Extended Listing:
MSG_SYMBOL_TABLE = Creating Symbol Table:
MSG_LINKING = Linking:
MSG_COMPILING = Compiling C:
MSG_CREATING_LIBRARY = Creating library:

OBJ = $(SRC:%.c=$(OBJDIR)/%.o)
LST = $(SRC:%.c=$(OBJDIR)/%.lst)
GENDEPFLAGS = -MMD -MP -MF .dep/$(@F).d

ALL_CFLAGS = -mmcu=$(MCU) -I. $(CFLAGS) $(GENDEPFLAGS)

all: sizebefore build sizeafter

build: elf hex eep lss sym

elf: $(TARGET).elf
hex: $(TARGET).hex
eep: $(TARGET).eep
lss: $(TARGET).lss
sym: $(TARGET).sym


HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET).hex
ELFSIZE = $(SIZE) --mcu=$(MCU) --format=avr $(TARGET).elf

sizebefore:
	@if test -f $(TARGET).elf; then echo; echo $(MSG_SIZE_BEFORE); $(ELFSIZE); \
	2>/dev/null; echo; fi

sizeafter:
	@if test -f $(TARGET).elf; then echo; echo $(MSG_SIZE_AFTER); $(ELFSIZE); \
	2>/dev/null; echo; fi

program: $(TARGET).hex $(TARGET).eep
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

fuses:
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(FUSES)

osccal_to_eeprom:
	$(eval CALIBRATIONS=$(shell $(AVRDUDE) $(AVRDUDE_FLAGS) -U cal:r:-:h))
	$(eval CALIBRATION=$(word 4, $(subst $(COMMA), ,$(CALIBRATIONS))))
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U eeprom:w:0xAA,$(CALIBRATION):m

wipe:
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U hfuse:w:0xD9:m
	$(AVRDUDE) $(AVRDUDE_FLAGS) -e

program_new_mcu: wipe fuses osccal_to_eeprom program

$(BUILDDIR)/%.hex: $(BUILDDIR)/%.elf
	@echo
	@echo $(MSG_FLASH) $@
	$(OBJCOPY) -O $(FORMAT) -R .eeprom $< $@

$(BUILDDIR)/%.eep: $(BUILDDIR)/%.elf
	@echo
	@echo $(MSG_EEPROM) $@
	-$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom="alloc,load" \
	--change-section-lma .eeprom=0 --no-change-warnings -O $(FORMAT) $< $@ || exit 0

$(BUILDDIR)/%.lss: $(BUILDDIR)/%.elf
	@echo
	@echo $(MSG_EXTENDED_LISTING) $@
	$(OBJDUMP) -h -S $< > $@

$(BUILDDIR)/%.sym: $(BUILDDIR)/%.elf
	@echo
	@echo $(MSG_SYMBOL_TABLE) $@
	$(NM) -n $< > $@

.SECONDARY : $(TARGET).elf
.PRECIOUS : $(OBJ)
%.elf: $(OBJ)
	@echo
	@echo $(MSG_LINKING) $@
	$(CC) $(ALL_CFLAGS) $^ --output $@ $(LDFLAGS)

$(OBJDIR)/%.o : %.c
	@echo
	@echo $(MSG_COMPILING) $<
	$(CC) -c $(ALL_CFLAGS) $< -o $@

clean:
	$(REMOVEDIR) $(BUILDDIR)
	$(REMOVEDIR) $(OBJDIR)
	$(REMOVEDIR) .dep

$(shell mkdir -p $(dir $(OBJ)) 2>/dev/null)
$(shell mkdir -p $(dir $(TARGET)) 2>/dev/null)

-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

.PHONY : all finish sizebefore sizeafter \
	build elf hex eep lss sym clean program debug gdb-config fuses osccal_to_eeprom \
	program_new_mcu wipe
