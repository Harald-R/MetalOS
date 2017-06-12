; GDT
gdt_start:

gdt_null:       ; The null descriptor
	dd 0x0
	dd 0x0

gdt_code:       ; The code segment descriptor
	dw 0xffff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0

gdt_data:       ; The data segment register
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:        ; Used for calculating the size of the GDT

; GDT descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1  ; The size of the GDT
	dd gdt_start                ; Start writing the GDT

; Store the GDT segment descriptor offsets
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
