.MODEL SMALL
.STACK 100H
.DATA

    INPUT_MSG1 DB 'ENTER YOUR ARRAY OF NUMBERS: $'
    STR DB 100 DUP('$')
    OUTPUT_MSG1 DB 'AFTER SORTING: $'
    NEW_LINE DB '0AH','0DH','$'
    N DW ?

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    ;SHOW INPUT PROMPT
    MOV AH,9
    LEA DX,INPUT_MSG1
    INT 21H

    ; TAKE INPUT
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

    MOV N,CX ; STORE THE SIZE OF THE STRING TO N

    CALL BUBBLE_SORT
    ; PRINT NEW LINE
    ; MOV AH,9
    ; LEA DX,OUTPUT_MSG1
    ;INT 21H

    ; SHOW OUTPUT PROMPT
    MOV AH,9
    LEA DX,OUTPUT_MSG1
    INT 21H

    ;SHOW OUTPUT STRING AFTER SORTING
    LEA DX,STR
    INT 21H
    

MAIN ENDP


BUBBLE_SORT PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH N

    DEC N
    JE END_SORT
    SORT_LOOP:
        MOV CX,N
        XOR SI,SI
        MOV DI,1
        SWAP_N_TIMES:
            MOV AL,STR[SI]
            CMP AL,STR[DI]
            JL SKIP_SWAPPING ;REPLACE JL TO JG FOR DECREASING ORDER
                XCHG AL,STR[DI]
                MOV STR[SI],AL
            SKIP_SWAPPING:
            INC SI
            INC DI
        LOOP SWAP_N_TIMES

        DEC N
    JNE SORT_LOOP
    END_SORT:
    
    POP N
    POP SI
    POP DX
    POP CX
    POP BX
    RET
BUBBLE_SORT ENDP

END MAIN