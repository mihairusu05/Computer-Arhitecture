bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern scanf, printf, gets
import scanf msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    res dd 0
    
    read db '%d', 0
    print db '%d * %d = %x', 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a
        push dword read
        call [scanf]
        add esp, 4*2
        
        push dword b
        push dword read
        call [scanf]
        add esp, 4*2
        
        mov eax, [a]
        imul eax, [b]
        mov [res], eax
        
        push dword [res]
        push dword [b]
        push dword [a]
        push dword print
        call [printf]
        add esp, 4*4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
