*-----------------------------------------------------------
* Title      : Sring Converter 
* Written by : Adeeb Sait
* Date       : 19/04/2021
* Description: Displays user input string in reverse and uppercase
*-----------------------------------------------------------

      org     $400
start
      move.b  #1,d0
      lea     m0,a1
      moveq   #lenm0,d1
      trap    #15                                ;Take input from user
      move.b  #2,d0
      lea     buff,a1
      trap    #15                                ;Read the reply
      move    d1,blen                            ;Save the length of the reply
      bsr     ucase                              ;Convert name to uppercase
      move.b  #1,d0
      lea     m1,a1
      moveq   #lenm1,d1
      trap    #15                                
      lea     buff,a1
      move    blen,d1

      lea     m2,a1
      move.b  #lenm2,d1
      trap    #15                                ;Printing the message
      move.b  #6,d0
      lea     buff,a1
      move    blen,d2
      add     d2,a1
      subq    #1,d1
rloop move.b -(a1),d1                            ;Printing String backwards
      trap    #15
      dbra    d2,rloop
      moveq   #1,d2
      moveq   #0,d1
      move.b  #0,d0
nloop trap    #15                                ;Starting new line
      dbra    d2,nloop
      stop    #$2000

ucase
      move    blen,d1                            ;Uppercase
      lea     buff,a1
      bra     eloop
loop  move.b  (a1)+,d2
      cmp.b   #$61,d2
      blt     eloop
      cmp.b   #$7A,d2
      bgt     eloop
      sub.b   #$20,d2
      move.b  d2,-1(a1)
eloop dbra    d1,loop
      rts

m0    dc.b    'Enter String: '
lenm0 equ     *-m0
buff  ds.b    80
      ds.w    0
blen  ds.w    1
m1    dc.b    ''
lenm1 equ     *-m1
m2    dc.b    'Reversed and UpperCased String is: '
lenm2 equ     *-m2
      end     $400



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
