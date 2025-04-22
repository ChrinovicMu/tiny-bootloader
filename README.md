# Tiny BootLoader

## Overview

This project implements a basic bootloader. It is designed to boot a 32 bit 86 kernel flat binary file. 

## Prerequisites

To build and run this project, ensure the following tools are installed:

- **NASM**: Assembler for compiling the bootloader.
- **i686-linux-gnu-g++**: Cross-compiler for 32-bit x86 C++ code.
- **QEMU**: Emulator for running the kernel (specifically `qemu-system-x86_64`).
- **Make**: Build automation tool.

On a Debian-based system, you can install these dependencies with:

```bash
sudo apt-get install nasm g++-multilib qemu-system-x86 make
```

## Building the Project

The project uses a Makefile to automate the build process. To compile the kernel, run:

```bash
make build
```

This command:

1. Creates the `build/` directory if it does not exist.
2. Compiles `src/boot.asm` into `build/boot.o` using NASM.
3. Compiles and links `src/kmain.cpp` and `build/boot.o` into `build/kernel.bin` using the i686-linux-gnu-g++ compiler and the `linker.ld` script.

The resulting `build/kernel.bin` is the final kernel binary.

## Running the Kernel

To run the kernel in QEMU, execute:

```bash
make run
```

This command:

1. Ensures the kernel is built (by invoking the `build` target).
2. Launches QEMU with `build/kernel.bin` as a floppy disk image.

QEMU will emulate a 32-bit x86 system and boot the kernel.

## Cleaning Up

To remove all generated files in the `build/` directory, run:

```bash
make clean
```

## License

This project is provided as-is for educational purposes. No specific license is applied.
