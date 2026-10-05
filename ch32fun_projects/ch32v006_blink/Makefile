all: build

TARGET := blink
TARGET_MCU ?= CH32V006
CH32FUN_ROOT ?= ../../ch32fun
FLASH_COMMAND = $(MINICHLINK)/minichlink -c 0x1209b806 -C funprog -w $< flash -b

include $(CH32FUN_ROOT)/ch32fun/ch32fun.mk

build: $(TARGET).bin
flash: cv_flash
clean: cv_clean

.PHONY: all build flash clean
