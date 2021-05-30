USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN DS_SEL
EXTERN CS_SEL
EXTERN _gdtr32
EXTERN _idtr32

EXTERN __STACK_END
EXTERN __STACK_START

EXTERN __SYS_TABLES_LMA
EXTERN __SYS_TABLES_VMA
EXTERN __SYS_TABLES_VMA_END

EXTERN __DATA_LMA
EXTERN __DATA_VMA
EXTERN __DATA_VMA_END

EXTERN __RUTINAS_LMA
EXTERN __RUTINAS_VMA
EXTERN __RUTINAS_VMA_END
 
EXTERN __KERNEL_LMA
EXTERN __KERNEL_VMA
EXTERN __KERNEL_VMA_END

EXTERN main32_init

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL init32

;-------------------------------------SECTION-------------------------------------------
section .init
init32:

    INCBIN "init16.bin"

    ;xchg bx,bx

    ;Copio el codigo a la VMA
    mov esi, __SYS_TABLES_LMA               ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_VMA               ;Puntero a VMA
    mov ecx, __SYS_TABLES_VMA_END    
    sub ecx, __SYS_TABLES_VMA               ;Tamaño a copiar
    rep movsb     

    mov esi, __DATA_LMA                    ;Puntero al inicio de la LMA
    mov edi, __DATA_VMA                    ;Puntero a VMA
    mov ecx, __DATA_VMA_END    
    sub ecx, __DATA_VMA                    ;Tamaño a copiar
    rep movsb     

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
    lidt[_idtr32]                           ;Cargo IDT 

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


; Inicializar controlador de teclado.
    MOV al, 0xFF         ;Enviar comando de reset al controlador
    OUT 0x64, al         ;de teclado
    MOV ecx, 256         ;Esperar que rearranque el controlador.
    LOOP $
    MOV ecx, 0x10000
ciclo1:
    IN al, 0x60          ;Esperar que termine el reset del controlador.
    TEST al, 1
    LOOPZ ciclo1
    MOV al, 0xF4         ;Habilitar el teclado.
    OUT 0x64, al
    MOV ecx, 0x10000
ciclo2:
    IN al, 0x60          ;Esperar que termine el comando.
    TEST al, 1
    LOOPZ  ciclo2
    IN al, 0x60          ;Vaciar el buffer de teclado.

; Inicializar ambos PIC usando ICW (Initialization Control Words).
; ICW1 = Indicarle a los PIC que estamos inicializándolo.
    MOV al, 0x11        ;Palabra de inicialización (bit 4=1) indicando que 
                        ;se necesita ICW4 (bit 0=1)
    OUT 0x20, al        ;Enviar ICW1 al primer PIC.
    OUT 0xA0, al        ;Enviar ICW1 al segundo PIC.
    
; ICW2 = Indicarle a los PIC cuales son los vectores de interrupciones.
    MOV al, 0x20       ;El primer PIC va a usar los tipos de interr 0x20-0x27.
    OUT 0x21, al       ;Enviar ICW2 al primer PIC.
    MOV al, 0x28       ;El segundo PIC va a usar los tipos de interr 0x28-0x2F.
    OUT 0xA1, al       ;Enviar ICW2 al segundo PIC.
        
; ICW3 = Indicarle a los PIC como se conectan como master y slave.        
    MOV al, 4            ;Decirle al primer PIC que hay un PIC esclavo en IRQ2.
    OUT 0x21, al         ;Enviar ICW3 al primer PIC.
    MOV al, 2            ;Decirle al segundo PIC su ID de cascada (2).
    OUT 0xA1, al         ;Enviar ICW3 al segundo PIC.
        
; ICW4 = Información adicional sobre el entorno.    
    MOV al, 1            ;Poner el PIC en modo 8086.
    OUT 0x21, al         ;Enviar ICW4 al primer PIC.
    OUT 0xA1, al         ;Enviar ICW4 al segundo PIC.

; Indicar cuales son los IRQ habilitados.
    MOV al, 11111101b    ;Activar solo IRQ1 poniendo estos bits a cero.
    OUT 0x21, al         ;Enviar máscara al primer PIC.

    MOV al, 11111111b    ;Todas desactivadas.
    OUT 0xA1, al         ;Enviar máscara al segundo PIC.

    STI                 ;Habilitar interrupciones
    
    xor eax, eax
    
    xchg bx,bx
    jmp CS_SEL:main32_init
    
    .guard:
        hlt
        jmp .guard