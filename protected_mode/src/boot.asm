[bits 16]
org 0x7C00 

start:

    ;enable a20 line 
    mov ax, 0x2401 
    int 0x15    

    mov ax, 0x3 
    int 0x10 
    cli 

    mov ah, 0x2 ;read sector 
    mov al, 1   ;sector sto read 
    mov ch, 0   ;cylinder idx 
    mov dh, 0   ;head idx 
    mov cl, 2   ;sector idx 
    mov dl, [disk]; disk index 
    mov bx, copy_target; target pointer 
    int 0x13 

    cli 

    lgdt [gdt_pointer]
    
    mov eax, cr0 
    or  eax, 0x1 
    mov cr0, eax 
    mov ax, DATA_SEG
    mov ds, ax 
    mov es, ax 
    mov fs, ax 
    mov gs, ax 
    mov ss, ax 
    jmp CODE_SEG:boot2


;NULL descriptor- first entry in gdt 
gdt_start: 
    dq  0x0 


;GDT entries 
;8 bytes each

gdt_code_segment:
    dw  0xFFFF
    dw  0x0 
    db  0x0 
    db  10011010b 
    db  11001111b
    db  0x0

gdt_data_segment:

    dw  0xFFFF
    dw  0x0 
    db  0x0 
    db  10010010b 
    db  11001111b
    db  0x0

gdt_end:

gdt_pointer:
    dw  gdt_end - gdt_start - 1 
    dd  gdt_start

disk:
    db 0x0 

CODE_SEG equ gdt_code_segment - gdt_start
DATA_SEG equ gdt_data_segment - gdt_start 

times 510 - ($-$$) db 0 
dw 0xAA55 

copy_target:

;Protected Mode 
[bits 32]
    
    boot_msg: db "HELLO WORLD FROM BEYOND 512!!", 0 

boot2:
    mov ax, DATA_SEG
    mov ds, ax 
    mov es, ax 
    mov fs, ax 
    mov gs, ax 
    mov ss, ax 

    mov esi, boot_msg
    mov ebx, 0xB8000

.loop:
    lodsb 
    or al, al 
    jz halt
    or eax, 0x0F00 
    mov word [ebx], ax 
    add ebx, 2 
    jmp .loop 

halt:
    cli 
    hlt 






