;
; @title BIOS teletype print
;
; @short The following functions use the BIOS to output
;        strings and characters to the screen.
;
; @long  Int 10 calls the BIOS video service.
;        Setting ah = 0x0e will write character from al
;        to screen in tty mode.
;

%ifndef BIOS_video10h_print
%define BIOS_video10h_print
; Jump to end to avoid calling code on include.
jmp BIOS_video10h_print_file_end

; NULL macro for ending strings explicitly.
%define NULL 0x00

;
; @desc Setup for printing with BIOS int 0x10.
;
; @reg AH [out] 0x0e. tty value for int 0x10.
set_mode_tty:
  mov ah, 0x0e      ; Set int 0x10 action to tty.
  ret               ; Return to caller.

;
; @desc Print a null terminated string to terminal.
;       This function will retain registers.
; 
; @reg BX [in] Address of the string to output.
;
print_string:
  pusha             ; Push all registers to the stack.
  cld               ; Clear direction flag.
  call set_mode_tty ; Setup BIOS int 0x10 for printing.
  call print_string_unsafe ; Print the string.
  popa              ; Restore all registers from the stack.
  ret               ; Return to caller.

;
; @desc Print a null terminated string to terminal.
;
; @reg AH [in] Must be 0x0e.
; @reg BX [in] Address of the string to output.
;
print_string_unsafe:
  mov si, bx        ; Load string address into string reg (DS).
  lodsb             ; Load first char into AL.
ps_print_loop:
  cmp al, NULL      ; Check for null character.
  je ps_string_end  ; if (char == NULL) break.
  int 0x10          ; Print the character in AL
  lodsb             ; Load next char into AL from DS. Increment DS.
  jmp ps_print_loop ; Jump to beginning of print loop.
ps_string_end:
  ret               ; Return to caller

;
; @desc Print a char to terminal.
;
; @reg AL [in] Character to output.
;
print_char:
  call set_mode_tty ; Setup for printing on int 0x10.
  int 0x10          ; BIOS video inturrupt.
  ret               ; Return to caller.

BIOS_video10h_print_file_end:
%endif ; BIOS_video10h_print
