bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    ; Define the input string
    A db 2, 4, 5, 7
    
    ; Calculate length constant
    lenA equ $ - A
    
    ; Reserve space for result B. 
    ; Logic: Length is lenA - 1. Type is Word (dw) to hold multiplication result.
    B times (lenA - 1) dw 0

segment code use32 class=code
start:
    ; --- Initialization ---
    mov ecx, lenA       ; Load length of A
    dec ecx             ; We need N-1 iterations. 
    jecxz final         ; Safety check: If A had length 0 or 1, jump to end.

    mov esi, 0          ; Source Index (for A)
    mov edi, 0          ; Destination Index (for B)

    ; --- The Loop ---
my_loop:
    ; Step 1: Get the first byte
    mov al, [A + esi]
    
    ; Step 2: Get the second byte (neighbor)
    mov bl, [A + esi + 1] 
    
    ; Step 3: Multiply
    ; Syntax: mul source
    ; Behavior: AX = AL * source
    mul bl 
    
    ; Step 4: Store the result (which is in AX) into B
    mov [B + edi], ax
    
    ; Step 5: Update indexes
    inc esi             ; A is bytes, so advance by 1
    add edi, 2          ; B is words (2 bytes), so advance by 2
    
    ; Step 6: Loop control
    loop my_loop        ; Decrements ECX. If ECX != 0, go to my_loop

final:
    ; Exit the program
    push dword 0
    call [exit]