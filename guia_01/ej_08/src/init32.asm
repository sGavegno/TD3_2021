USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN DS_SEL
EXTERN CS_SEL
EXTERN _gdtr32
EXTERN _idtr32

EXTERN __SYS_TABLES_LMA
EXTERN __SYS_TABLES_VMA
EXTERN __SYS_TABLES_VMA_END

EXTERN __SYS_TABLES_PAG_LMA
EXTERN __SYS_TABLES_PAG_VMA
EXTERN __SYS_TABLES_PAG_VMA_END

EXTERN __DATOS_LMA
EXTERN __DATOS_VMA
EXTERN __DATOS_VMA_END

EXTERN __HANDLER_LMA
EXTERN __HANDLER_VMA
EXTERN __HANDLER_VMA_END
 
EXTERN __KERNEL_LMA
EXTERN __KERNEL_VMA
EXTERN __KERNEL_VMA_END

EXTERN __TEXT_TAREA1_LMA
EXTERN __TEXT_TAREA1_VMA
EXTERN __TEXT_TAREA1_VMA_END

EXTERN __TABLES_DIGITOS_LMA
EXTERN __TABLES_DIGITOS_VMA
EXTERN __TABLES_DIGITOS_VMA_END

EXTERN __DATA_TAREA1_LMA
EXTERN __DATA_TAREA1_VMA
EXTERN __DATA_TAREA1_VMA_END

EXTERN __STACK_KERNEL_LMA
EXTERN __STACK_KERNEL_VMA
EXTERN __STACK_KERNEL_VMA_END

EXTERN __STAK_TAREA1_LMA
EXTERN __STAK_TAREA1_VMA
EXTERN __STAK_TAREA1_VMA_END

EXTERN kernel_init

EXTERN BUFFER_VIDEO

EXTERN PROMEDIO_TABLA_DIGITOS
EXTERN PUNTERO_PANTALLA
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL init32

;-------------------------------------SECTION-------------------------------------------

INICIO_TABLAS_PAGINACION EQU 0x00010000            
INICIO_DIR_PAGINAS       EQU INICIO_TABLAS_PAGINACION
INICIO_TABLA_PAGINAS     EQU INICIO_DIR_PAGINAS + 0x1000

section .init
init32:

    INCBIN "./bin/init16.bin"

xchg bx,bx

    ;Copio el codigo a la VMA   
    jmp copiar_codigo

fin_copia_codigo:

    lgdt[_gdtr32]                           ;Cargo nueva GDT 
    lidt[_idtr32]                           ;Cargo IDT 

    ;inicializo la pila
    mov ax, DS_SEL 
    mov ss, ax
    mov esp, __STACK_KERNEL_VMA_END
    mov ebp, esp

    ;limpio la pila
    xor eax, eax
    mov edi, __STACK_KERNEL_VMA
    mov ecx, __STACK_KERNEL_VMA_END
    sub ecx, __STACK_KERNEL_VMA
    rep stosb

    ;Inicializar valor.
    mov eax, 0        
    mov [PROMEDIO_TABLA_DIGITOS], eax
    mov eax, BUFFER_VIDEO
    mov [PUNTERO_PANTALLA],eax


; Inicializar controlador de teclado.
    call init_TECLADO

; Inicializar timer para que interrumpa cada 54.9 milisegundos.
    call init_TIMER

; Inicializar ambos PIC usando ICW (Initialization Control Words).
    call init_PIC
    
;Habilitacion de paginacion
    call habilitar_paginacion



    ;xchg bx,bx
    jmp CS_SEL:kernel_init
    
    .guard:
        hlt
        jmp .guard


copiar_codigo:

    mov esi, __SYS_TABLES_LMA               ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_VMA               ;Puntero a VMA
    mov ecx, __SYS_TABLES_VMA_END    
    sub ecx, __SYS_TABLES_VMA               ;Tamaño a copiar
    rep movsb     

    mov esi, __HANDLER_LMA                  ;Puntero al inicio de la LMA
    mov edi, __HANDLER_VMA                  ;Puntero a VMA
    mov ecx, __HANDLER_VMA_END
    sub ecx, __HANDLER_VMA                  ;Tamaño a copiar
    rep movsb 

    mov esi, __TABLES_DIGITOS_LMA           ;Puntero al inicio de la LMA
    mov edi, __TABLES_DIGITOS_VMA           ;Puntero a VMA
    mov ecx, __TABLES_DIGITOS_VMA_END    
    sub ecx, __TABLES_DIGITOS_VMA           ;Tamaño a copiar
    rep movsb 

    mov esi, __DATOS_LMA                    ;Puntero al inicio de la LMA
    mov edi, __DATOS_VMA                    ;Puntero a VMA
    mov ecx, __DATOS_VMA_END    
    sub ecx, __DATOS_VMA                    ;Tamaño a copiar
    rep movsb     

    mov esi, __KERNEL_LMA                   ;Puntero al inicio de la LMA
    mov edi, __KERNEL_VMA                   ;Puntero a VMA
    mov ecx, __KERNEL_VMA_END    
    sub ecx, __KERNEL_VMA                   ;Tamaño a copiar
    rep movsb

    mov esi, __TEXT_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_TAREA1_VMA              ;Puntero a VMA
    mov ecx, __TEXT_TAREA1_VMA_END    
    sub ecx, __TEXT_TAREA1_VMA              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_TAREA1_VMA              ;Puntero a VMA
    mov ecx, __DATA_TAREA1_VMA_END    
    sub ecx, __DATA_TAREA1_VMA              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __STACK_KERNEL_LMA             ;Puntero al inicio de la LMA
    mov edi, __STACK_KERNEL_VMA             ;Puntero a VMA
    mov ecx, __STACK_KERNEL_VMA_END    
    sub ecx, __STACK_KERNEL_VMA             ;Tamaño a copiar
    rep movsb 

    mov esi, __STAK_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __STAK_TAREA1_VMA              ;Puntero a VMA
    mov ecx, __STAK_TAREA1_VMA_END    
    sub ecx, __STAK_TAREA1_VMA              ;Tamaño a copiar
    rep movsb 

    mov esi, __SYS_TABLES_PAG_LMA           ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_PAG_VMA           ;Puntero a VMA
    mov ecx, __SYS_TABLES_PAG_VMA_END    
    sub ecx, __SYS_TABLES_PAG_VMA           ;Tamaño a copiar
    rep movsb 

    jmp fin_copia_codigo

init_TECLADO:

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

    RET

init_TIMER:
    MOV AL,00110100b    ;Canal cero, byte bajo y luego byte alto.
    OUT 0x43,AL
    MOV AL,0            ;Dividir 1193181 Hz por 65536. Eso da 18,2 Hz aprox.
    OUT 0x40,AL         ;Programar byte bajo del timer de 16 bits.
    OUT 0x40,AL         ;Programar byte alto del timer de 16 bits.

    RET

init_PIC:
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
    MOV al, 11111100b    ;Activar solo IRQ1 poniendo estos bits a cero.
    OUT 0x21, al         ;Enviar máscara al primer PIC.

    MOV al, 11111111b    ;Todas desactivadas.
    OUT 0xA1, al         ;Enviar máscara al segundo PIC.

    STI                 ;Habilitar interrupciones

    RET


habilitar_paginacion:

    mov edi,INICIO_TABLAS_PAGINACION   ;Apuntar al inicio de la 1ra tabla.
    mov ecx,0x0400 * 2                 ;Cantidad de entradas del directorio(1024) y una tabla(1024)
    xor eax,eax                        ;Poner a cero esas entradas.
    rep stosd

    ;cargar directorio 0x000 
    mov dword [INICIO_DIR_PAGINAS],0x00011003              
    ;cargar directorio 0x0BF
    mov dword [INICIO_DIR_PAGINAS + 0x2FC], 0x000D0003         
    ;cargar tabla 0x000
    mov dword [INICIO_TABLA_PAGINAS], 0x00000003 
    ;cargar tabla 0x010
    mov dword [INICIO_TABLA_PAGINAS+ 0x010*4], 0x00010003
    ;cargar tabla 0x0B8
    mov dword [INICIO_TABLA_PAGINAS+ 0x0B8*4], 0x000B8003
    ;cargar tabla 0x100
    mov dword [INICIO_TABLA_PAGINAS+ 0x100*4], 0x00100003
    ;cargar tabla 0x200
    mov dword [INICIO_TABLA_PAGINAS+ 0x200*4], 0x00200003 
    ;cargar tabla 0x210
    mov dword [INICIO_TABLA_PAGINAS+ 0x210*4], 0x00210003
    ;cargar tabla 0x220
    mov dword [INICIO_TABLA_PAGINAS+ 0x220*4], 0x00220003
    ;cargar tabla 0x310
    mov dword [INICIO_TABLA_PAGINAS+ 0x310*4], 0x00310003
    ;cargar tabla 0x320
    mov dword [INICIO_TABLA_PAGINAS+ 0x320*4], 0x00320003
    ;cargar tabla 0x330
    mov dword [INICIO_TABLA_PAGINAS+ 0x330*4], 0x00330003
    ;cargar tabla 0x340
    mov dword [INICIO_TABLA_PAGINAS+ 0x340*4], 0x00340003
    ;cargar tabla 0x2F8
    mov dword [INICIO_TABLA_PAGINAS+ 0x2F8*4], 0x2FFF8003
    ;cargar tabla 0x2FF
    mov dword [INICIO_TABLA_PAGINAS+ 0x2FF*4], 0x2FFFF003

    mov eax,INICIO_TABLAS_PAGINACION
    mov cr3,eax                ;Apuntar a directorio de paginas.
    mov eax,cr4                ;Activar el bit Page Size Enable (bit 4
    or al,0x10                 ;de CR4) para habilitar las paginas grandes.
    mov cr4,eax
    mov eax,cr0                ;Activar paginacion encendiendo el
    or eax,0x80000000          ;bit 31 de CR0.
    mov cr0,eax

