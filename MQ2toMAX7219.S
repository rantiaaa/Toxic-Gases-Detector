#define __SFR_OFFSET 0x00
#include "avr/io.h"

.equ  SCK, 5
.equ  MOSI, 3
.equ  SS, 2

.global main

main:
    CBI DDRC, 0            ; Set PC0 as input

    RCALL SPI_MAX7219_init

agn:
    IN    R21, PINC      ; Read the input from port C
    MOV   R20, R21    
    
    CPI   R20, 0x01      ; Compare the value of PC0 with 1
    BREQ  MAX7219_disp_text ; If PC0 is 1, branch to MAX7219_disp_text
    RJMP  MAX7219_disp_text2 ; If PC0 is 0, jump to MAX7219_disp_text2

    RJMP  agn            ; Repeat the process


SPI_MAX7219_init:
    LDI   R17, (1<<MOSI)|(1<<SCK)|(1<<SS)
    OUT   DDRB, R17       ;set MOSI, SCK, SS as output
    
    LDI   R17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
    OUT   SPCR, R17       ;enable SPI as master, fsck=fosc/16
   
    LDI   R17, 0x0A       ;set segment intensity (0 to 15)
    LDI   R18, 8          ;intensity level = 8
    RCALL send_bytes      ;send command & data to MAX7219
   
    LDI   R17, 0x0B       ;set scan limit command
    LDI   R18, 0x06       ;8 digits connected to MAX7219
    RCALL send_bytes      ;send command & data to MAX7219
   
    LDI   R17, 0x0C       ;set turn ON/OFF command
    LDI   R18, 0x01       ;turn ON MAX7219
    RCALL send_bytes      ;send command & data to MAX7219
    
    RET  

MAX7219_disp_text:
    RCALL active

    LDI   R17, 0x02       
    LDI   R18, 0b00111101       ;data = d
    RCALL send_bytes      ;send command & data to MAX7219
   
    LDI   R17, 0x03       
    LDI   R18, 0b01111101      ;data = a
    RCALL send_bytes      ;send command & data to MAX7219

    LDI   R17, 0x04       
    LDI   R18, 0b01110110       ;data = n
    RCALL send_bytes      ;send command & data to MAX7219
    
    LDI   R17, 0x05       
    LDI   R18, 0b01111011       ;data = g
    RCALL send_bytes      ;send command & data to MAX7219

    LDI R17, 0x06
    LDI R18, 0b01101111   ; data = e
    RCALL send_bytes    ;send command & data to MAX7219

    LDI R17, 0x07
    LDI R18, 0b01000110   ; data = r
    RCALL send_bytes    ;send command & data to MAX7219

    RCALL delay_2s
    
    RCALL agn

MAX7219_disp_text2:
    RCALL nonactive
    LDI   R17, 0x02       
    LDI   R18, 0b00000001       ;data = -
    RCALL send_bytes      ;send command & data to MAX7219

    LDI R17, 0x03
    LDI R18, 0b01011011   ;data = S
    RCALL send_bytes    ;send command & data to MAX7219

    LDI R17, 0x04
    LDI R18, 0b01110111     ;data = A
    RCALL send_bytes    ;send command & data to MAX7219
    
    LDI R17, 0x05
    LDI R18, 0b01000111     ;data = F
    RCALL send_bytes    ;send command & data to MAX7219

    LDI R17, 0x06
    LDI R18, 0b01001111     ;data = E
    RCALL send_bytes    ;send command & data to MAX7219

    LDI   R17, 0x07       
    LDI   R18, 0b00000001       ;data = -
    RCALL send_bytes      ;send command & data to MAX7219

    RCALL delay_2s
    RCALL agn

send_bytes:
    CBI   PORTB, SS       ;enable slave device MAX7219
    OUT   SPDR, R17       ;transmit command
ll2:  
    IN    R19, SPSR
    SBRS  R19, SPIF       ;wait for byte transmission
    RJMP  ll2             ;to complete

    OUT   SPDR, R18       ;transmit data
ll3:  
    IN    R19, SPSR
    SBRS  R19, SPIF       ;wait for byte transmission
    RJMP  ll3             ;to complete
   
    SBI   PORTB, SS       ;disable slave device MAX7219
    RET

active:
    CBI   PORTB, SS       ;enable slave device 

    SBI DDRB, 1            ; Set PB1 as output for fan
    SBI DDRB, 0            ; Set PB0 as output for buzzer

    ;OUT   SPDR, R17      ; transmit command
    SBI   PORTB, 0        ; Turn on buzzer
    SBI   PORTB, 1        ; Turn on fan

    SBI   PORTB, SS       ;disable slave device 

    RET

nonactive:
    CBI   PORTB, SS       ;enable slave device 

    CBI DDRB, 1            ; Set PB1 as output for fan
    CBI DDRB, 0            ; Set PB0 as output for buzzer

    SBI   PORTB, SS       ;disable slave device

    RET
    
delay_2s:                 ;delay 1.5s
    LDI   R21, 200
l6: LDI   R22, 255
l7: LDI   R23, 164
l8: DEC   R23
    BRNE  l8
    DEC   R22
    BRNE  l7
    DEC   R21
    BRNE  l6
    RET
