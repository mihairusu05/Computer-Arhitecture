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
    s resb 100
    c1 dd 0
    c2 dd 0
    char_r db ' %c', 0
    string_p db 'result = %s', 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword s
        call [gets]
        add esp, 4*1
        
        push dword c1
        push dword char_r
        call [scanf]
        add esp, 4*2
        
        push dword c2
        push dword char_r
        call [scanf]
        add esp, 4*2
        
        mov esi, s
        mov al, byte[c2]
        mov bl, byte[c1]
        
        replace:
            mov dl, [esi]
            cmp dl, 0
            je end_replace
            
            cmp dl, al
            jne next_c
            mov [esi], bl
            
        next_c:
            inc esi
            jmp replace
            
        end_replace:
            push dword s
            push dword string_p
            call [printf]
            add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
