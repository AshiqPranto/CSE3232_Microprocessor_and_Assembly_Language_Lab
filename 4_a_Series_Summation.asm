.MODEL SMALL
.STACK 100H
.DATA 
    INPUT_MSG DB 'ENTER YOUR NUMBER: $'
    NUM DB 0D
    OUTPUT_MSG DB 0DH,0AH,'SUMMATION IS: $'
    SUM DB 0D
    DIVIDEND DB 2D
.CODE
;description
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    ;SHOW INPUT PROMPT MSG
    MOV AH,9D
    LEA DX,INPUT_MSG
    INT 21H

    ;TAKE INPUT
    MOV AH,1
    INT 21H
    ;IMPLEMENT FORMULA (NUM*(NUM+1)/2)
    SUB AL,48D
    MOV NUM,AL
    INC NUM

    MUL NUM
    DIV DIVIDEND
    MOV SUM,AL
    ADD SUM,48D

    ;SHOW OUTPUT MSG
    MOV AH,9D
    LEA DX, OUTPUT_MSG
    INT 21H

    MOV AH,2D
    MOV DL, SUM
    INT 21H


    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN