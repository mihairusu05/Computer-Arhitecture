bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    S dd 12345678h, 1a2b3c4dh
    len equ ($ - S) / 4
    D times len db 0

; our code starts here
segment code use32 class=code
start:
    mov ecx, len       
    jecxz final 
    mov esi, 0         
    mov edi, 0         

my_loop:
    mov eax, [S + esi] 
    mov [D + edi], al  
    add esi, 4         
    inc edi            

    loop my_loop       

final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
