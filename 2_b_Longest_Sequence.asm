.MODEL SMALL
.STACK 100H
.DATA
PROMP_MSG_FOR_INPUT_STRING DB 'ENTER YOUR STRING: $'
PROMP_MSG_FOR_OUTPUT DB 'LONGEST SEQUENCE IS: $'
STR1 DB 100 DUP(0)
ANS DB 10 DUP('$')
CURRENT_LONGEST DW 0H
START DW 0H
LEN_OF_STR DW 0H

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    ;SHOW INPUT PROMPT
    MOV AH,9
    LEA DX,PROMP_MSG_FOR_INPUT_STRING
    INT 21H

    ;TAKE INPUT AND STORE IN STR
    MOV AH,1
    XOR SI,SI
    INPUT:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT
        MOV STR1[SI],AL
        INC SI
    JMP INPUT
    EXIT_FROM_INPUT:
    MOV LEN_OF_STR,SI
    
    LOOP1:
        MOV SI,START
        MOV CX,1
        LOOP2:
            MOV AL,STR1[SI]
            ; MOV AH,STR1[SI+1]
            MOV AH,AL
            INC AH
            CMP AH,STR1[SI+1]
            JNE BREAK_FROM_LOOP2
            INC SI
            INC CX
        JMP LOOP2
        BREAK_FROM_LOOP2:
        INC START
        CMP CX,CURRENT_LONGEST
        JLE  END_OF_LOOP1
        ;LONGER SEQ, NEED TO COPY
        MOV CURRENT_LONGEST,CX
        MOV SI,START
        DEC SI
        XOR DI,DI
        COPY:
            MOV AL,STR1[SI]
            MOV ANS[DI],AL
            INC SI
            INC DI
        LOOP COPY
        END_OF_LOOP1:
        ; CHECK IF START IS EXCEED 
        MOV AH,0
        MOV DI,START
        MOV AL,STR1[DI]
        CMP AH,AL
        JE BREAK_FROM_LOOP1
    JMP LOOP1
    BREAK_FROM_LOOP1:

    ;print ans
    MOV AH,9
    LEA DX,PROMP_MSG_FOR_OUTPUT
    INT 21H
    LEA DX,ANS
    INT 21H

    ;EXIT DOS
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN