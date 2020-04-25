#start=Traffic_Lights.exe#

name "traffic"

data segment          ;XXXXBA9876543210
    TABLE_LIGHT     DW 0000100001100001B                           
                    DW 0000010001010001B                     
                    DW 0000001010001010B                                         
                    DW 0000001100001100B   
                    DW 0000000000000000B   

ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

 start:         
    MOV SI, OFFSET TABLE_LIGHT

 repeat:

 
    MOV AX, [SI]  
    cmp ax, 0000000000000000B     
    je start 
           
    
    OUT 4, AX      
    call PAUSE_5  
    
    add SI, 2     
    add BX, 2 
    jmp repeat
                                  
               
 amarelo:
     OUT 4, AX 
     call pause_1
     jmp repeat             
               
    
    mov ax, 4c00h 
    int 21h     
    
    
PAUSE_5:                   

    PUSH AX
    PUSH CX
    PUSH DX
    ; wait 5 seconds (5 million microseconds in cx e dx)
    mov     cx, 4Ch    ;    004C4B40h = 5,000,000
    mov     dx, 4B40h  ; each number in hexa has 4 bits
    mov     ah, 86h
    int     15h     
    POP DX
    POP CX
    POP AX
    ret 
    
    PAUSE_1:                   

    PUSH AX
    PUSH CX
    PUSH DX
    ; wait 5 seconds (5 million microseconds in cx e dx)
    mov     cx, 0Fh    ;    004C4B40h = 5,000,000
    mov     dx, 4240h  ; each number in hexa has 4 bits
    mov     ah, 86h
    int     15h     
    POP DX
    POP CX
    POP AX
    ret
ends

end start
