
USE32
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL main32_size
GLOBAL main32_init
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL

;-------------------------------------SECTION-------------------------------------------
section .main32

main32_init:

    call CS_SEL:func

    .guard:
    hlt
    jmp .guard


main32_end:

section .rutinas

func:
    push ebp
    mov ebp,esp

    push eax
;   hlt
    mov eax, 4
    
    pop eax
    
    mov esp, ebp
    pop ebp
    retf

end_func:
