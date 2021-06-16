USE16                  

;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN init32

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL reset_vector

section .reset

reset_vector:
    cli                  ;clear interrupts
    cld                  ;clear directions para la copia de memoria
    jmp dword init32

ALIGN 16
