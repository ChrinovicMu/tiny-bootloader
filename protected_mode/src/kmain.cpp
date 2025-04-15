
extern "C" void kmain()
{
    const short color = 0x0F00;
    const char * boot_msg = "\nHELLO FROM MAIN KERNEL!!!";
    short * vga = (short *)0xb8000; 

    int x; 
    for(x = 0; x < 28; ++x)
    {
        vga[x+80] = color | boot_msg[x];
    }
}
