***********************************************************************
*
* Title:        LED Light ON/OFF and Switch ON/OFF
*
* Objective:    CMPEN 472 Homework 3
*
* Revision:     v1.0
*
* Date:         Feb. 1, 2023
*
* Orginal Programmer: Kyusun Choi 
*
* Programmer:   Sai Narayan
*
* Company:      The Pennsylvania State University
*               Department of Computer Science and Engineering
*
* Program:      LED 1 blink every 1 second
*               ON for 0.2sec, OFF for 0.8sec when switch 1 is NOT pressed
*               ON for 0.8sec, OFF for 0.2sec when switch 1 IS pressed
*
* Note:
*               On the CSM-12C128 board, 
*               Switch1 is @ PORTB bit 0, and
*               LED4 is at PORTB bit 7.
*               This program is developed and simulated using CodeWarrior 5.2
*               only, with switch simulation problem. So, one MUST set
*               Switch1 @ PORTB bit 0 as an OUTPUT, not an INPUT.
*               (If running on actual board, PORTB bit 0 must be INPUT).
*
* Algorithm:    Simple Parallel I/O use and time delay-loop
*
* Register use: A:    LED Light on/off state and Switch 1 on/off state
*               B:    Loop counters for LED2 ON & OFF periods of time
*               X:    Delay loop counters
*
* Memory use:   RAM locs from $3000 for data,
*               RAM locs from $3100 for prgm.
*
* Input:        Parameters hard-coded in the prgm - PORTB
*               Switch 1 at PORTB bit 0
*                 (set this bit as an output for simulation only - and add Switch)
*               Switch 2 at PORTB bit 1
*               Switch 3 at PORTB bit 2
*               Switch 4 at PORTB bit 3
*
* Output:        LED 1 at PORTB bit 4
*                LED 2 at PORTB bit 5
*                LED 3 at PORTB bit 6
*                LED 4 at PORTB bit 7
*
* Observation:  This is a program that blinks LED 1 & has LED 3 on all the time
*               and blinking period can be changed with the delay loop counter value.
*
* Comments:     This program is developed and simulated using CodeWarrior IDE
*               and targeted for Axion Manufacturing's CSM-12C128 board 
*               running at 24MHz.
*
***********************************************************************
* Parameter Declaration Section
*
* Export Symbols
        XDEF      pstart ; export "pgstart" symbol
        ABSENTRY  pstart ; for assembly entry point
        
* Symbols and Macros
PORTA   EQU       $0000   ; i/o port A addrs
PORTB   EQU       $0001   ; i/o port B addrs
DDRA    EQU       $0002   ; Data direction Register for Port A
DDRB    EQU       $0003   ; Data direction Register for Port B
***********************************************************************
* Data Section: addr used [$3000 to $30FF] RAM
*
          ORG       $3000   ;reserved RAM starting addr
                            ; for Data for CMPEN 472 class
Counter1  DC.W      $01F1   ;X register count number for time delay
                            ; inner loop for msec                          
On1       DC.B      $0005   ;duty cycle for LED1 when switch1 is off (5 ms)
On2       DC.B      $0041   ;duty cycle for LED1 when switch1 is on  (65 ms)
Off1      DC.B      $005F   ;fraction of second LED1 is off when switch1 is off
Off2      DC.B      $0023   ;fraction of second LED1 is off when switch1 is on                

                            
                            ;Remaining data memory space for stack,
                            ; up to prgm mem start.                            
*
***********************************************************************
* Program Section:  addr used [$3100 to $3FFF] RAM
*

            ORG       $3100         ;Program start address, in RAM
pstart      LDS       #$3100        ;init stack ptr

            LDAA      #%11110001    ;LED 1,2,3,4 @ PORTB bit 4,5,6,7
            STAA      DDRB          ;set PORTB bit 4,5,6,7 as output
                                    ;plus the bit 0 for Switch1
                                
            LDAA      #%10110000
            STAA      PORTB         ;turn off LED 1,2,4; turn ON LED3 
        
mainLoop     
            LDAA      PORTB         ;read switch 1 @ PORTB bit 0
            ANDA      #%00000001    ;if 0, run blinkLED1 when 0.05 msec on
            BNE       p65LED1       ;if 1, run blinkLED1 with 0.65 msec on
          
 
        
p05LED1                             ;Switch1 OFF, 
            LDAA      #%00010000    ;turn ON LED1 
            ORAA      PORTB
            STAA      PORTB             
                    
            LDAB      On1           ;load duty cycle for switch1 == OFF
p05LoopON   JSR       delay10US     ;delay
            DECB                    ;decrement the ON counter
          
            BNE       p05LoopON     ;loop time
          
            LDAA      #%11101111    ;turn off LED4 @ PORTB bit 7
            ANDA      PORTB
            STAA      PORTB
          
            LDAB      Off1          ;load off amount for switch1==OFF 
p05LoopOFF  JSR       delay10US
            DECB                    ;decrement the OFF counter
            
            BNE       p05LoopOFF    ;loop time            
        
            BRA       mainLoop      ;check switch, loop forever!
            
                                   
          
p65LED1                             ;Switch1 ON
            LDAA      #%00010000    ;turn ON LED1
            ORAA      PORTB
            STAA      PORTB
                                  
            LDAB      On2           ;load duty cycle for switch1 == OFF 
p65LoopON   JSR       delay10US    
            DECB                    ;decrement the ON counter
          
            BNE       p65LoopON     ;loop time
          
            LDAA      #%11101111    ;turn off LED1
            ANDA      PORTB
            STAA      PORTB
                    
            LDAB      Off2          ;load off amount for switch1==OFF
p65LoopOFF  JSR       delay10US
            DECB                    ;decrement the OFF counter
            
            BNE       p65LoopOFF    ;loop time
                       
            BRA       mainLoop      ;check switch, loop                    

***********************************************************************
* Subroutine Section: addr used [$3100 to $3FFF] RAM
*

;***********************************************************
; delay10US subroutine 
;
; This subroutine causes 10 usec. delay
;
; Input:  a 16bit count number in 'Counter1'
; Output: time delay, cpu cycle wasted
; Registers in use: X register, as counter
; Memory locations in use: a 16bit input number @ 'Counter1'
;
; Comments: one can add more NOPs to lengthen the delay time.
;

delay10US
          PSHX                  ;save X
          LDX   Counter1        ;short delay
          
dlyUSLoop NOP                   ;total time delay = X * NOP
          DEX
          BNE   dlyUSLoop
          
          PULX                  ;restore X
          RTS                   ;return                 
           
*
* Add any subroutines here
*

        END                     ;last line of a file
       














































