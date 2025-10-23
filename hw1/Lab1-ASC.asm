bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b db 2
    c dw 3
    d dw 4

; our code starts here

;I have to compute (b - a) + 3 + (d - c)
segment code use32 class=code
    start:
        MOV AL, [b]
        MOV AH, 0; AX=b
        
        MOV CL, [a] ;CX = a
        MOV CH,0
        
        SUB AX, CX  ;Ax = Ax - Cx = b - a
        
        ADD AX, 3   ;Ax = Ax + 3 = (b-a) + 3
        
        ADD AX, [d] ;Ax = Ax + d = (b-a) + 3 + d
        
        SUB AX, [c] ;Ax = Ax - c = (b-a) + 3 + (d - c) 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
