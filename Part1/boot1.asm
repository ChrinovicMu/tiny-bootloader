[bits 16] ;tells nasm is 16 bit mode 
org 0x7c00 ; start outputing stuff at offset 0x7c00 

boot:
    mov si, hello   ;point ai register to hello label memory location 
    mov ah, 0x0e    ; tty bios interupt

.loop:
    lodsb 
    or al, al    ;is al == 0 
    jz halt      ;if al ==0 , jump to halt label
    int 0x10    ; run BIOS interutpt 0x10- video services 
    jmp .loop 

halt:
    cli; clear interutpt flag 
    hlt; halt execution 

hello : db "CHRINOVIC'S TERRIBLE BOOTLOADER...", 0 

times 510 - ($-$$)db 0; pad remaining t10 bytes with zeros 
dw 0xaa55 ;marks the 512 sectors bootable  
