bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    S dd 12345678h, 1a2b3c4dh
    len equ ($ - S) / 4
    D times len db 0

segment code use32 class=code
start:
    mov ecx, len       
    jecxz end_program  
    mov esi, 0         
    mov edi, 0         

my_loop:
    mov eax, [S + esi] 
    mov [D + edi], al  
    add esi, 4         
    inc edi            

    loop my_loop       

end_program:
    push dword 0
    call [exit]