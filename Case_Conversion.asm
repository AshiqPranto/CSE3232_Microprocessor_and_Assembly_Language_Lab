.MODEL SMALL
.STACK 100H
.DATA
     
CR EQU 0DH
LF EQU OAH

MSG1 DB "Enter a lower case letter: $"
MSG2 DB 0DH,0AH,"IN UPPER CASE IT IS: "
CHAR DB ?,"$"

     
.CODE

MAIN PROC
    
 MOV AX,@DATA ; get data segment
 MOV DS,AX    ; initialize DS
 
 
 ; print msg1 in user prompt
 LEA DX,MSG1
 MOV AH,9
 INT 21H
 
 ;Take character Input
 MOV AH,1
 INT 21H
 
 ;case conversion
 SUB AL,20H
 
 ; print output
 MOV CHAR,AL
 
 LEA DX,MSG2
 MOV AH,9
 INT 21H
 
 
    
    
    MAIN ENDP

END MAIN