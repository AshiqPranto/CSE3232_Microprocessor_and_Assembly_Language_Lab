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

    ;Print input message
    MOV AH,9
    LEA DX,INPUT_MSG1
    INT 21H

    ;Take input character one by one and store it in STR
    XOR SI,SI
    MOV AH,1
    INPUT:
        INT 21H
        CMP AL,0DH
        JE EXIT_FROM_INPUT
        MOV STR[SI],AL
        INC SI
        JMP INPUT
    EXIT_FROM_INPUT:

    ;Printing outpute prompt
    MOV AH,9
    LEA DX,OUTPUT_MSG1
    INT 21H

    MOV AH,2
    
    ; Printing output
    DEC SI
    PRINT_OUTPUT:
    
    MOV DL,STR[SI]
    INT 21H
    
    CMP SI,0H 
    JE EXIT_FROM_OUTPUT
    DEC SI
    JMP PRINT_OUTPUT

    EXIT_FROM_OUTPUT:

    ; MOV AH,4CH
    ; INT 21H 

 MAIN ENDP
 
 END MAIN