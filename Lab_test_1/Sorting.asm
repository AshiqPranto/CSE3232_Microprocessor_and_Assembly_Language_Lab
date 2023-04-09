.MODEL SMALL
.STACK 100H
.DATA
    INPUT_MSG DB 'ENTER YOUR STRING: $'
    OUTPUT_MSG DB 'AFTER SORTING: $'
    STR1 DB 100 DUP('$')
    LEN_OF_STR DW 0D
    START DB 0D
.CODE

;description
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    ;SHOW INPUT MSG
    MOV AH,9D
    LEA DX,INPUT_MSG
    INT 21H

    ;TAKE INPUT
    MOV AH,1D
    XOR CX,CX
    XOR SI,SI
    INPUT:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT
        MOV STR1[SI],AL
        INC SI
        INC CX
    JMP INPUT
    EXIT_FROM_INPUT:

    MOV LEN_OF_STR,SI
    
    ;BUBBLE SORT
    DEC LEN_OF_STR
    JE END_SORT

    LOOP1:
        MOV SI,0D
        MOV DI,1D
        MOV CX,LEN_OF_STR

        LOOP2:
            MOV AL,STR1[SI]
            MOV AH,STR1[DI]
            CMP AL,AH
            JLE SKIP_SWAPPING
                XCHG AL,STR1[DI]
                MOV STR1[SI],AL
            SKIP_SWAPPING:
            INC SI
            INC DI
        LOOP LOOP2

        DEC LEN_OF_STR
        JE END_SORT
    JMP LOOP1

    END_SORT:

    ;SHOW OUTPUT MSG
    MOV AH,9D
    LEA DX,OUTPUT_MSG
    INT 21H

    LEA DX,STR1
    INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN