;
; Simple loop boot sector
;

mov bx, 1            ; Load decimal 30 into reg b

cmp bx, 4           ; Compare value in reg b to 4
jle le_four           ; Jump if value is less or equal 4
cmp bx, 40          ; Compare value in reg b to 40
jl l_fourty           ; Jump if calue is less than 40
jmp else              ; Jump to the else block

le_four:              ; if (bx <= 4)
  mov al, 'A'         ; Load 'A' into lower byte of reg a
  jmp end_tag         ; Jump to the end_tag

l_fourty:             ; else if (bx < 40)
  mov al, 'B'         ; Load 'B' into lower byte of reg a
  jmp end_tag         ; Jump to the end_tag

else:                 ; else
  mov al, 'C'         ; Load 'C' into the lower byte of reg a
  jmp end_tag         ; Jump to the end_tag

end_tag:
  mov ah, 0x0e        ; Select scrolling teletype for int 0x10
  int 0x10            ; Throw inturrupt 0x10 printing character in a

jmp $                 ; Inf loop

times 510-($-$$) db 0 ; Fill in 510 bytes less existing byte count.

dw 0xaa55             ; Last two bytes to signify boot sector.
