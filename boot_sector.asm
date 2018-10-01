[org 0x7c00] ; auto calculate offset

; prepare params and then call functions
mov bx, HELLO
call print
call print_nl

mov bx, GOODBYE
call print
call print_nl

mov dx, "A"
call print_hex


jmp $ ; jump to current address (infinite loop)

; include subroutines
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data
HELLO:
	db 'Hello, World', 0

GOODBYE:
	db 'Goodbye', 0


; padding and magic number indicating boot sector
times 510-($-$$) db 0
dw 0xaa55
