[org 0x7c00]
       
mov bp, 0xfffe          ; Move the base of the stack out of the way
mov sp, bp

mov si, MSG_REAL_MODE   ; Print the message that we are initially
call print_string_16    ; booting in 16-bit real mode

mov si, MSG_KERN_LOAD   ; Print the message that we are currently
call print_string_16    ; loading the kernel

mov al, 9               ; Prepare the registers for loading the kernel
mov bx, kernel_entry    ; from the disk into the location marked
call disk_load          ; as kernel_entry

call switch_to_pm       ; Switch to 32-bit protected mode

jmp $

; Include the necessary routines
%include "includes/print_16.asm"
%include "includes/print_32.asm"
%include "includes/switch_to_pm.asm"
%include "includes/disk_load.asm"

[bits 32]
BEGIN_PM:

    mov esi, MSG_PROT_MODE  ; Print the message that we successfully
    call print_string_32    ; loaded the 32-bit protected mode

    jmp kernel_entry        ; Load the kernel

[bits 16]
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_KERN_LOAD db "Loading kernel from disk", 0
MSG_PROT_MODE db "Successfully switched into 32-bit Protected Mode", 0

times 510-($-$$) db 0       ; Pad the rest of the boot sector with zeros
dw 0xaa55                   ; Mark the sector as a boot sector

kernel_entry:   ; Kernel code will be loaded here
