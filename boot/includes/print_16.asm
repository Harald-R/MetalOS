; Print a string contained in the 'si' register by using BIOS interrupt
print_string_16:
	pusha
	mov ah, 0x0e

	_print_string_16_loop:
		lodsb
		cmp al, 0
		je _print_string_16_end
		int 0x10
		jmp _print_string_16_loop

	_print_string_16_end:
		popa
		ret


; Print a 16-bit hex number contained in the 'dx' register
print_hex_16:
	pusha
	mov cx, 0 ; counter

	_print_hex_16_loop:
		cmp cx, 4                   ; End the loop
		je _print_hex_16_end

		mov ax, dx                  ; Use 'ax' as the working register
		and ax, 0x000f              ; Mask the value: 0x1234 -> 0x0004
		add ax, 0x30                ; Transform into an ASCII number
		cmp ax, 0x39                ; Value over 0x39 means it's a letter
		jle _number
		add ax, 7                   ; It's a letter, so it should be transformed into an ASCII leter

		_number:
			mov bx, HEX_OUT+5       ; Give the address of the last character in HEX_OUT
			sub bx, cx              ; Move to the address of the character we're working with

			mov [bx], al            ; Change the value in said address
			ror dx, 4               ; Rotate address: 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

			inc cx                  ; Increment the counter
			jmp _print_hex_16_loop  ; Loop again

	_print_hex_16_end:
		mov si, HEX_OUT             ; Get string ready for printing 
		call print_string_16        ; Print the string
		popa
		ret

	HEX_OUT: db '0x0000',0          ; Template for the hex number
