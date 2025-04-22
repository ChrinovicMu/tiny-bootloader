# Simple Kernel Project

## Overview

This project implements a basic operating system kernel written in C++ and assembly. The kernel is designed to be compiled and run on a 32-bit x86 architecture using a custom build process. The project includes a bootloader and a minimal kernel entry point, which can be executed in the QEMU emulator.

## Project Structure

- **src/**: Contains source files.
  - `boot.asm`: Assembly code for the bootloader.
  - `kmain.cpp`: C++ code for the kernel's main entry point.
  - `linker.ld`: Linker script to define the memory layout of the kernel.
- **build/**: Output directory for compiled object files and the final kernel binary.

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

## Makefile Details

The Makefile defines the following key variables and targets:

- **Directories**:
  - `SRC_DIR`: Source directory (`src`).
  - `BUILD_DIR`: Build output directory (`build`).
- **Files**:
  - `ASM_SRC`: Bootloader source (`src/boot.asm`).
  - `CPP_SRC`: Kernel source (`src/kmain.cpp`).
  - `LD_SCRIPT`: Linker script (`src/linker.ld`).
  - `ASM_OBJ`: Bootloader object file (`build/boot.o`).
  - `KERNEL_BIN`: Final kernel binary (`build/kernel.bin`).
- **Tools**:
  - `NASM`: Assembler.
  - `CXX`: C++ cross-compiler.
  - `QEMU`: Emulator.
- **Flags**:
  - `NASM_FLAGS`: `-f elf32` for 32-bit ELF output.
  - `CXX_FLAGS`: Flags for a freestanding 32-bit kernel environment, disabling standard libraries, exceptions, and runtime type information.
- **Targets**:
  - `build`: Builds the kernel binary.
  - `run`: Builds and runs the kernel in QEMU.
  - `clean`: Removes the `build/` directory.

## Notes

- The project assumes a 32-bit x86 target architecture.
- The C++ code is compiled without the standard library (`-nostdlib`) and with minimal runtime support (`-ffreestanding`).
- The linker script (`linker.ld`) is critical for ensuring the correct memory layout of the kernel.
- QEMU is configured to boot the kernel as a floppy disk image (`-fda`).

## Future Improvements

- Add interrupt handling and basic device drivers.
- Implement a simple console for user interaction.
- Expand the kernel to support multitasking or a basic file system.

## License

This project is provided as-is for educational purposes. No specific license is applied.