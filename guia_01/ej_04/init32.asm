USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL
EXTERN  _gdtr32
EXTERN  __STACK_END
EXTERN __STACK_START
EXTERN __RUTINAS_VMA
EXTERN __RUTINAS_LMA
EXTERN __RUTINAS_VMA_END
EXTERN __KERNEL_VMA 
EXTERN __KERNEL_LMA
EXTERN __KERNEL_VMA_END

EXTERN main32_init

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL init32

;-------------------------------------SECTION-------------------------------------------
section .init
init32:

    INCBIN "init16.bin"

    xchg bx,bx

    ;Copio el codigo a la VMA

    mov esi, __RUTINAS_LMA                  ;Puntero al inicio de la LMA
    mov edi, __RUTINAS_VMA                  ;Puntero a VMA
    mov ecx, __RUTINAS_VMA_END
    sub ecx, __RUTINAS_VMA                  ;Tamaño a copiar
    rep movsb 

    mov esi, __KERNEL_LMA                   ;Puntero al inicio de la LMA
    mov edi, __KERNEL_VMA                   ;Puntero a VMA
    mov ecx, __KERNEL_VMA_END    
    sub ecx, __KERNEL_VMA                   ;Tamaño a copiar
    rep movsb     

    lgdt[_gdtr32]                           ;Cargo nueva GDT 

    ;inicializo la pila
    mov ax, DS_SEL 
    mov ss, ax
    mov esp, __STACK_END
    mov ebp, esp

    ;limpio la pila
    xor eax, eax
    mov edi, __STACK_START
    mov ecx, __STACK_END
    sub ecx, __STACK_START
    rep stosb

    xor eax, eax

    xchg bx,bx
    jmp CS_SEL:main32_init

    .guard:
        hlt
        jmp .guard