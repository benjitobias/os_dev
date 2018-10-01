mov ah, 0x0e ; tty

mov al, [the_secret]
int 0x10 ; we know this doesn't work already

mov bx, [0x7c0] ; this segment is automatically <<4
mov ds, bx
; all memory references will now be offset by 'ds' implicitly
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10 ; doesn't look right. es currently 0x000

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10


jmp $ ; jump to current address (infinite loop)


; data
the_secret:
	db 'X'


; padding and magic number indicating boot sector
times 510-($-$$) db 0
dw 0xaa55
