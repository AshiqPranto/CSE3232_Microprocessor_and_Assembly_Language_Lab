 .MODEL SMALL
 .STACK 100H
 .DATA
               
 MSG DB 'XYZ'
 CHAR DB 'ABCD'
 N DW 4H
 
 .CODE
 MAIN PROC
         
 MOV AX,@DATA
 MOV DS,AX
             
             
 ;LOAD ALL POINTER AND STRING
 
 LEA SI,CHAR
 LEA AX,MSG
 MOV BX,N
 
 MOV AH,2
 MOV DX,[SI]
 INT 21H    
 INC SI
 MOV DX,[SI]
 INT 21H
 DEC SI
 ;INC SI
 ;MOV DX,[SI]
 ;INT 21H
 

 ;CALL REVERSE 
 
 MOV DI,SI
 MOV CX,BX
 DEC BX
 ;SHL BX,1
 ADD DI,BX
 SHR CX,1
 
 XCHG_LOOP:
 
    MOV AX,[SI]
    
    ;print AX
    MOV AH,2
    MOV DX,AX
    INT 21H
    ;end print
    
    
    XCHG AX,[DI]
    
    
    ;print AX
    MOV AH,2
    MOV DX,AX
    INT 21H
    ;end print
    
    
    
    MOV [SI],AX
    
    
    ;print [si]
    MOV AH,2
    MOV DX,[SI]
    INT 21H
    ;end print
    
    
 
    ADD SI,1
    SUB DI,1
    
 LOOP XCHG_LOOP
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 ;LEA SI,STR
 
 ;MOV AH,2
 ;MOV DX,SI[0]
 ;INT 21H
 
 
 
 ;MOV AH,2
 ;MOV DX,SI[0]
 ;INT 21H
 
 
 
     
 ;LEA BX,MSG
 ;MOV DX,48
 
 
 ;MOV DX,N
  
 ;MOV AH,2
 ;INT 21H         
 
 
    
 MAIN ENDP 
 
 
 REVERSE PROC
             
 PUSH AX
 PUSH BX
 PUSH CX
 PUSH SI
 PUSH DI
 
 ;MAKE DI TO nth word
 
 ;MOV AH,2
 ;MOV DX,[SI] 
 ;INT 21H
 
 ;MOV DI,SI
 ;ADD DI,2
 ;MOV DX,[DI]
 ;INT 21H
 
 ;MOV AX,[SI]
 ;XCHG AX,[DI]
 ;MOV [SI],AX

 ;MOV AH,2
 ;MOV DX,[SI] 
 ;INT 21H
 
 ;MOV DI,SI
 ;ADD DI,2
 ;MOV DX,[DI]
 ;INT 21H


 
 MOV DI,SI
 MOV CX,BX
 DEC BX
 ;SHL BX,1
 ADD DI,BX
 SHR CX,1
   
 ;PRINT CHARACTER  
    
 ;MOV AH,2
 ;MOV DX,SI[2]
 ;INT 21H
    
 
 ;SI points to 1st elements
 ;DI points to last elements
 ;swap elements
 
 
 
 XCHG_LOOP1:
 
    MOV AX,[SI]
    
    ;print AX
    MOV AH,2
    MOV DX,[SI]
    INT 21H
    ;end print
    
    
    XCHG AX,[DI]
    
    
    ;print AX
    MOV AH,2
    MOV DX,AX
    INT 21H
    ;end print
    
    
    
    MOV [SI],AX
    
    
    ;print [si]
    MOV AH,2
    MOV DX,[SI]
    INT 21H
    ;end print
    
    
    INC SI
    DEC DI
    ;ADD SI,1
    ;SUB DI,1
    
 LOOP XCHG_LOOP1
 
 ;PRINT NEW LINE
 
 ;MOV AH,2
 ;MOV DL,0DH
 ;INT 21H 
 
 ;MOV DL,0AH
 ;INT 21H

 
 POP DI
 POP SI
 POP CX
 POP BX
 POP AX   
    
 ;PRINT CHARACTER 
 
 ;MOV AH,2
 ;MOV DX,SI[2]
 ;int 21h


 REVERSE ENDP

 
 
 END MAIN