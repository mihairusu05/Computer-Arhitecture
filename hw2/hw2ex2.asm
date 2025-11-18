bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 0
    b db 10
    d db 2
    c dd 4
    x dq 10
    
    ;result should be 16

; our code starts here
segment code use32 class=code
;(8-a*b*100+c)/d+x
    start:
        mov AL, [d]
        cbw
        cwde
        mov EBX, EAX
        
        mov AL, [a]
        mov CL, [b]
        imul CL
        mov CX, 100
        imul CX
        
        push DX
        push AX
        pop EAX
        
        mov ECX, 8
        sub ECX, EAX
        add ECX, [c]
        mov EAX, ECX
        
        cdq
        idiv EBX
        cdq
        
        mov EBX, [x + 0]
        mov ECX, [x + 4]
        
        add EAX, EBX
        adc EDX, ECX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
