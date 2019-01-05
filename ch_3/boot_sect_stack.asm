;
; Stack example
;

mov ah, 0x0e      ; scrolling teletype BIOS routine int 10

mov bp, 0x8000    ; Set up stack pointers
mov sp, bp

push 'A'
push 'B'
push 'C'

mov bx, [0x7ffe]  ; Print 'A'
mov al, bl
int 0x10

mov bx, [0x7ffa]  ; Print 'C'
mov al, bl
int 0x10

pop bx            ; Pop and print 'C'
mov al, bl
int 0x10

pop bx            ; Pop and print 'B'
mov al, bl
int 0x10

pop bx            ; Pop and print 'A'
mov al, bl
int 0x10

jmp $             ; Jump here

times 510-($-$$) db 0
dw 0xaa55
