;----------------------------------------;
; Toxic Gases Detector using MQ-2 Sensor ;
;----------------------------------------;
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;----------------------------------------
.equ  SCK, 5
.equ  MOSI, 3
.equ  SS, 2
;===========================================================================
.global main
;===========================================================================
main:
    CBI DDRC, 0			; Set PC0 as input

    RCALL SPI_MAX7219_init
;---------------------------------------------------------------------------
agn:
    IN    R21, PINC		; Read the input from port C
    MOV   R20, R21    
    
    CPI   R20, 0x01		; Compare the value of PC0 with 1
    BREQ  MAX7219_disp_text	; If PC0 is 1, branch to MAX7219_disp_text
    RJMP  MAX7219_disp_text2 	; If PC0 is 0, jump to MAX7219_disp_text2

    RJMP  agn            	; Repeat the process
;===========================================================================
SPI_MAX7219_init:
    LDI   R17, (1<<MOSI)|(1<<SCK)|(1<<SS)
    OUT   DDRB, R17       	; Set MOSI, SCK, SS as output
    
    LDI   R17, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
    OUT   SPCR, R17       	; Enable SPI as master, fsck=fosc/16
   
    LDI   R17, 0x0A      	; Set segment intensity (0 to 15)
    LDI   R18, 8          	; Intensity level = 8
    RCALL send_bytes      	; Send command & data to MAX7219
   
    LDI   R17, 0x0B       	; Set scan limit command
    LDI   R18, 0x06       	; 8 digits connected to MAX7219
    RCALL send_bytes      	; Send command & data to MAX7219
   
    LDI   R17, 0x0C       	; Set turn ON/OFF command
    LDI   R18, 0x01       	; Turn ON MAX7219
    RCALL send_bytes      	; Send command & data to MAX7219
    
    RET  
;===========================================================================
MAX7219_disp_text:
    RCALL active

    LDI   R17, 0x02       
    LDI   R18, 0b00111101       ; Data = d
    RCALL send_bytes      	; Send command & data to MAX7219
   
    LDI   R17, 0x03       
    LDI   R18, 0b01111101	; Data = a
    RCALL send_bytes		; Send command & data to MAX7219

    LDI   R17, 0x04       
    LDI   R18, 0b01110110       ; Data = n
    RCALL send_bytes		; Send command & data to MAX7219
    
    LDI   R17, 0x05       
    LDI   R18, 0b01111011       ; Data = g
    RCALL send_bytes		; Send command & data to MAX7219

    LDI R17, 0x06
    LDI R18, 0b01101111		; Data = e
    RCALL send_bytes		; Send command & data to MAX7219

    LDI R17, 0x07
    LDI R18, 0b01000110		; Data = r
    RCALL send_bytes		; Send command & data to MAX7219

    RCALL delay_2s
    
    RCALL agn
;---------------------------------------------------------------------------
MAX7219_disp_text2:
    RCALL nonactive
    LDI   R17, 0x02       
    LDI   R18, 0b00000001       ; Data = -
    RCALL send_bytes		; Send command & data to MAX7219

    LDI R17, 0x03
    LDI R18, 0b01011011		; Data = S
    RCALL send_bytes		; Send command & data to MAX7219

    LDI R17, 0x04
    LDI R18, 0b01110111		; Data = A
    RCALL send_bytes		; Send command & data to MAX7219
    
    LDI R17, 0x05
    LDI R18, 0b01000111		; Data = F
    RCALL send_bytes		; Send command & data to MAX7219

    LDI R17, 0x06
    LDI R18, 0b01001111		; Data = E
    RCALL send_bytes		; Send command & data to MAX7219

    LDI   R17, 0x07       
    LDI   R18, 0b00000001       ; Data = -
    RCALL send_bytes		; Send command & data to MAX7219

    RCALL delay_2s
    RCALL agn
;---------------------------------------------------------------------------
send_bytes:
    CBI   PORTB, SS		; Enable slave device MAX7219
    OUT   SPDR, R17		; Transmit command
ll2:  
    IN    R19, SPSR
    SBRS  R19, SPIF		; Wait for byte transmission to complete
    RJMP  ll2

    OUT   SPDR, R18		; Transmit data
ll3:  
    IN    R19, SPSR
    SBRS  R19, SPIF		; Wait for byte transmission to complete
    RJMP  ll3
   
    SBI   PORTB, SS		; Disable slave device MAX7219
    RET
;===========================================================================
active:
    CBI   PORTB, SS		; Enable slave device 

    SBI DDRB, 1			; Set PB1 as output for fan
    SBI DDRB, 0			; Set PB0 as output for buzzer

    ;OUT   SPDR, R17		; Transmit command
    SBI   PORTB, 0		; Turn on buzzer
    SBI   PORTB, 1		; Turn on fan

    SBI   PORTB, SS		; Disable slave device 

    RET
;---------------------------------------------------------------------------
nonactive:
    CBI   PORTB, SS		; Enable slave device 

    CBI DDRB, 1			; Set PB1 as output for fan
    CBI DDRB, 0			; Set PB0 as output for buzzer

    SBI   PORTB, SS		; Disable slave device

    RET
;===========================================================================
delay_2s:			; Delay 2s
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
