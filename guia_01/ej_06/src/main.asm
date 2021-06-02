
USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL kernel_size
GLOBAL kernel_init

;-------------------------------------SECTION-------------------------------------------
section .kernel

kernel_init:
    
    ;call CS_SEL:func

    xchg bx,bx

    .guard:
        hlt
        jmp .guard


kernel_end:

section .rutinas

func:

    push eax

    mov eax, 4
    
    pop eax
    retf

end_func:

