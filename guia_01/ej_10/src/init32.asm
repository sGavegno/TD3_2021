USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN DS_SEL
EXTERN CS_SEL
EXTERN _gdtr32
EXTERN _idtr32

EXTERN __SYS_TABLES_LMA
EXTERN __SYS_TABLES_VMA_LIN
EXTERN __SYS_TABLES_VMA_FIS
EXTERN __SYS_TABLES_VMA_END

EXTERN __SYS_TABLES_PAG_LMA
EXTERN __SYS_TABLES_PAG_VMA_LIN
EXTERN __SYS_TABLES_PAG_VMA_FIS
EXTERN __SYS_TABLES_PAG_VMA_END

EXTERN __VIDEO_LMA
EXTERN __VIDEO_VMA_LIN
EXTERN __VIDEO_VMA_FIS
EXTERN __VIDEO_VMA_END

EXTERN __DATOS_LMA
EXTERN __DATOS_VMA_LIN
EXTERN __DATOS_VMA_FIS
EXTERN __DATOS_VMA_END

EXTERN __HANDLER_LMA
EXTERN __HANDLER_VMA_LIN
EXTERN __HANDLER_VMA_FIS
EXTERN __HANDLER_VMA_END
 
EXTERN __KERNEL_LMA
EXTERN __KERNEL_VMA_LIN
EXTERN __KERNEL_VMA_FIS
EXTERN __KERNEL_VMA_END

EXTERN __TEXT_TAREA1_LMA
EXTERN __TEXT_TAREA1_VMA_LIN
EXTERN __TEXT_TAREA1_VMA_FIS
EXTERN __TEXT_TAREA1_VMA_END

EXTERN __TABLES_DIGITOS_LMA
EXTERN __TABLES_DIGITOS_VMA_LIN
EXTERN __TABLES_DIGITOS_VMA_FIS
EXTERN __TABLES_DIGITOS_VMA_END

EXTERN __DATA_TAREA1_LMA
EXTERN __DATA_TAREA1_VMA_LIN
EXTERN __DATA_TAREA1_VMA_FIS
EXTERN __DATA_TAREA1_VMA_END

EXTERN __BSS_TAREA1_LMA
EXTERN __BSS_TAREA1_VMA_LIN
EXTERN __BSS_TAREA1_VMA_FIS
EXTERN __BSS_TAREA1_VMA_END

EXTERN __RODATA_TAREA1_LMA
EXTERN __RODATA_TAREA1_VMA_LIN
EXTERN __RODATA_TAREA1_VMA_FIS
EXTERN __RODATA_TAREA1_VMA_END

EXTERN __STACK_KERNEL_LMA
EXTERN __STACK_KERNEL_VMA_LIN
EXTERN __STACK_KERNEL_VMA_LIN_END
EXTERN __STACK_KERNEL_VMA_FIS
EXTERN __STACK_KERNEL_END_VMA_FIS


EXTERN __STAK_TAREA1_LMA
EXTERN __STAK_TAREA1_VMA_LIN
EXTERN __STAK_TAREA1_VMA_LIN_END
EXTERN __STAK_TAREA1_VMA_FIS
EXTERN __STAK_TAREA1_VMA_END_FIS

                 

EXTERN kernel_init

EXTERN __VIDEO_VMA_LIN

EXTERN PROMEDIO_TABLA_DIGITOS

EXTERN carga_paginacion
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL init32
GLOBAL INICIO_TABLAS_PAGINACION
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
    mov esp, __STACK_KERNEL_END_VMA_FIS
    mov ebp, esp

    ;limpio la pila
    xor eax, eax
    mov edi, __STACK_KERNEL_VMA_FIS
    mov ecx, __STACK_KERNEL_VMA_LIN_END
    sub ecx, __STACK_KERNEL_VMA_LIN
    rep stosb

    ;Inicializar valor.
    mov eax, 0        
    mov [PROMEDIO_TABLA_DIGITOS], eax
    mov eax, __VIDEO_VMA_LIN

    call activar_gate_a20

;Habilitacion de paginacion
    call habilitar_paginacion

; Inicializar controlador de teclado.
    call init_TECLADO

; Inicializar timer para que interrumpa cada 54.9 milisegundos.
    call init_TIMER

; Inicializar ambos PIC usando ICW (Initialization Control Words).
    call init_PIC
       
    jmp CS_SEL:kernel_init
    
    .guard:
        hlt
        jmp .guard


copiar_codigo:

    mov esi, __SYS_TABLES_LMA               ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_VMA_FIS               ;Puntero a VMA
    mov ecx, __SYS_TABLES_VMA_END    
    sub ecx, __SYS_TABLES_VMA_LIN               ;Tamaño a copiar
    rep movsb     

    mov esi, __SYS_TABLES_PAG_LMA           ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_PAG_VMA_FIS           ;Puntero a VMA
    mov ecx, __SYS_TABLES_PAG_VMA_END    
    sub ecx, __SYS_TABLES_PAG_VMA_LIN           ;Tamaño a copiar
    rep movsb 

    mov esi, __VIDEO_LMA                    ;Puntero al inicio de la LMA
    mov edi, __VIDEO_VMA_FIS                    ;Puntero a VMA
    mov ecx, __VIDEO_VMA_END    
    sub ecx, __VIDEO_VMA_LIN                    ;Tamaño a copiar
    rep movsb     

    mov esi, __HANDLER_LMA                  ;Puntero al inicio de la LMA
    mov edi, __HANDLER_VMA_FIS                  ;Puntero a VMA
    mov ecx, __HANDLER_VMA_END
    sub ecx, __HANDLER_VMA_LIN                  ;Tamaño a copiar
    rep movsb 

    mov esi, __DATOS_LMA                    ;Puntero al inicio de la LMA
    mov edi, __DATOS_VMA_FIS                    ;Puntero a VMA
    mov ecx, __DATOS_VMA_END    
    sub ecx, __DATOS_VMA_LIN                    ;Tamaño a copiar
    rep movsb     

    mov esi, __TABLES_DIGITOS_LMA           ;Puntero al inicio de la LMA
    mov edi, __TABLES_DIGITOS_VMA_FIS           ;Puntero a VMA
    mov ecx, __TABLES_DIGITOS_VMA_END    
    sub ecx, __TABLES_DIGITOS_VMA_LIN           ;Tamaño a copiar
    rep movsb 

    mov esi, __KERNEL_LMA                   ;Puntero al inicio de la LMA
    mov edi, __KERNEL_VMA_FIS                   ;Puntero a VMA
    mov ecx, __KERNEL_VMA_END    
    sub ecx, __KERNEL_VMA_LIN                   ;Tamaño a copiar
    rep movsb

    mov esi, __TEXT_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_TAREA1_VMA_FIS              ;Puntero a VMA
    mov ecx, __TEXT_TAREA1_VMA_END    
    sub ecx, __TEXT_TAREA1_VMA_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __BSS_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __BSS_TAREA1_VMA_FIS              ;Puntero a VMA
    mov ecx, __BSS_TAREA1_VMA_END    
    sub ecx, __BSS_TAREA1_VMA_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_TAREA1_VMA_FIS              ;Puntero a VMA
    mov ecx, __DATA_TAREA1_VMA_END    
    sub ecx, __DATA_TAREA1_VMA_LIN              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __RODATA_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __RODATA_TAREA1_VMA_FIS              ;Puntero a VMA
    mov ecx, __RODATA_TAREA1_VMA_END    
    sub ecx, __RODATA_TAREA1_VMA_LIN             ;Tamaño a copiar
    rep movsb 

    mov esi, __STACK_KERNEL_LMA             ;Puntero al inicio de la LMA
    mov edi, __STACK_KERNEL_VMA_FIS             ;Puntero a VMA
    mov ecx, __STACK_KERNEL_VMA_LIN_END    
    sub ecx, __STACK_KERNEL_VMA_LIN             ;Tamaño a copiar
    rep movsb 

    mov esi, __STAK_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __STAK_TAREA1_VMA_FIS              ;Puntero a VMA
    mov ecx, __STAK_TAREA1_VMA_LIN_END    
    sub ecx, __STAK_TAREA1_VMA_LIN              ;Tamaño a copiar
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
    MOV AL,11931        ;Dividir 1193181 Hz por 11931. Eso da 100 Hz aprox. 10ms
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

    cli

    mov edi,INICIO_TABLAS_PAGINACION   ;Apuntar al inicio de la 1ra tabla.
    mov ecx,0x0400 * 2                 ;Cantidad de entradas del directorio(1024) y una tabla(1024)
    xor eax,eax                        ;Poner a cero esas entradas.
    rep stosd

;Tablas de sistema
    push 0x03
    push __SYS_TABLES_VMA_FIS
    push __SYS_TABLES_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16

;Tablas de Paginación
    push 0x03
    push __SYS_TABLES_PAG_VMA_FIS
    push __SYS_TABLES_PAG_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
        
;Video 
    push 0x03
    push __VIDEO_VMA_FIS
    push __VIDEO_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
            
;ISRs
    push 0x03
    push __HANDLER_VMA_FIS
    push __HANDLER_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
           
;Datos
    push 0x03
    push __DATOS_VMA_FIS
    push __DATOS_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
            
;Tabla de Dígitos
    push 0x03
    push __TABLES_DIGITOS_VMA_FIS
    push __TABLES_DIGITOS_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
    
;Kernel
    push 0x03
    push __KERNEL_VMA_FIS
    push __KERNEL_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16 
            
;TEXT Tarea1
    push 0x03
    push __TEXT_TAREA1_VMA_FIS
    push __TEXT_TAREA1_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
       
;BSS Tarea 1
    push 0x03
    push __BSS_TAREA1_VMA_FIS
    push __BSS_TAREA1_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
        
;Data Tarea 1
    push 0x03
    push __DATA_TAREA1_VMA_FIS
    push __DATA_TAREA1_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
       
;RODATA Tarea 1
    push 0x03
    push __RODATA_TAREA1_VMA_FIS
    push __RODATA_TAREA1_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
     
;Pila Kernel
    push 0x03
    push __STACK_KERNEL_VMA_FIS
    push __STACK_KERNEL_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
                    
;Pila Tarea 1
    push 0x03
    push __STAK_TAREA1_VMA_FIS
    push __STAK_TAREA1_VMA_LIN
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
   
;ROM
    push 0x03
    push 0xFFFF0000
    push 0xFFFF0000
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16
    
    push 0x03
    push 0xFFFF1000
    push 0xFFFF1000
    push INICIO_TABLAS_PAGINACION         
    call carga_paginacion
    add esp,16

    mov eax,INICIO_TABLAS_PAGINACION 
    mov cr3,eax                ;Apuntar a directorio de paginas.
 
;xchg bx,bx

    mov eax,cr0                 ;Activar paginacion encendiendo el
    or eax, 1 << 31             ;bit 31 CR0.
    mov cr0,eax 
    
    ret

activar_gate_a20:
     call empty_8042            ;Esperar hasta que se pueda acceder al 8042.
     mov al,0xD1                ;Comando de escritura al controlador.
     out 0x64,al
     call empty_8042            ;Esperar hasta que se pueda acceder al 8042.
     mov al,0xDF                ;Encender bit Gate A20.
     out 0x64,al
     call empty_8042            ;Esperar hasta que se pueda acceder al 8042.
     ret

empty_8042:
     in al,0x64
     test al,2
     jnz empty_8042
     ret