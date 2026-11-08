BUILD_DIR?=build/
ASM?=nasm
ASMFLAGS?=-f obj
CC16?=wcc
CFLAGS16?=-4 -d3 -s -wx -ms -zl -zq -za99 # -oneatxzh
LD16?=wlink

SOURCES_C=$(wildcard *.c)
SOURCES_ASM=$(wildcard *.asm)
HEADERS=$(wildcard *.h)
OBJECTS_C=$(patsubst %.c,$(BUILD_DIR)/stage2/c/%.obj,$(SOURCES_C))
OBJECTS_ASM=$(patsubst %.asm,$(BUILD_DIR)/stage2/asm/%.obj,$(SOURCES_ASM))

.PHONY: all stage2 clean

all: stage2

stage2: $(BUILD_DIR)/stage2.bin

$(BUILD_DIR)/stage2.bin: $(OBJECTS_ASM) $(OBJECTS_C) linker.lnk Makefile
	$(LD16) NAME $(BUILD_DIR)/stage2.bin FILE \{ $(OBJECTS_ASM) $(OBJECTS_C) \} OPTION MAP=$(BUILD_DIR)/stage2.map @linker.lnk

$(BUILD_DIR)/stage2/c/%.obj: %.c $(HEADERS) Makefile | $(BUILD_DIR)/stage2/c
	$(CC16) $(CFLAGS16) -fo=$@ $<

$(BUILD_DIR)/stage2/asm/%.obj: %.asm Makefile | $(BUILD_DIR)/stage2/asm
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/stage2/c $(BUILD_DIR)/stage2/asm:
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)/stage2 $(BUILD_DIR)/stage2.bin $(BUILD_DIR)/stage2.map
