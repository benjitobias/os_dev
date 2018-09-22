; infinite loop (ef fd ff)
loop:
	jmp loop

times 510-($-$$) db 0
; Magic number inditcating boot sector
dw 0xaa55
