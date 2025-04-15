

SYS_QEMU := qemu-system-x86_64 
SQ_FLAGS := -fda
ASS := nasm 
ASS_FLAGS :=  -f bin
SRC_DIR := src
TARGET := boot.bin 

SRCS :=  $(SRC_DIR)/boot.asm

.PHONY: build run clean

build:
	$(ASS) $(ASS_FLAGS) $(SRCS) -o $(TARGET)

run: build
	$(SYS_QEMU) $(SQ_FLAGS) $(TARGET)

clean:
	rm -f $(TARGET)

test: build
	valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --verbose ./main
.PHONY: git-push 
git-push:
	@git add .
	@read -p "commit msg : " msg; \
	git commit -m "$$msg"; \
	git push origin main 

