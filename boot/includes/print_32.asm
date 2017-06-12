; Print a string contained in the 'edx' register
[bits 32]

VIDEO_MEMORY equ 0xB8000    ; The text screen video memory location
WHITE_ON_BLACK equ 0x0F     ; Text attributes

print_string_32:
	pusha
   	mov edx, VIDEO_MEMORY           ; Set 'edx' to the start of the video memory

	_print_string_32_loop:
		mov al, [esi]               ; Store the character found in 'esi'
		mov ah, WHITE_ON_BLACK      ; Store the attributes of the character

		cmp al, 0                   ; End the loop if we reached the end
		je _print_string_32_end     ; of the string

		mov [edx], ax               ; Put the character and its attributes
                                    ; at the current character cell
		add esi, 1                  ; Move to the next character in string
		add edx, 2                  ; Move to the next character cell 

		jmp _print_string_32_loop   ; Loop again

	_print_string_32_end:
		popa
		ret

[bits 16]
