
USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL main32_size
GLOBAL main32_init

;-------------------------------------SECTION-------------------------------------------
section .main32

main32_init:
    
    ;call CS_SEL:func

    xchg bx,bx

    .guard:
        hlt
        jmp .guard


main32_end:

section .rutinas

func:

    push eax

    mov eax, 4
    
    pop eax
    retf

end_func:

