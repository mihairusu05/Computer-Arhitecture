bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    A db 2, 4, 5, 7
    lenA equ $ - A
    B times (lenA - 1) dw 0

segment code use32 class=code
start:
    mov ecx, lenA       
    dec ecx             
    jecxz final         

    mov esi, 0          
    mov edi, 0          

my_loop:
    mov al, [A + esi]
    mov bl, [A + esi + 1] 
    mul bl 
    mov [B + edi], ax
    inc esi             
    add edi, 2          
    
    loop my_loop       

final:
    push dword 0
    call [exit]