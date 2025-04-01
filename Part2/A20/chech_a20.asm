[bits 16]

check_a20:
    pushf 
    push ds 
    push es 
    push di 
    push si 

    cli 

    xor     ax, ax ; ax = 0 
    mov     es, ax ; 

    not     ax ; ax = 0xffff 
    mov     ds, ax 

    mov     di, 0x0500  ;offset in es (0x0000:0x0500) = 0x0500 
    mov     si, 0x0510  ; offset in ds (0xffff:0x0510) = 0x500 

    mov     al, byte [es:di]
    push    ax 

    mov     al, byte [ds:si]
    push    ax 



    





