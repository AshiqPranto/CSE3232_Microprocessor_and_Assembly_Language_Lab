 .MODEL SMALL
 .STACK 100H
 .DATA
    
    STR DB 100 DUP('$')
    INPUT_MSG1 DB 'ENTER YOUR INPUT STRING:  $'
    OUTPUT_MSG DB 'OUTPUT STRING:  $'
    NEW_LINE DB 0AH,0DH,'$'
 .CODE
 
 MAIN PROC        
    MOV AX, @DATA
    MOV DS, AX

    ;Show input prompt
    MOV AH,9
    LEA DX,INPUT_MSG1
    INT 21H 

    ; TAKE INPUT
    
    MOV AH,1
    XOR SI,SI
    XOR CX,CX
    
    INPUT:
        INT 21H
        CMP AL, 0DH
        JE EXIT_INPUT
        MOV STR[SI],AL
        INC SI
    JMP INPUT
    EXIT_INPUT:        
    
    MOV AH,9   
    
    LEA DX, OUTPUT_MSG
    INT 21H 
    

    
    MOV CX,SI
    
    XOR SI,SI
    LOOP_THROUGH_STR:
        MOV DL,STR[SI]

        CMP DL, 'A'
        JL PRINT
        CMP DL, 'Z'
        JG CHECK_SMALL
        ADD DL,20H
        JMP PRINT

        CHECK_SMALL:
        CMP DL,'a'
        JL PRINT
        CMP DL, 'z'
        JG PRINT
        SUB DL, 20H
        JMP PRINT

        PRINT:
        MOV AH,2
        INT 21H
    INC SI
    LOOP LOOP_THROUGH_STR
    
    
 
    
 MAIN ENDP
 
 END MAIN