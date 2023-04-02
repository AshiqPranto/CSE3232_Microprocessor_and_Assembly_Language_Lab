TITLE PGM4_1: ECHO PROGRAM
.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    

;DISPLAY PROMPT

    MOV AH,2
    MOV DL,'?'
    INT 21H         

;INPUT A CHARACTER
    
    MOV AH,1
    INT 21H
    MOV BL,AL
           
; GO TO NEW LINE

    MOV AH,2
    MOV DL,0DH
    INT 21H 
    
    MOV DL,0AH
    INT 21H
    
    
    MOV AH,2
    MOV DL,BL
    INT 21H 
    
MAIN ENDP   


    END MAIN