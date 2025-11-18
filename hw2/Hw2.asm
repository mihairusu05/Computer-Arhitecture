bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 3
    b db 3
    d dw 0

; our code starts here

;3. [-1+d-2*(b+1)]/a data types: a,b,c - byte, d - word and ->>>> -3 result

segment code use32 class=code
    start:
    ;expr1
        mov AL, [b]
        add AL, 1
        mov Bl, 2
        imul Bl
        
        ;2*(b+1)
        
        mov BX, AX
        
        mov AX, [d]
        sub AX, 1
        
        ;-1 + d
        
        sub AX, BX
        mov CL, [a]
        idiv CL
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
