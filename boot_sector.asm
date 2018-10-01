mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; far away from 0x7c00 so that we won't get overwritten
mov sp, bp ; empty stack - sp = bp

push 'A'
push 'B'
push 'C'

; show the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; however, don't try to access [0x8000] now because it won't work
; you can only access the stack top so, ath this point, only 0z7ffe
mov al, [0x8000]
int 0x10

; recover characters using 'pop'
; we can only pop full words to we need a register to manipulate the lower byte
pop bx
mov al, bl
int 0x10 ; print "C"

pop bx
mov al, bl
int 0x10 ; print "B"

pop bx
mov al, bl
int 0x10 ; print "A"

; data pop's is garbage now
mov al, [0x8000]
int 0x10

jmp $ ; jump to current address (infinite loop)


; padding and magic number indicating boot sector
times 510-($-$$) db 0
dw 0xaa55
