print:
	pusha

; keep this in mind
; while (string[i] != 0 {print string[i]; i++})

; compare for null byte
start:
	mov al, [bx] ; bx is base address for string
	cmp al, 0
	je done

	; the part where we print with the BIOS help
	mov ah, 0x0e
	int 0x10

	; increment pointer and do next loop
	add bx, 1
	jmp start

done:
	popa
	ret

print_nl:
	pusha
	mov ah, 0x0e
	mov al, 0x0a ; newline \n
	int 0x10
	mov al, 0x0d ; carriage return \r
	int 0x10

	popa
	ret


