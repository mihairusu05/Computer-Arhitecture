bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A dw 0111000011111000b 
    B dw 0000000000111111b 
    C dd 0

segment code use32 class=code
    start:
        mov ebx, 0 
        mov eax , 0
        
        mov ax, [A]            
        and ax, 0111000000000000b 
        shr ax, 12                
        or  ebx, eax   

         mov eax , 0

        mov ax, [B]            
        and ax, 0000000000111111b 
        shl ax, 3                 
        or  ebx, eax              
        
        mov eax , 0
        
        mov ax, [A]            
        and ax, 0000001111111000b 
        shl ax, 6                 
        or  ebx, eax  
            
         mov eax , 0

        movzx eax, word [A]       
        shl eax, 16               
        or  ebx, eax              ; Paste into Result

        mov [C], ebx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
