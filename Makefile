
# Directories
SRC_DIR := src
BUILD_DIR := build

# Files
ASM_SRC := $(SRC_DIR)/boot.asm
CPP_SRC := $(SRC_DIR)/kmain.cpp
LD_SCRIPT := $(SRC_DIR)/linker.ld

ASM_OBJ := $(BUILD_DIR)/boot.o
KERNEL_BIN := $(BUILD_DIR)/kernel.bin

# Tools
NASM := nasm
CXX := i686-linux-gnu-g++
QEMU := qemu-system-x86_64

# Flags
NASM_FLAGS := -f elf32
CXX_FLAGS := -m32 -fno-pic -nostdlib -ffreestanding -std=c++11 \
             -mno-red-zone -fno-exceptions -fno-rtti -Wall -Wextra -Werror

# Targets
build: $(KERNEL_BIN)

# Ensure build directory exists manually before boot.o
$(BUILD_DIR)/boot.o:
	mkdir -p $(BUILD_DIR)
	$(NASM) $(NASM_FLAGS) $(ASM_SRC) -o $@

$(KERNEL_BIN): $(CPP_SRC) $(ASM_OBJ) $(LD_SCRIPT)
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXX_FLAGS) $(CPP_SRC) $(ASM_OBJ) -o $@ -T $(LD_SCRIPT)

run: build
	$(QEMU) -fda $(KERNEL_BIN)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: build run clean
