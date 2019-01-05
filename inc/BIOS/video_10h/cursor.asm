;
; @title BIOS cursor functions
;
; @short The following functions use BIOS int 0x10 calls
;        to get and manipulate cursor information.
;

;
; @desc Setup for setting cursor position with BIOS int 0x10.
;
; @reg BH [in]  Page number
; @reg DH [in]  Row
; @reg DL [in]  Col
; @reg AH [out] 0x02. set cursor value for int 0x10.
set_cursor:
  mov ah, 0x02
  int 0x10
  ret

;
; @desc Setup for getting cursor position with BIOS int 0x10.
;
; @reg BH [in]  Page number.
; @reg AH [out] 0x00
; @reg CH [out] Start scan line
; @reg CL [out] End scan line
; @reg DH [out] Row
; @reg DL [out] Col
get_cursor:
  mov ah, 0x03
  int 0x10
  ret

;
; @desc Move the crusor to the start of the next line.
;
new_line:
  pusha
  mov bh, 0x00      ; Set page number
  call get_cursor   ; Get cursor position
  add dh, 0x01      ; Increment row
  mov dl, 0x00      ; Reset Column
  call set_cursor   ; Set cursor position
  popa
  ret

