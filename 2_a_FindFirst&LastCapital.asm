.MODEL SMALL
.STACK 100H
.DATA

STR DB 100 DUP ('$')
INPUT_MSG1 DB 'ENTER YOUR INPUT STRING ALL IN CAPITAL LETTER: $'
OUTPUT_MSG1 DB 'REVERSED STRING: $'
NO_CAPITAL_MSG DB 0DH,0AH,'NO CAPITALS $'
CAP_MSG DB 0DH,0AH,'First Capital = '
FIRST DB '['
    DB ' , Last Capital = '
LAST DB '@$'
NEW_LINE DB '0AH','0DH','$'


.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX   

    ;Show input prompt
    MOV AH,9
    LEA DX,INPUT_MSG1
    INT 21H 

    ;TAKE INPUT
    XOR CX,CX
    XOR SI,SI
    MOV AH,1
    INPUT:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT
        MOV STR[SI],AL
        INC CX
        INC SI
        JMP INPUT
    EXIT_FROM_INPUT:

    ;LOOP THROUGH STR AND FIND FIRST AND LAST CAPITAL
    XOR SI,SI
    LOOP_THROUGH_STR:
    
        MOV DL,STR[SI]
        ;CHECK IF IT IS A CAPITAL LATTER OR NOT
        CMP DL,'A'
        JL NOT_CAPITAL

        CMP DL,'Z'
        JG NOT_CAPITAL

        CMP DL,FIRST
        JG CHECK_LAST

        MOV FIRST,DL

        CHECK_LAST:

        CMP DL,LAST

        JL NOT_CAPITAL
        MOV LAST,DL

        NOT_CAPITAL:
        INC SI

    LOOP LOOP_THROUGH_STR
    
    MOV AH,9
    LEA DX,CAP_MSG
    INT 21H



MAIN ENDP

END MAIN