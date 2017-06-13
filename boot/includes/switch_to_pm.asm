[bits 16]

%include "gdt.asm"

switch_to_pm:
    cli                     ; Disable interrupts

    lgdt [gdt_descriptor]   ; Load the GDT descriptor

    mov eax, cr0            ; Get the value stored in 'cr0'
    or eax, 0x1             ; Make sure the first bit is set to 1
    mov cr0, eax            ; Set the 32-bit mode bit in 'cr0'

    jmp CODE_SEG:init_pm    ; Perform a far jump, which will force
                            ; the CPU to flush the pipeline


[bits 32]

init_pm:
    mov ax, DATA_SEG        ; Update the segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Move the stack to the top of the free space
    mov esp, ebp

    call BEGIN_PM           ; Jump to the 32-bit code in the bootloader

[bits 16]
