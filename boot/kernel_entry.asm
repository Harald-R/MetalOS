[bits 32]       ; Announce that 32-bit code will follow
[extern kmain]  ; Specify that kmain is defined in a different module

call kmain      ; Call the main kernel function
jmp $
