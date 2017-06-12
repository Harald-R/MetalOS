disk_load:
	pusha

	mov ah, 2       ; Read sectors from drive
	;mov al, dh     ; The number of sectors to read
                    ; set before calling 'disk_load'
	mov ch, 0       ; The first cylinder
	mov dh, 0       ; The first read/write head
	mov cl, 2       ; The second sector

	push bx
	mov bx, 0       ; Specify the buffer into which
	mov es, bx      ; the data will be loaded
	pop bx          
	; mov bx, 0x7c00 + 512  ; Set before calling 'disk_load'

	int 0x13        ; Read the data specified by the above registers

	jc disk_error   ; Jump to error message if carry flag set (by BIOS)

	popa
	ret

disk_error:
	mov si, DISK_ERROR_MSG
	call print_string_16
	jmp $

DISK_ERROR_MSG: db "Disk read error!", 0
