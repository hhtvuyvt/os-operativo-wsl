BUILD_DIR?=build
CC?=gcc
CFLAGS = -ggdb

SOURCES_C=$(wildcard *.c)
OBJECTS_C=$(patsubst %.c, $(BUILD_DIR)/tools/fat/%.o, $(SOURCES_C))
HEADERS=$(wildcard *.h)

.PHONY: all fat clean

all: fat

fat: $(BUILD_DIR)/tools/fat.out

$(BUILD_DIR)/tools/fat.out: $(OBJECTS_C) Makefile
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/tools/fat.out $(OBJECTS_C)

$(BUILD_DIR)/tools/fat/%.o: %.c $(HEADERS) Makefile | $(BUILD_DIR)/tools/fat
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/tools/fat:
	mkdir -p $@

clean:
	rm -f $(BUILD_DIR)/tools/fat.out
	rm -rf $(BUILD_DIR)/tools/fat
