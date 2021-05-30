USE16                  

EXTERN init32
GLOBAL reset_vector

section .reset

reset_vector:
    cli                  ;clear interrupts
    cld                  ;clear directions para la copia de memoria
    jmp dword init32

ALIGN 16
