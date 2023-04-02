.MODEL SMALL
.STACK 100H
.DATA

STR DB 100 DUP ('$')
INPUT_MSG1 DB 'ENTER YOUR INPUT STRING:$'
OUTPUT_MSG1 DB 'REVERSED STRING:$'
NEW_LINE DB '0AH','0DH','$'

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    ;Show input prompt
    MOV AH,9
    LEA DX,INPUT_MSG1
    INT 21H 

    ;Take input
    XOR CX,CX
    MOV AH,1
    INPUT:
        INT 21H 
        CMP AL,0DH
        JE EXIT_FROM_INPUT
        ; MOV STR[SI],AL
        PUSH AX
        INC CX
        JMP INPUT

    EXIT_FROM_INPUT:

    ;Display output prompt
    MOV AH,9
    LEA DX,OUTPUT_MSG1
    INT 21H 

    ;ShoW output
    JCXZ EXIT_FROM_OUTPUT ;IF NOT CHARACTER READ
    MOV AH,2
    OUTPUT:
        POP DX
        INT 21H 
    LOOP OUTPUT

    EXIT_FROM_OUTPUT:


MAIN ENDP

END MAIN