; receive data in 'dx'
; assume dx=0x1234 for example
print_hex:
	pusha

	mov cx, 0 ; index variable

; Strategy: get the last char of 'dx', then convert to ASCII
; Numeric ASCII values: '0' (ASCII 0x30) to '9' (0x39), so just add 0x30 to byte N.
; For alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (0x46) we'll add 0x40
; Then, move the ASCII byte to the correct position on the resulting string
hex_loop:
	cmp cx, 4 ; loop 4 times
	je end

	; 1. convert last char to ASCII
	mov ax, dx
	and ax, 0x000f ; 0x1234 -> 0x0004 but masking first three to zeroes
	add al, 0x30
	cmp al, 0x39 ; if > 9, add extra 8 to represent A to F
	jle step2
	add al, 7 ; 'A' is ASCII 65 instead of 58, so 65-58 = 7

step2:
	; 2. get correct position of string to place ASCII char
	; bx <- base address + string length - index of char
	mov bx, HEX_OUT + 5 ; base + length
	sub bx, cx ; index var
	mov [bx], al ; copy ASCII on 'al' to position pointed to by 'bx'
	ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

	; increment and loop
	add cx, 1
	jmp hex_loop

end:
	; prepare param and call function
	; print recieves in bx
	mov bx, HEX_OUT
	call print

	popa
	ret

HEX_OUT:
	db '0x0000', 0 ; reserve memory for our new string
