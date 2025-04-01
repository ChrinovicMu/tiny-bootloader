[bits 16]
org 0x7C00 

start:
    cli 
    xor     ax, ax 
    mov     ds, ax 
    mov     es, ax 
    mov     ss, ax 

    ;enable a20 line 
    mov     ax, 0x2401 
    int     0x15        


;NULL descriptor- first entry in gdt 
gdt_start 
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
    db  10011010b 
    db  11001111b
    db  0x0

gdt_end:

gdt_pointer:
    dw  gdt_end - gdt_start - 1 
    dd  gdt_start

CODE_SEG equ gdt_code_segment - gdt_start
DATA_SEG equ gdt_data_segment = gdt_start 


;Protected Mode 
[bits 32]

boot2:
    mov ax, DATA_SEG
    mov ds, ax 
    mov es, ax 
    mov fs, ax 
    mov gs, ax 
    mov ss, ax 






