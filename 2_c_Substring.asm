.MODEL SMALL
.STACK 100H
.DATA

OUTPUT_MSG_FOR_MAIN_STRING DB 'ENTER THE MAIN STRING: $'
OUTPUT_MSG_FOR_SUB_STRING DB 'ENTER THE SUBSTRING WHICH YOU WANT TO CHECK IN MAIN STRING: $'
SUBSTR1 DB 50 DUP(0)
MAINSTR DB 50 DUP(0)
LEN_OF_MAIN_STRING DW 0H
LEN_OF_SUBSTR DW 0H
YES_MSG DB 0DH,0AH,'YOUR GIVEN STRING IS A SUBTRING OF MAIN STRING$'
NO_MSG DB 0DH,0AH,'YOUR GIVEN STRING IS NOT A SUBTRING OF MAIN STRING$'
START DW 0H
STOP DW 0H
.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX

    ;SHOW INPUT PROMP FOR MAIN STRING
    MOV AH,9
    LEA DX,OUTPUT_MSG_FOR_MAIN_STRING
    INT 21H

    XOR SI,SI
    MOV AH,1
    INPUT_MAIN_STR:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT_MAIN_STR
        MOV MAINSTR[SI],AL
        INC SI
    JMP INPUT_MAIN_STR
    EXIT_FROM_INPUT_MAIN_STR:

    MOV LEN_OF_MAIN_STRING,SI

    ;SHOW INPUT MSG FOR SUBSTRING
    MOV AH,9
    LEA DX,OUTPUT_MSG_FOR_SUB_STRING
    INT 21H
    
    XOR SI,SI
    MOV AH,1
    INPUT_SUBSTR:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT_SUBSTR
        MOV SUBSTR1[SI],AL
        INC SI
    JMP INPUT_SUBSTR
    EXIT_FROM_INPUT_SUBSTR:
    
    MOV LEN_OF_SUBSTR,SI

    CMP LEN_OF_MAIN_STRING,0 ; CHECK IF MAIN STRING IS NULL OR NOT
    JE PRINT_NO_MSG

    CMP LEN_OF_SUBSTR,0 ;CHECK IF SUBSTR LENGS IS ZERO
    JE PRINT_NO_MSG
    MOV BX,LEN_OF_SUBSTR ;WE CANNOT DO MEMORY MEMORY OPERATION,THAT'S WHY WE HAVE TO USE REGISTER
    CMP LEN_OF_MAIN_STRING,BX
    JL PRINT_NO_MSG
    
    ;INITIALIZE SI,DI
    LEA DI,MAINSTR ; DI PTS TO MAINSTR
    MOV START,DI ; DI and SI pts to MAINSTR
    LEA SI,SUBSTR1 ; SI PTS TO SUBSTR
    CLD ;Traverse from left to right

    ;Calculate STOP
    MOV STOP,DI ; STOP has MAINSTR address
    MOV BX,LEN_OF_MAIN_STRING
    ADD STOP,BX ;ADD MAINSTR LENGTH
    MOV CX,LEN_OF_SUBSTR
    SUB STOP,CX ;SUBTRACT SUBSTR LENGTH
    
    TRAVERSE_MAINSTR:
        MOV DI,START ;RESET DI to current index of mainstr
        MOV CX,LEN_OF_SUBSTR
        LEA SI,SUBSTR1 ;RESET SI

        REPE CMPSB
        JE PRINT_YES_MSG
        ;Substring not found
        INC START
        ;BREAK IF START>STOP
        MOV AX,START
        CMP AX,STOP
        JG PRINT_NO_MSG ;EXIT

    JMP TRAVERSE_MAINSTR

    PRINT_YES_MSG:
        LEA DX,YES_MSG
        JMP DISPLAY_MSG

    PRINT_NO_MSG:
        LEA DX,NO_MSG

    DISPLAY_MSG:
        MOV AH,9
        INT 21H

    ;DOS EXIT
    MOV AH,4CH
    INT 21H 
MAIN ENDP

PRINT_NEW_LINE PROC

    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
    
PRINT_NEW_LINE ENDP

END MAIN

; ALTERNATIVE AND EASY WAY TO DO THE SAME THING

; .MODEL SMALL
; .STACK 100H
; .DATA

; TEXT DB "ASDHELOLSDFHELLO$"
; PATTERN DB "HELLO$"
; I DW 0D
; NOT_FOUND_MSG DB 'NOT FOUND SUBSTRING$'
; FOUND_MSG DB 'FOUND SUBSTRING$'

; .CODE
; MAIN PROC
    
;     MOV AX, @DATA
;     MOV DS, AX

;     CHECK:
;     MOV SI, I
;     XOR DI, DI
;     ITERATE_UNTIL_END:
;     CMP PATTERN[DI],'$'
;     JE FOUND
;     CMP TEXT[SI], '$'
;     JE NOT_FOUND

;     MOV DL, TEXT[SI]
;     CMP DL,PATTERN[DI]

;     JE MATCH

;     INC I 
;     JMP CHECK

;     MATCH:
;     INC SI
;     INC DI
;     JMP ITERATE_UNTIL_END

;     NOT_FOUND:
;     MOV AH,9
;     LEA DX, NOT_FOUND_MSG
;     INT 21H
;     JMP ALL_END

;     FOUND:
;     MOV AH,9
;     LEA DX,FOUND_MSG
;     INT 21H

;     ALL_END:
; MAIN ENDP
; END MAIN