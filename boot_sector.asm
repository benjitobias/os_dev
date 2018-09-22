[org 0x7c00] ; Auto calculate boot sector mem offset
mov ah, 0x0e ; tty mode
;mov al, 'H'
;int 0x10
;mov al, 'e'
;int 0x10
;mov al, 'l'
;int 0x10
;int 0x10
;mov al, 'o'
;int 0x10

mov al, [the_secret]
int 0x10

jmp $ ; jump to current address (infinite loop)

the_secret:
	db "X"

; padding and magic number indicating boot sector
times 510-($-$$) db 0
dw 0xaa55
