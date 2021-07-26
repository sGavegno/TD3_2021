USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN DS_SEL
EXTERN CS_SEL
EXTERN CS_SEL_11
EXTERN DS_SEL_11
EXTERN TSS_SEL
EXTERN _gdtr32
EXTERN _idtr32

EXTERN __INIT_ROM

EXTERN __SYS_TABLES_LMA
EXTERN __SYS_TABLES_LIN
EXTERN __SYS_TABLES_FIS
EXTERN __SYS_TABLES_VMA_END

EXTERN __SYS_TABLES_TSS_LMA
EXTERN __SYS_TABLES_TSS_LIN
EXTERN __SYS_TABLES_TSS_FIS
EXTERN __SYS_TABLES_TSS_VMA_END

EXTERN __SYS_TABLES_PAG_LMA
EXTERN __SYS_TABLES_PAG_LIN
EXTERN __SYS_TABLES_PAG_FIS
EXTERN __SYS_TABLES_PAG_VMA_END

EXTERN __SYS_TABLES_PAG_T1_LIN
EXTERN __SYS_TABLES_PAG_T1_FIS

EXTERN __SYS_TABLES_PAG_T2_LIN
EXTERN __SYS_TABLES_PAG_T2_FIS

EXTERN __SYS_TABLES_PAG_T3_LIN
EXTERN __SYS_TABLES_PAG_T3_FIS


EXTERN __VIDEO_LMA
EXTERN __VIDEO_LIN
EXTERN __VIDEO_FIS
EXTERN __VIDEO_VMA_END

EXTERN __DATOS_LMA
EXTERN __DATOS_LIN
EXTERN __DATOS_FIS
EXTERN __DATOS_VMA_END

EXTERN __TABLES_DIGITOS_LMA
EXTERN __TABLES_DIGITOS_LIN
EXTERN __TABLES_DIGITOS_FIS
EXTERN __TABLES_DIGITOS_VMA_END

EXTERN __HANDLER_LMA
EXTERN __HANDLER_LIN
EXTERN __HANDLER_FIS
EXTERN __HANDLER_VMA_END
 
EXTERN __KERNEL_LMA
EXTERN __KERNEL_LIN
EXTERN __KERNEL_FIS
EXTERN __KERNEL_VMA_END

EXTERN __FUNCIONES_LMA
EXTERN __FUNCIONES_LIN
EXTERN __FUNCIONES_FIS
EXTERN __FUNCIONES_VMA_END

EXTERN __TEXT_TAREA1_LMA
EXTERN __TEXT_TAREA1_LIN
EXTERN __TEXT_TAREA1_FIS
EXTERN __TEXT_TAREA1_VMA_END

EXTERN __DATA_TAREA1_LMA
EXTERN __DATA_TAREA1_LIN
EXTERN __DATA_TAREA1_FIS
EXTERN __DATA_TAREA1_VMA_END

EXTERN __BSS_TAREA1_LMA
EXTERN __BSS_TAREA1_LIN
EXTERN __BSS_TAREA1_FIS
EXTERN __BSS_TAREA1_VMA_END

EXTERN __RODATA_TAREA1_LMA
EXTERN __RODATA_TAREA1_LIN
EXTERN __RODATA_TAREA1_FIS
EXTERN __RODATA_TAREA1_VMA_END

EXTERN __TEXT_TAREA2_LMA
EXTERN __TEXT_TAREA2_LIN
EXTERN __TEXT_TAREA2_FIS
EXTERN __TEXT_TAREA2_VMA_END

EXTERN __DATA_TAREA2_LMA
EXTERN __DATA_TAREA2_LIN
EXTERN __DATA_TAREA2_FIS
EXTERN __DATA_TAREA2_VMA_END

EXTERN __BSS_TAREA2_LMA
EXTERN __BSS_TAREA2_LIN
EXTERN __BSS_TAREA2_FIS
EXTERN __BSS_TAREA2_VMA_END

EXTERN __RODATA_TAREA2_LMA
EXTERN __RODATA_TAREA2_LIN
EXTERN __RODATA_TAREA2_FIS
EXTERN __RODATA_TAREA2_VMA_END

EXTERN __TEXT_TAREA3_LMA
EXTERN __TEXT_TAREA3_LIN
EXTERN __TEXT_TAREA3_FIS
EXTERN __TEXT_TAREA3_VMA_END

EXTERN __DATA_TAREA3_LMA
EXTERN __DATA_TAREA3_LIN
EXTERN __DATA_TAREA3_FIS
EXTERN __DATA_TAREA3_VMA_END

EXTERN __BSS_TAREA3_LMA
EXTERN __BSS_TAREA3_LIN
EXTERN __BSS_TAREA3_FIS
EXTERN __BSS_TAREA3_VMA_END

EXTERN __RODATA_TAREA3_LMA
EXTERN __RODATA_TAREA3_LIN
EXTERN __RODATA_TAREA3_FIS
EXTERN __RODATA_TAREA3_VMA_END

EXTERN __TEXT_tarea0_LMA
EXTERN __TEXT_tarea0_LIN
EXTERN __TEXT_tarea0_FIS
EXTERN __TEXT_tarea0_VMA_END

EXTERN __DATA_tarea0_LMA
EXTERN __DATA_tarea0_LIN
EXTERN __DATA_tarea0_FIS
EXTERN __DATA_tarea0_VMA_END

EXTERN __BSS_tarea0_LMA
EXTERN __BSS_tarea0_LIN
EXTERN __BSS_tarea0_FIS
EXTERN __BSS_tarea0_VMA_END

EXTERN __RODATA_tarea0_LMA
EXTERN __RODATA_tarea0_LIN
EXTERN __RODATA_tarea0_FIS
EXTERN __RODATA_tarea0_VMA_END

EXTERN __STACK_KERNEL_LMA
EXTERN __STACK_KERNEL_LIN
EXTERN __STACK_KERNEL_LIN_END
EXTERN __STACK_KERNEL_FIS
EXTERN __STACK_KERNEL_END_FIS

EXTERN __STAK_TAREA1_LMA
EXTERN __STACK_TAREA1_LIN
EXTERN __STACK_TAREA1_LIN_END
EXTERN __STACK_TAREA1_FIS
EXTERN __STAK_TAREA1_VMA_END_FIS

EXTERN __STAK_TAREA2_LMA
EXTERN __STACK_TAREA2_LIN
EXTERN __STACK_TAREA2_LIN_END
EXTERN __STACK_TAREA2_FIS
EXTERN __STAK_TAREA2_VMA_END_FIS

EXTERN __STAK_TAREA3_LMA
EXTERN __STACK_TAREA3_LIN
EXTERN __STACK_TAREA3_LIN_END
EXTERN __STACK_TAREA3_FIS
EXTERN __STAK_TAREA3_VMA_END_FIS

EXTERN __STAK_tarea0_LMA
EXTERN __STACK_tarea0_LIN
EXTERN __STACK_tarea0_LIN_END
EXTERN __STACK_tarea0_FIS
EXTERN __STAK_tarea0_VMA_END_FIS

EXTERN __STACK_KERNEL_T1_FIS
EXTERN __STACK_KERNEL_T1_END_FIS
EXTERN __STACK_KERNEL_T1_LIN
EXTERN __STACK_KERNEL_T1_END_LIN

EXTERN __STACK_KERNEL_T2_FIS
EXTERN __STACK_KERNEL_T2_END_FIS
EXTERN __STACK_KERNEL_T2_LIN
EXTERN __STACK_KERNEL_T2_END_LIN

EXTERN __STACK_KERNEL_T3_FIS
EXTERN __STACK_KERNEL_T3_END_FIS
EXTERN __STACK_KERNEL_T3_LIN
EXTERN __STACK_KERNEL_T3_END_LIN

EXTERN __STACK_KERNEL_T4_FIS
EXTERN __STACK_KERNEL_T4_END_FIS
EXTERN __STACK_KERNEL_T4_LIN
EXTERN __STACK_KERNEL_T4_END_LIN


EXTERN kernel_init

EXTERN __VIDEO_LIN

EXTERN PROMEDIO_TABLA_DIGITOS

EXTERN carga_paginacion_ROM
EXTERN carga_pag_ROM

EXTERN __CR3_kernel
EXTERN __CR3_tarea1
EXTERN __CR3_tarea2
EXTERN __CR3_tarea3
EXTERN __CR3_tarea0

EXTERN __TSS_kernel
EXTERN __TSS_tarea1
EXTERN __TSS_tarea2
EXTERN __TSS_tarea3
EXTERN __TSS_tarea0

EXTERN tarea_0
EXTERN tarea_1
EXTERN tarea_2
EXTERN tarea_3


;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL init32


;-------------------------------------SECTION-------------------------------------------

section .init
init32:

    INCBIN "./bin/init16.bin"

;xchg bx,bx

    ;Copio el codigo a la VMA   
    jmp copiar_codigo

fin_copia_codigo:

    lgdt[_gdtr32]                           ;Cargo nueva GDT 
    lidt[_idtr32]                           ;Cargo IDT 

    ;inicializo la pila
    mov ax, DS_SEL 
    mov ss, ax
    mov esp, __STACK_KERNEL_END_FIS
    mov ebp, esp

    ;limpio la pila
    xor eax, eax
    mov edi, __STACK_KERNEL_FIS
    mov ecx, __STACK_KERNEL_LIN_END
    sub ecx, __STACK_KERNEL_LIN
    rep stosb

    xor eax, eax
    mov edi, __STACK_TAREA1_FIS
    mov ecx, __STACK_TAREA1_LIN_END
    sub ecx, __STACK_TAREA1_LIN
    rep stosb

    xor eax, eax
    mov edi, __STACK_TAREA2_FIS
    mov ecx, __STACK_TAREA2_LIN_END
    sub ecx, __STACK_TAREA2_LIN
    rep stosb

    xor eax, eax
    mov edi, __STACK_TAREA3_FIS
    mov ecx, __STACK_TAREA3_LIN_END
    sub ecx, __STACK_TAREA3_LIN
    rep stosb

    xor eax, eax
    mov edi, __STACK_tarea0_FIS
    mov ecx, __STACK_tarea0_LIN_END
    sub ecx, __STACK_tarea0_LIN
    rep stosb

    ;Inicializar valor.
    mov eax, 0        
    mov [PROMEDIO_TABLA_DIGITOS], eax
    mov eax, __VIDEO_LIN

    call activar_gate_a20

;Habilitacion de paginacion
    call habilitar_paginacion

; Inicializar controlador de teclado.
    call init_TECLADO

; Inicializar timer para que interrumpa cada 54.9 milisegundos.
    call init_TIMER

; Inicializar ambos PIC usando ICW (Initialization Control Words).
    call init_PIC
       
;Inicializo TSS
    call init_TSS

    jmp CS_SEL:kernel_init
    
    .guard:
        hlt
        jmp .guard


copiar_codigo:

    mov esi, __SYS_TABLES_LMA               ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_FIS               ;Puntero a VMA
    mov ecx, __SYS_TABLES_VMA_END    
    sub ecx, __SYS_TABLES_LIN               ;Tamaño a copiar
    rep movsb     

    mov esi, __SYS_TABLES_TSS_LMA           ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_TSS_FIS           ;Puntero a VMA
    mov ecx, __SYS_TABLES_TSS_VMA_END    
    sub ecx, __SYS_TABLES_TSS_LIN           ;Tamaño a copiar
    rep movsb

    mov esi, __SYS_TABLES_PAG_LMA           ;Puntero al inicio de la LMA
    mov edi, __SYS_TABLES_PAG_FIS           ;Puntero a VMA
    mov ecx, __SYS_TABLES_PAG_VMA_END    
    sub ecx, __SYS_TABLES_PAG_LIN           ;Tamaño a copiar
    rep movsb 

    mov esi, __VIDEO_LMA                    ;Puntero al inicio de la LMA
    mov edi, __VIDEO_FIS                    ;Puntero a VMA
    mov ecx, __VIDEO_VMA_END    
    sub ecx, __VIDEO_LIN                    ;Tamaño a copiar
    rep movsb     

    mov esi, __HANDLER_LMA                  ;Puntero al inicio de la LMA
    mov edi, __HANDLER_FIS                  ;Puntero a VMA
    mov ecx, __HANDLER_VMA_END
    sub ecx, __HANDLER_LIN                  ;Tamaño a copiar
    rep movsb 

    mov esi, __DATOS_LMA                    ;Puntero al inicio de la LMA
    mov edi, __DATOS_FIS                    ;Puntero a VMA
    mov ecx, __DATOS_VMA_END    
    sub ecx, __DATOS_LIN                    ;Tamaño a copiar
    rep movsb     

    mov esi, __TABLES_DIGITOS_LMA           ;Puntero al inicio de la LMA
    mov edi, __TABLES_DIGITOS_FIS           ;Puntero a VMA
    mov ecx, __TABLES_DIGITOS_VMA_END    
    sub ecx, __TABLES_DIGITOS_LIN           ;Tamaño a copiar
    rep movsb 

    mov esi, __KERNEL_LMA                   ;Puntero al inicio de la LMA
    mov edi, __KERNEL_FIS                   ;Puntero a VMA
    mov ecx, __KERNEL_VMA_END    
    sub ecx, __KERNEL_LIN                   ;Tamaño a copiar
    rep movsb

    mov esi, __FUNCIONES_LMA                   ;Puntero al inicio de la LMA
    mov edi, __FUNCIONES_FIS                   ;Puntero a VMA
    mov ecx, __FUNCIONES_VMA_END    
    sub ecx, __FUNCIONES_LIN                   ;Tamaño a copiar
    rep movsb

    mov esi, __TEXT_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_TAREA1_FIS              ;Puntero a VMA
    mov ecx, __TEXT_TAREA1_VMA_END    
    sub ecx, __TEXT_TAREA1_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __BSS_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __BSS_TAREA1_FIS              ;Puntero a VMA
    mov ecx, __BSS_TAREA1_VMA_END    
    sub ecx, __BSS_TAREA1_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_TAREA1_FIS              ;Puntero a VMA
    mov ecx, __DATA_TAREA1_VMA_END    
    sub ecx, __DATA_TAREA1_LIN              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __RODATA_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __RODATA_TAREA1_FIS              ;Puntero a VMA
    mov ecx, __RODATA_TAREA1_VMA_END    
    sub ecx, __RODATA_TAREA1_LIN             ;Tamaño a copiar
    rep movsb

    mov esi, __TEXT_TAREA2_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_TAREA2_FIS              ;Puntero a VMA
    mov ecx, __TEXT_TAREA2_VMA_END    
    sub ecx, __TEXT_TAREA2_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __BSS_TAREA2_LMA              ;Puntero al inicio de la LMA
    mov edi, __BSS_TAREA2_FIS              ;Puntero a VMA
    mov ecx, __BSS_TAREA2_VMA_END    
    sub ecx, __BSS_TAREA2_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_TAREA2_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_TAREA2_FIS              ;Puntero a VMA
    mov ecx, __DATA_TAREA2_VMA_END    
    sub ecx, __DATA_TAREA2_LIN              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __RODATA_TAREA2_LMA              ;Puntero al inicio de la LMA
    mov edi, __RODATA_TAREA2_FIS              ;Puntero a VMA
    mov ecx, __RODATA_TAREA2_VMA_END    
    sub ecx, __RODATA_TAREA2_LIN             ;Tamaño a copiar
    rep movsb     

    mov esi, __TEXT_TAREA3_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_TAREA3_FIS              ;Puntero a VMA
    mov ecx, __TEXT_TAREA3_VMA_END    
    sub ecx, __TEXT_TAREA3_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __BSS_TAREA3_LMA              ;Puntero al inicio de la LMA
    mov edi, __BSS_TAREA3_FIS              ;Puntero a VMA
    mov ecx, __BSS_TAREA3_VMA_END    
    sub ecx, __BSS_TAREA3_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_TAREA3_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_TAREA3_FIS              ;Puntero a VMA
    mov ecx, __DATA_TAREA3_VMA_END    
    sub ecx, __DATA_TAREA3_LIN              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __RODATA_TAREA3_LMA              ;Puntero al inicio de la LMA
    mov edi, __RODATA_TAREA3_FIS              ;Puntero a VMA
    mov ecx, __RODATA_TAREA3_VMA_END    
    sub ecx, __RODATA_TAREA3_LIN             ;Tamaño a copiar
    rep movsb

    mov esi, __TEXT_tarea0_LMA              ;Puntero al inicio de la LMA
    mov edi, __TEXT_tarea0_FIS              ;Puntero a VMA
    mov ecx, __TEXT_tarea0_VMA_END    
    sub ecx, __TEXT_tarea0_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __BSS_tarea0_LMA              ;Puntero al inicio de la LMA
    mov edi, __BSS_tarea0_FIS              ;Puntero a VMA
    mov ecx, __BSS_tarea0_VMA_END    
    sub ecx, __BSS_tarea0_LIN              ;Tamaño a copiar
    rep movsb 

    mov esi, __DATA_tarea0_LMA              ;Puntero al inicio de la LMA
    mov edi, __DATA_tarea0_FIS              ;Puntero a VMA
    mov ecx, __DATA_tarea0_VMA_END    
    sub ecx, __DATA_tarea0_LIN              ;Tamaño a copiar
    rep movsb 
    
    mov esi, __RODATA_tarea0_LMA              ;Puntero al inicio de la LMA
    mov edi, __RODATA_tarea0_FIS              ;Puntero a VMA
    mov ecx, __RODATA_tarea0_VMA_END    
    sub ecx, __RODATA_tarea0_LIN             ;Tamaño a copiar
    rep movsb

    mov esi, __STACK_KERNEL_LMA             ;Puntero al inicio de la LMA
    mov edi, __STACK_KERNEL_FIS             ;Puntero a VMA
    mov ecx, __STACK_KERNEL_LIN_END    
    sub ecx, __STACK_KERNEL_LIN             ;Tamaño a copiar
    rep movsb 

    mov esi, __STAK_TAREA1_LMA              ;Puntero al inicio de la LMA
    mov edi, __STACK_TAREA1_FIS              ;Puntero a VMA
    mov ecx, __STACK_TAREA1_LIN_END    
    sub ecx, __STACK_TAREA1_LIN              ;Tamaño a copiar
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

    ;STI                 ;Habilitar interrupciones

    RET

;Funcion para habilitar paginacion
habilitar_paginacion:

    cli

    mov edi,__CR3_kernel   ;Apuntar al inicio de la 1ra tabla.
    mov ecx,0x400 *2                   ;Cantidad de entradas del directorio(1024) y una tabla(1024)
    xor eax,eax                        ;Poner a cero esas entradas.
    rep stosd

;    mov edi,__CR3_tarea1   ;Apuntar al inicio de la 1ra tabla.
;    mov ecx,0x400 *2                 ;Cantidad de entradas del directorio(1024) y una tabla(1024)
;    xor eax,eax                        ;Poner a cero esas entradas.
;    rep stosd
;
;    mov edi,__CR3_tarea2   ;Apuntar al inicio de la 1ra tabla.
;    mov ecx,0x400 *2                 ;Cantidad de entradas del directorio(1024) y una tabla(1024)
;    xor eax,eax                        ;Poner a cero esas entradas.
;    rep stosd
;
;    mov edi,__CR3_tarea3   ;Apuntar al inicio de la 1ra tabla.
;    mov ecx,0x400 *2                 ;Cantidad de entradas del directorio(1024) y una tabla(1024)
;    xor eax,eax                        ;Poner a cero esas entradas.
;    rep stosd


;-------------Paginacion Kernel----------------------------
;   Us,W,P   = 0x07     (Dato,   Usuario    CPL = 3)
;   Us,nW,P  = 0x05     (Codigo, Usuario    CPL = 3)
;   Sup,W,P  = 0x03     (Datos,  Supervisor CPL < 3)
;   Sup,nW,P = 0x01     (Codigo, Supervisor CPL < 3)
;Tablas de sistema         
    push 0x03                           ;Atributo tabla de pagina
    push 0x03                           ;Atributo descriptor de pagina
    push __SYS_TABLES_FIS               ;Direccion Fisica
    push __SYS_TABLES_LIN               ;Direccion Lineal
    push __CR3_kernel                   
    call carga_paginacion_ROM
    add esp,20

;Tablas de sistema TSS  
    push 0x03                               ;Atributo tabla de pagina
    push 0x03                               ;Atributo descriptor de pagina
    push __SYS_TABLES_TSS_FIS               ;Direccion Fisica
    push __SYS_TABLES_TSS_LIN               ;Direccion Lineal
    push __CR3_kernel                       ;Inicio de tabla  CR3_Kernel
    call carga_paginacion_ROM
    add esp,20

;Tablas de Paginación
    push 0x03                             
    push 0x03
    push __SYS_TABLES_PAG_FIS
    push __SYS_TABLES_PAG_LIN
    push __CR3_kernel         
    call carga_paginacion_ROM
    add esp,20
        
;Video                                          
    push 0x03
    push 0x03
    push __VIDEO_FIS
    push __VIDEO_LIN
    push __CR3_kernel               
    call carga_paginacion_ROM
    add esp,20
            
;ISRs                                           
    push 0x01
    push 0x01
    push __HANDLER_FIS
    push __HANDLER_LIN
    push __CR3_kernel         
    call carga_paginacion_ROM                       
    add esp,20
           
;Datos                                          
    push 0x03
    push 0x03
    push __DATOS_FIS
    push __DATOS_LIN
    push __CR3_kernel                           
    call carga_paginacion_ROM
    add esp,20
            
;Tabla de Dígitos                            
    push 0x03
    push 0x03
    push __TABLES_DIGITOS_FIS
    push __TABLES_DIGITOS_LIN
    push __CR3_kernel                    
    call carga_paginacion_ROM
    add esp,20
    
;Kernel
    push 0x01
    push 0x01
    push __KERNEL_FIS
    push __KERNEL_LIN
    push __CR3_kernel         
    call carga_paginacion_ROM                   
    add esp,20 

;Funciones                                      
    push 0x01
    push 0x01
    push __FUNCIONES_FIS
    push __FUNCIONES_LIN
    push __CR3_kernel         
    call carga_paginacion_ROM                   
    add esp,20

;Pila Kernel
    push 0x03
    push 0x03
    push __STACK_KERNEL_FIS
    push __STACK_KERNEL_LIN
    push __CR3_kernel           
    call carga_paginacion_ROM
    add esp,20

;ROM
    push __CR3_kernel         
    call carga_pag_ROM
    add esp,4

;------------------Tarea 1-----------------
;Tablas de sistema
    push 0x07                               ;Atributo tabla de pagina
    push 0x07                               ;Atributo descriptor de pagina
    push __SYS_TABLES_FIS                   ;Direccion Fisica
    push __SYS_TABLES_LIN                   ;Direccion Lineal
    push __CR3_tarea1                   
    call carga_paginacion_ROM
    add esp,20

;Tablas de sistema TSS
    push 0x03                               ;Atributo tabla de pagina
    push 0x03                               ;Atributo descriptor de pagina
    push __SYS_TABLES_TSS_FIS               ;Direccion Fisica
    push __SYS_TABLES_TSS_LIN               ;Direccion Lineal
    push __CR3_tarea1                       
    call carga_paginacion_ROM
    add esp,20

    push 0x07
    push 0x07
    push __SYS_TABLES_PAG_T1_FIS
    push __SYS_TABLES_PAG_T1_LIN
    push __CR3_tarea1         
    call carga_paginacion_ROM
    add esp,20

;Video                                          
    push 0x03
    push 0x03
    push __VIDEO_FIS
    push __VIDEO_LIN
    push __CR3_tarea1               
    call carga_paginacion_ROM
    add esp,20
            
;ISRs                                           
    push 0x01
    push 0x01
    push __HANDLER_FIS
    push __HANDLER_LIN
    push __CR3_tarea1         
    call carga_paginacion_ROM                       
    add esp,20
           
;Datos                                          
    push 0x03
    push 0x03
    push __DATOS_FIS
    push __DATOS_LIN
    push __CR3_tarea1                           
    call carga_paginacion_ROM
    add esp,20
            
;Tabla de Dígitos                               
    push 0x07
    push 0x07
    push __TABLES_DIGITOS_FIS
    push __TABLES_DIGITOS_LIN
    push __CR3_tarea1                    
    call carga_paginacion_ROM
    add esp,20

;Funciones                                      
    push 0x01
    push 0x01
    push __FUNCIONES_FIS
    push __FUNCIONES_LIN
    push __CR3_tarea1         
    call carga_paginacion_ROM                  
    add esp,20

;TEXT Tarea 1
    push 0x05
    push 0x05
    push __TEXT_TAREA1_FIS
    push __TEXT_TAREA1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20
       
;BSS Tarea 1
    push 0x07
    push 0x07
    push __BSS_TAREA1_FIS
    push __BSS_TAREA1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20
        
;Data Tarea 1
    push 0x07
    push 0x07
    push __DATA_TAREA1_FIS
    push __DATA_TAREA1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20
       
;RODATA Tarea 1
    push 0x05
    push 0x05
    push __RODATA_TAREA1_FIS
    push __RODATA_TAREA1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20

;Pila Tarea 1
    push 0x07
    push 0x07
    push __STACK_TAREA1_FIS
    push __STACK_TAREA1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20

;Pila Kernel
    push 0x03
    push 0x03
    push __STACK_KERNEL_T1_FIS
    push __STACK_KERNEL_T1_LIN
    push __CR3_tarea1           
    call carga_paginacion_ROM
    add esp,20

;------------------Tarea 2-----------------
;Tablas de sistema
    push 0x01                               ;Atributo tabla de pagina
    push 0x01                               ;Atributo descriptor de pagina
    push __SYS_TABLES_FIS                   ;Direccion Fisica
    push __SYS_TABLES_LIN                   ;Direccion Lineal
    push __CR3_tarea2                   
    call carga_paginacion_ROM
    add esp,20

;Tablas de sistema TSS
    push 0x03                               ;Atributo tabla de pagina
    push 0x03                               ;Atributo descriptor de pagina
    push __SYS_TABLES_TSS_FIS               ;Direccion Fisica
    push __SYS_TABLES_TSS_LIN               ;Direccion Lineal
    push __CR3_tarea2                       
    call carga_paginacion_ROM
    add esp,20

;Tablas de Paginación
    push 0x03
    push 0x03
    push __SYS_TABLES_PAG_T2_FIS
    push __SYS_TABLES_PAG_T2_LIN
    push __CR3_tarea2         
    call carga_paginacion_ROM
    add esp,20
        
;Video                                          
    push 0x03
    push 0x03
    push __VIDEO_FIS
    push __VIDEO_LIN
    push __CR3_tarea2               
    call carga_paginacion_ROM
    add esp,20
            
;ISRs                                           
    push 0x01
    push 0x01
    push __HANDLER_FIS
    push __HANDLER_LIN
    push __CR3_tarea2         
    call carga_paginacion_ROM                      
    add esp,20
           
;Datos                                          
    push 0x03
    push 0x03
    push __DATOS_FIS
    push __DATOS_LIN
    push __CR3_tarea2                           
    call carga_paginacion_ROM
    add esp,20
            
;Tabla de Dígitos                               
    push 0x07
    push 0x07
    push __TABLES_DIGITOS_FIS
    push __TABLES_DIGITOS_LIN
    push __CR3_tarea2                    
    call carga_paginacion_ROM
    add esp,20

;Funciones                                      
    push 0x01
    push 0x01
    push __FUNCIONES_FIS
    push __FUNCIONES_LIN
    push __CR3_tarea2         
    call carga_paginacion_ROM                  
    add esp,20

;TEXT Tarea 2
    push 0x05
    push 0x05
    push __TEXT_TAREA2_FIS
    push __TEXT_TAREA2_LIN
    push __CR3_tarea2           
    call carga_paginacion_ROM
    add esp,20
       
;BSS Tarea 2
    push 0x07
    push 0x07
    push __BSS_TAREA2_FIS
    push __BSS_TAREA2_LIN
    push __CR3_tarea2            
    call carga_paginacion_ROM
    add esp,20
        
;Data Tarea 2
    push 0x07
    push 0x07
    push __DATA_TAREA2_FIS
    push __DATA_TAREA2_LIN
    push __CR3_tarea2           
    call carga_paginacion_ROM
    add esp,20
       
;RODATA Tarea 2
    push 0x05
    push 0x05
    push __RODATA_TAREA2_FIS
    push __RODATA_TAREA2_LIN
    push __CR3_tarea2           
    call carga_paginacion_ROM
    add esp,20    

;Pila Tarea 2
    push 0x07
    push 0x07
    push __STACK_TAREA2_FIS
    push __STACK_TAREA2_LIN
    push __CR3_tarea2            
    call carga_paginacion_ROM
    add esp,20 

;Pila Kernel
    push 0x03
    push 0x03
    push __STACK_KERNEL_T2_FIS
    push __STACK_KERNEL_T2_LIN
    push __CR3_tarea2           
    call carga_paginacion_ROM
    add esp,20

;------------------Tarea 3-----------------
;Tablas de sistema
    push 0x01                               ;Atributo tabla de pagina
    push 0x01                               ;Atributo descriptor de pagina
    push __SYS_TABLES_FIS                   ;Direccion Fisica
    push __SYS_TABLES_LIN                   ;Direccion Lineal
    push __CR3_tarea3                   
    call carga_paginacion_ROM
    add esp,20

;Tablas de sistema TSS
    push 0x03                               ;Atributo tabla de pagina
    push 0x03                               ;Atributo descriptor de pagina
    push __SYS_TABLES_TSS_FIS               ;Direccion Fisica
    push __SYS_TABLES_TSS_LIN               ;Direccion Lineal
    push __CR3_tarea3                       
    call carga_paginacion_ROM
    add esp,20

;Tablas de Paginación
    push 0x03
    push 0x03
    push __SYS_TABLES_PAG_T3_FIS
    push __SYS_TABLES_PAG_T3_LIN
    push __CR3_tarea3         
    call carga_paginacion_ROM
    add esp,20
        
;Video                                          
    push 0x01
    push 0x01
    push __VIDEO_FIS
    push __VIDEO_LIN
    push __CR3_tarea3               
    call carga_paginacion_ROM
    add esp,20
            
;ISRs                                           
    push 0x01
    push 0x01
    push __HANDLER_FIS
    push __HANDLER_LIN
    push __CR3_tarea3         
    call carga_paginacion_ROM                       
    add esp,20
           
;Datos                                          
    push 0x03
    push 0x03
    push __DATOS_FIS
    push __DATOS_LIN
    push __CR3_tarea3                           
    call carga_paginacion_ROM
    add esp,20
            
;Tabla de Dígitos                               
    push 0x07
    push 0x07
    push __TABLES_DIGITOS_FIS
    push __TABLES_DIGITOS_LIN
    push __CR3_tarea3                    
    call carga_paginacion_ROM
    add esp,20

;Funciones                                      
    push 0x01
    push 0x01
    push __FUNCIONES_FIS
    push __FUNCIONES_LIN
    push __CR3_tarea3         
    call carga_paginacion_ROM                   
    add esp,20

;TEXT Tarea 3
    push 0x05
    push 0x05
    push __TEXT_TAREA3_FIS
    push __TEXT_TAREA3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20
       
;BSS Tarea 3
    push 0x07
    push 0x07
    push __BSS_TAREA3_FIS
    push __BSS_TAREA3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20
        
;Data Tarea 3
    push 0x07
    push 0x07
    push __DATA_TAREA3_FIS
    push __DATA_TAREA3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20
       
;RODATA Tarea 3
    push 0x05
    push 0x05
    push __RODATA_TAREA3_FIS
    push __RODATA_TAREA3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20

;Pila Tarea 3
    push 0x07
    push 0x07
    push __STACK_TAREA3_FIS
    push __STACK_TAREA3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20

;Pila Kernel
    push 0x03
    push 0x03
    push __STACK_KERNEL_T3_FIS
    push __STACK_KERNEL_T3_LIN
    push __CR3_tarea3           
    call carga_paginacion_ROM
    add esp,20

;---------------------------------------------;
;-----------Habilitar Paginacion--------------;
;---------------------------------------------;

    mov eax,__CR3_kernel 
    mov cr3,eax                 ;Apuntar a directorio de paginas.
 
    mov eax,cr0                 ;Activar paginacion encendiendo el
    or eax, 1 << 31             ;bit 31 CR0.
    mov cr0,eax 

    ret

init_TSS:

;------------Inicializo TSS de la tarea 1 ------------
    mov eax, __TSS_tarea1
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(__STACK_KERNEL_T1_END_LIN) 
    ;SS0
    mov [eax+0x08], dword(DS_SEL)                    
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(__STACK_TAREA1_LIN_END) 
    ;SS2
    mov [eax+0x18], dword(DS_SEL_11) 
    ;CR3
    mov [eax+0x1C], dword(__CR3_tarea1)
    ;EIP
    mov [eax+0x20], dword(tarea_1) 
    ;EFLAGS
    mov [eax+0x24], dword(0x202) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(__STACK_TAREA1_LIN_END) 
    ;EBP
    mov [eax+0x3C], dword(__STACK_TAREA1_LIN_END)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(DS_SEL_11) 
    ;CS
    mov [eax+0x4C], dword(CS_SEL) 
    ;SS
    mov [eax+0x50], dword(DS_SEL) 
    ;DS
    mov [eax+0x54], dword(DS_SEL_11) 
    ;FS
    mov [eax+0x58], dword(DS_SEL_11) 
    ;GS
    mov [eax+0x5C], dword(DS_SEL_11) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax+0x64], dword(0)

;------------Inicializo TSS de la tarea 2 ------------
    mov eax, __TSS_tarea2
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(__STACK_KERNEL_T2_END_LIN) 
    ;SS0
    mov [eax+0x08], dword(DS_SEL)                    
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(__STACK_TAREA2_LIN_END) 
    ;SS2
    mov [eax+0x18], dword(DS_SEL_11) 
    ;CR3
    mov [eax+0x1C], dword(__CR3_tarea2)
    ;EIP
    mov [eax+0x20], dword(tarea_2) 
    ;EFLAGS
    mov [eax+0x24], dword(0x202) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(__STACK_TAREA2_LIN_END) 
    ;EBP
    mov [eax+0x3C], dword(__STACK_TAREA2_LIN_END)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(DS_SEL_11) 
    ;CS
    mov [eax+0x4C], dword(CS_SEL) 
    ;SS
    mov [eax+0x50], dword(DS_SEL) 
    ;DS
    mov [eax+0x54], dword(DS_SEL_11) 
    ;FS
    mov [eax+0x58], dword(DS_SEL_11) 
    ;GS
    mov [eax+0x5C], dword(DS_SEL_11) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax+0x64], dword(0)


;------------Inicializo TSS de la tarea 3------------
    mov eax, __TSS_tarea3
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(__STACK_KERNEL_T3_END_LIN) 
    ;SS0
    mov [eax+0x08], dword(DS_SEL)                     
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(__STACK_TAREA3_LIN_END) 
    ;SS2
    mov [eax+0x18], dword(DS_SEL_11) 
    ;CR3
    mov [eax+0x1C], dword(__CR3_tarea3)
    ;EIP
    mov [eax+0x20], dword(tarea_3) 
    ;EFLAGS
    mov [eax+0x24], dword(0x202) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(__STACK_TAREA3_LIN_END) 
    ;EBP
    mov [eax+0x3C], dword(__STACK_TAREA3_LIN_END)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(DS_SEL_11) 
    ;CS
    mov [eax+0x4C], dword(CS_SEL) 
    ;SS
    mov [eax+0x50], dword(DS_SEL) 
    ;DS
    mov [eax+0x54], dword(DS_SEL_11) 
    ;FS
    mov [eax+0x58], dword(DS_SEL_11) 
    ;GS
    mov [eax+0x5C], dword(DS_SEL_11) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax+0x64], dword(0)


;------------Inicializo TSS de la tarea halted------------    
;Utilizo el main de kernel como tarea halted
    mov eax, __TSS_tarea0                
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(__STACK_KERNEL_LIN_END) 
    ;SS0
    mov [eax+0x08], dword(DS_SEL)                     
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(__STACK_tarea0_LIN_END) 
    ;SS2
    mov [eax+0x18], dword(DS_SEL_11) 
    ;CR3
    mov [eax+0x1C], dword(__CR3_tarea0)
    ;EIP
    mov [eax+0x20], dword(kernel_init) 
    ;EFLAGS
    mov [eax+0x24], dword(0x202) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(__STACK_tarea0_LIN_END) 
    ;EBP
    mov [eax+0x3C], dword(__STACK_tarea0_LIN_END)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(DS_SEL) 
    ;CS
    mov [eax+0x4C], dword(CS_SEL) 
    ;SS
    mov [eax+0x50], dword(DS_SEL) 
    ;DS
    mov [eax+0x54], dword(DS_SEL) 
    ;FS
    mov [eax+0x58], dword(DS_SEL) 
    ;GS
    mov [eax+0x5C], dword(DS_SEL) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax+0x64], dword(0)


;------------Inicializo TSS de kernel------------
    mov eax, __TSS_kernel
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(__STACK_KERNEL_LIN_END) 
    ;SS0
    mov [eax+0x08], dword(DS_SEL)                     
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(__STACK_tarea0_LIN_END) 
    ;SS2
    mov [eax+0x18], dword(DS_SEL) 
    ;CR3
    mov [eax+0x1C], dword(__CR3_kernel)
    ;EIP
    mov [eax+0x20], dword(kernel_init) 
    ;EFLAGS
    mov [eax+0x24], dword(0x202) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(0) 
    ;EBP
    mov [eax+0x3C], dword(0)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(DS_SEL) 
    ;CS
    mov [eax+0x4C], dword(CS_SEL) 
    ;SS
    mov [eax+0x50], dword(DS_SEL) 
    ;DS
    mov [eax+0x54], dword(DS_SEL) 
    ;FS
    mov [eax+0x58], dword(DS_SEL) 
    ;GS
    mov [eax+0x5C], dword(DS_SEL) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax+0x64], dword(0) 

    xchg bx,bx

    mov ax, TSS_SEL
    ltr ax

    STI                 ;Habilitar interrupciones

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