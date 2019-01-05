;
; Adderssing demo
;

[org 0x7c00]

mov ah, 0x0e        ; int 10 => ah = 0eh teletype inturrupt routine

; First attempt
mov al, the_secret
int 0x10

; Second attempt
mov al, [the_secret]
int 0x10

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
mov al, [0x7c2d]
int 0x10

; Fifth attempt
mov ax, 0x0e58
int 0x10

; Sixth attempt
mov bx, $$
add bx, the_secret
mov al, [bx]
int 0x10

jmp $               ; Jump here forever

the_secret:
  db "X"

; Padding and magic number for BIOS

times 510-($-$$) db 0
dw 0xaa55
