BUILD_DIR?=build/
ASM?=nasm

.PHONY: all kernel clean

all: kernel

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: main.asm Makefile | $(BUILD_DIR)
	$(ASM) main.asm -f bin -o $@

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -f $(BUILD_DIR)/kernel.bin
