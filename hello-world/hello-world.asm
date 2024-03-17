  *=$0801
 
  .byte $0c,$08,$e2,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

  lda #$0d            ; Load the CR character into A to start a new line
  jsr $ffd2           ; Call the CHROUT routine to print it

  ldx #$00            ; Start with the first character of the string
    
print_loop
  lda message,x       ; Load the character at the current index of the message
  beq done_it         ; If it's the null terminator (0), we're done
  jsr $ffd2           ; Call CHROUT with the character in A
  inx                 ; Move to the next character in the message
  bne print_loop      ; Loop back if not done

done_it
  rts                 ; Return from subroutine, ends the program

message
 .encoding "screencodecommodore", "upper"
 
 .text "HELLO RETRO WORLD IN VICE!" ; The string to print, followed by a null terminator
 .byte 0
 .end
