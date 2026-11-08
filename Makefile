ASM = nasm
CC = gcc
CC16 = wcc
LD16 = wlink

SRC_DIR = src
TOOLS_DIR = tools
BUILD_DIR ?= build

STAGE1_SOURCE = $(SRC_DIR)/bootloader/stage1/boot.asm
STAGE2_DIR = $(SRC_DIR)/bootloader/stage2
STAGE2_INPUTS = $(wildcard $(STAGE2_DIR)/*.c $(STAGE2_DIR)/*.asm $(STAGE2_DIR)/*.h) $(STAGE2_DIR)/linker.lnk $(STAGE2_DIR)/Makefile
KERNEL_SOURCE = $(SRC_DIR)/kernel/main.asm
FAT_DIR = $(TOOLS_DIR)/fat
FAT_INPUTS = $(wildcard $(FAT_DIR)/*.c $(FAT_DIR)/*.h) $(FAT_DIR)/Makefile

.PHONY: all floppy_image kernel bootloader stage1 stage2 clean tools_fat

all: floppy_image tools_fat

floppy_image: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: Makefile $(BUILD_DIR)/stage1.bin $(BUILD_DIR)/stage2.bin $(BUILD_DIR)/kernel.bin test.txt
	dd if=/dev/zero of=$@.tmp bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $@.tmp
	dd if=$(BUILD_DIR)/stage1.bin of=$@.tmp conv=notrunc
	mcopy -i $@.tmp $(BUILD_DIR)/stage2.bin "::stage2.bin"
	mcopy -i $@.tmp $(BUILD_DIR)/kernel.bin "::kernel.bin"
	mcopy -i $@.tmp test.txt "::test.txt"
	mmd -i $@.tmp "::mydir"
	mcopy -i $@.tmp test.txt "::mydir/test.txt"
	mv $@.tmp $@

bootloader: stage1 stage2

stage1: $(BUILD_DIR)/stage1.bin

$(BUILD_DIR)/stage1.bin: $(STAGE1_SOURCE) $(SRC_DIR)/bootloader/stage1/Makefile | $(BUILD_DIR)
	$(MAKE) -C $(SRC_DIR)/bootloader/stage1 BUILD_DIR=$(abspath $(BUILD_DIR)) ASM="$(ASM)"

stage2: $(BUILD_DIR)/stage2.bin

$(BUILD_DIR)/stage2.bin: $(STAGE2_INPUTS) | $(BUILD_DIR)
	$(MAKE) -C $(STAGE2_DIR) BUILD_DIR=$(abspath $(BUILD_DIR)) ASM="$(ASM)" CC16="$(CC16)" LD16="$(LD16)"

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: $(KERNEL_SOURCE) $(SRC_DIR)/kernel/Makefile | $(BUILD_DIR)
	$(MAKE) -C $(SRC_DIR)/kernel BUILD_DIR=$(abspath $(BUILD_DIR)) ASM="$(ASM)"

tools_fat: $(BUILD_DIR)/tools/fat.out

$(BUILD_DIR)/tools/fat.out: $(FAT_INPUTS) | $(BUILD_DIR)
	$(MAKE) -C $(FAT_DIR) BUILD_DIR=$(abspath $(BUILD_DIR)) CC="$(CC)"

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)
