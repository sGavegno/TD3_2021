


;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN return_Scheduler

EXTERN tarea_actual 
EXTERN tarea_siguiente

EXTERN tarea0_first

EXTERN Nuevo_Stack

EXTERN contador_1
EXTERN contador_2
EXTERN contador_3

EXTERN __CR3_kernel
EXTERN __CR3_tarea1
EXTERN __CR3_tarea2
EXTERN __CR3_tarea3
EXTERN __CR3_tarea0

EXTERN TSS_kernel
EXTERN TSS_tarea1
EXTERN TSS_tarea2
EXTERN __MMX_tarea2
EXTERN TSS_tarea3
EXTERN __MMX_tarea3
EXTERN TSS_tarea0


EXTERN __TSS_tarea0
EXTERN __TSS_kernel
EXTERN __TSS_tarea1
EXTERN __TSS_tarea2
EXTERN __TSS_tarea3

EXTERN FLAG_TAREA_1
EXTERN FLAG_TAREA_2
EXTERN FLAG_TAREA_3
;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL Scheduler

;--------------------------------DEFINE------------------------------------------
%define TAREA_0     0
%define TAREA_1     1
%define TAREA_2     2
%define TAREA_3     3

%define Timer_T1     50
%define Timer_T2     10
%define Timer_T3     20

;-------------------------------------SECTION-----------------------------------------------------
USE32

SECTION .scheduler


Scheduler:

    PUSHAD

    inc byte [contador_1]       
    inc byte [contador_2]       
    inc byte [contador_3]

    cmp byte [contador_1], Timer_T1
    jae Time_500ms

    cmp byte [contador_2], Timer_T2
    jae Time_100ms

    cmp byte [contador_3], Timer_T3
    jae Time_200ms

    mov byte [tarea_siguiente], TAREA_0

    jmp analizar_tarea

Time_100ms:
    mov byte [contador_2],0x00
    mov byte [tarea_siguiente], TAREA_2
    jmp analizar_tarea

Time_200ms:
    mov byte [contador_3],0x00
    mov byte [tarea_siguiente], TAREA_3
    jmp analizar_tarea

Time_500ms:
    mov byte [contador_1],0x00
    mov byte [tarea_siguiente], TAREA_1
    jmp analizar_tarea

analizar_tarea:

    mov al, [tarea_actual]
    mov bl, [tarea_siguiente]
    cmp al, bl
    je fin_Scheduler

Scheduler_Contexto:

    jmp guardar_contexto
return_guardar_contexto:

    jmp cargar_contexto
return_cargar_contexto:

    PUSHAD

fin_Scheduler:
    POPAD

    jmp return_Scheduler


guardar_contexto:

    POPAD

    cmp byte [tarea_actual], TAREA_0        ;Kernel/halted
    je guardar_tarea0
return_guardar_tarea0:

    cmp byte [tarea_actual], TAREA_1
    je guardar_tarea1
return_guardar_tarea1:

    cmp byte [tarea_actual], TAREA_2
    je guardar_tarea2
return_guardar_tarea2:

    cmp byte [tarea_actual], TAREA_3
    je guardar_tarea3
return_guardar_tarea3:

    jmp return_guardar_contexto

guardar_tarea0:

    ;Registros Generales
    mov [__TSS_tarea0 + 0x28], eax      ;Guardo EAX
    mov [__TSS_tarea0 + 0x2C], ecx      ;Guardo ECX
    mov [__TSS_tarea0 + 0x30], edx      ;Guardo EDX
    mov [__TSS_tarea0 + 0x34], ebx      ;Guardo EBX
    ;mov [__TSS_tarea0 + 0x38], esp      ;Guardo ESP
    mov [__TSS_tarea0 + 0x3C], ebp      ;Guardo EBP 
    mov [__TSS_tarea0 + 0x40], esi      ;Guardo ESI
    mov [__TSS_tarea0 + 0x44], edi      ;Guardo EDI

    ;Registros de Segmento
    mov [__TSS_tarea0 + 0x48], es       ;Guardo ES
    ;mov [__TSS_tarea0 + 0x4C], cs       ;Guardo CS        
    ;mov [__TSS_tarea0 + 0x50], ss      ;Guardo SS
    mov [__TSS_tarea0 + 0x54], ds       ;Guardo DS   
    mov [__TSS_tarea0 + 0x58], fs       ;Guardo FS       
    mov [__TSS_tarea0 + 0x5C], gs       ;Guardo GS   

    mov eax, cr3                        ;Guardo CR3
    mov [__TSS_tarea0 + 0x1C], eax
;xchg bx,bx
;mov eax, 0
    ;Registros del Stack
    pop eax                             ;al hacer el pop vacio la pila para que no cresca por siempre
;    mov eax, [esp]                     ;Guardo EIP
    mov [__TSS_tarea0 + 0x20], eax  
    pop eax
;    mov eax, [esp + 4]                 ;Guardo CS
    mov [__TSS_tarea0 + 0x4C], eax  
    pop eax
;    mov eax, [esp + 8]                 ;Guardo EFLAGS
    mov [__TSS_tarea0 + 0x24], eax  

    mov eax, [tarea0_first]
    cmp eax, 1
    jne first

    pop eax                       
    mov [__TSS_tarea2 + 0x14], eax
    pop eax                       
    mov [__TSS_tarea2 + 0x18], eax
    jmp no_first

first:
    mov eax, 1
    mov [tarea0_first], eax

no_first:
    mov [__TSS_tarea0 + 0x04], esp      ;Guardo ESP0
    mov [__TSS_tarea0 + 0x08], ss       ;Guardo SS0

    jmp return_guardar_tarea0

guardar_tarea1:

    ;Registros Generales
    mov [__TSS_tarea1 + 0x28], eax      ;Guardo EAX
    mov [__TSS_tarea1 + 0x2C], ecx      ;Guardo ECX
    mov [__TSS_tarea1 + 0x30], edx      ;Guardo EDX
    mov [__TSS_tarea1 + 0x34], ebx      ;Guardo EBX
    ;mov [__TSS_tarea1 + 0x38], esp      ;Guardo ESP
    mov [__TSS_tarea1 + 0x3C], ebp      ;Guardo EBP 
    mov [__TSS_tarea1 + 0x40], esi      ;Guardo ESI
    mov [__TSS_tarea1 + 0x44], edi      ;Guardo EDI

    ;Registros de Segmento
    mov [__TSS_tarea1 + 0x48], es       ;Guardo ES
    ;mov [__TSS_tarea1 + 0x4C], cs        ;Guardo CS        
    ;mov [__TSS_tarea1 + 0x50], ss      ;Guardo SS
    mov [__TSS_tarea1 + 0x54], ds       ;Guardo DS   
    mov [__TSS_tarea1 + 0x58], fs       ;Guardo FS       
    mov [__TSS_tarea1 + 0x5C], gs       ;Guardo GS   

    mov eax, cr3                        ;Guardo CR3
    mov [__TSS_tarea1 + 0x1C], eax
;xchg bx,bx
;mov eax, 1
    ;Registros del Stack
    add esp, 12                         ;sumo 12 porque tengo guardados el EIP, CS y EFLAGS del SYSCALL
    pop eax                             ;al hacer el pop vacio la pila para que no cresca por siempre
;    mov eax, [esp + 12]                ;Guardo EIP
    mov [__TSS_tarea1 + 0x20], eax  
    pop eax
;    mov eax, [esp + 16]                ;Guardo CS
    mov [__TSS_tarea1 + 0x4C], eax  
    pop eax
;    mov eax, [esp + 20]                ;Guardo EFLAGS
    mov [__TSS_tarea1 + 0x24], eax  
    pop eax                             ;Guardo ESP2      
    mov [__TSS_tarea1 + 0x14], eax
    pop eax                             ;Guardo SS2      
    mov [__TSS_tarea1 + 0x18], eax

    mov [__TSS_tarea1 + 0x04], esp      ;Guardo ESP0
    mov [__TSS_tarea1 + 0x08], ss       ;Guardo SS0

    jmp return_guardar_tarea1

guardar_tarea2:

    ;Registros Generales
    mov [__TSS_tarea2 + 0x28], eax      ;Guardo EAX
    mov [__TSS_tarea2 + 0x2C], ecx      ;Guardo ECX
    mov [__TSS_tarea2 + 0x30], edx      ;Guardo EDX
    mov [__TSS_tarea2 + 0x34], ebx      ;Guardo EBX
    ;mov [__TSS_tarea2 + 0x38], esp      ;Guardo ESP
    mov [__TSS_tarea2 + 0x3C], ebp      ;Guardo EBP 
    mov [__TSS_tarea2 + 0x40], esi      ;Guardo ESI
    mov [__TSS_tarea2 + 0x44], edi      ;Guardo EDI

    ;Registros de Segmento
    mov [__TSS_tarea2 + 0x48], es       ;Guardo ES
    ;mov [__TSS_tarea2 + 0x4C], cs      ;Guardo CS        
    ;mov [__TSS_tarea2 + 0x50], ss      ;Guardo SS
    mov [__TSS_tarea2 + 0x54], ds       ;Guardo DS   
    mov [__TSS_tarea2 + 0x58], fs       ;Guardo FS       
    mov [__TSS_tarea2 + 0x5C], gs       ;Guardo GS   

    mov eax, cr3                        ;Guardo CR3
    mov [__TSS_tarea2 + 0x1C], eax
;xchg bx,bx
;mov eax, 2
    ;Registros del Stack
    add esp, 12                         ;sumo 12 porque tengo guardados el EIP, CS y EFLAGS del SYSCALL
    pop eax                             ;al hacer el pop vacio la pila para que no cresca por siempre
;    mov eax, [esp + 12]                ;Guardo EIP
    mov [__TSS_tarea2 + 0x20], eax  
    pop eax                             ;Guardo CS
;    mov eax, [esp + 16]
    mov [__TSS_tarea2 + 0x4C], eax  
    pop eax                             ;Guardo EFLAGS
;    mov eax, [esp + 20]            
    mov [__TSS_tarea2 + 0x24], eax 
    pop eax                             ;Guardo ESP2      
    mov [__TSS_tarea2 + 0x14], eax
    pop eax                             ;Guardo SS2      
    mov [__TSS_tarea2 + 0x18], eax

    mov [__TSS_tarea2 + 0x04], esp      ;Guardo ESP0
    mov [__TSS_tarea2 + 0x08], ss       ;Guardo SS0

    FXSAVE &__MMX_tarea2

    jmp return_guardar_tarea2

guardar_tarea3:

    ;Registros Generales
    mov [__TSS_tarea3 + 0x28], eax      ;Guardo EAX
    mov [__TSS_tarea3 + 0x2C], ecx      ;Guardo ECX
    mov [__TSS_tarea3 + 0x30], edx      ;Guardo EDX
    mov [__TSS_tarea3 + 0x34], ebx      ;Guardo EBX
    ;mov [__TSS_tarea3 + 0x38], esp      ;Guardo ESP
    mov [__TSS_tarea3 + 0x3C], ebp      ;Guardo EBP 
    mov [__TSS_tarea3 + 0x40], esi      ;Guardo ESI
    mov [__TSS_tarea3 + 0x44], edi      ;Guardo EDI

    ;Registros de Segmento
    mov [__TSS_tarea3 + 0x48], es       ;Guardo ES
    ;mov [TSS_tarea3 + 0x4C], cs        ;Guardo CS        
    ;mov [__TSS_tarea3 + 0x50], ss      ;Guardo SS
    mov [__TSS_tarea3 + 0x54], ds       ;Guardo DS   
    mov [__TSS_tarea3 + 0x58], fs       ;Guardo FS       
    mov [__TSS_tarea3 + 0x5C], gs       ;Guardo GS   

    mov eax, cr3                        ;Guardo CR3
    mov [__TSS_tarea3 + 0x1C], eax
;xchg bx,bx
;mov eax, 3
    ;Registros del Stack                ;sumo 12 porque tengo guardados el EIP, CS y EFLAGS del SYSCALL
    add esp, 12                         ;al hacer el pop vacio la pila para que no cresca por siempre 
    pop eax                             ;Guardo EIP               
    mov [__TSS_tarea3 + 0x20], eax  
    pop eax                             ;Guardo CS        
    mov [__TSS_tarea3 + 0x4C], eax  
    pop eax                             ;Guardo EFLAGS       
    mov [__TSS_tarea3 + 0x24], eax 
    pop eax                             ;Guardo ESP2      
    mov [__TSS_tarea3 + 0x14], eax
    pop eax                             ;Guardo SS2      
    mov [__TSS_tarea3 + 0x18], eax

    mov [__TSS_tarea3 + 0x04], esp      ;Guardo ESP0
    mov [__TSS_tarea3 + 0x08], ss       ;Guardo SS0

    FXSAVE &__MMX_tarea3

    jmp return_guardar_tarea3

cargar_contexto:

    cmp byte [tarea_siguiente], TAREA_0
    je cargar_tarea0
return_cargar_tarea0: 

    cmp byte [tarea_siguiente], TAREA_1  
    je cargar_tarea1
return_cargar_tarea1:    

    cmp byte [tarea_siguiente], TAREA_2
    je cargar_tarea2
return_cargar_tarea2:

    cmp byte [tarea_siguiente], TAREA_3
    je cargar_tarea3
return_cargar_tarea3:

    jmp return_cargar_contexto

cargar_tarea0:
;xchg bx,bx
    mov byte [tarea_actual], TAREA_0
;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea0
    mov cr3,eax                          ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov eax, [__TSS_tarea0 + 0x48]       ;Recupero es
    mov es, eax 
    mov eax, [__TSS_tarea0 + 0x54]       ;Recupero ds
    mov ds, eax
    mov eax, [__TSS_tarea0 + 0x58]       ;Recupero fs
    mov fs, eax
    mov eax, [__TSS_tarea0 + 0x5C]       ;Recupero gs
    mov gs, eax
    
    ;mov esp, [__TSS_tarea0 + 0x38]
    mov ebp, [__TSS_tarea0 + 0x3C]   

    ;seteo el Stack
    mov eax, [__TSS_tarea0 + 0x04]      ;Recupero ESP0
    mov [Nuevo_Stack], eax
    mov eax, [__TSS_tarea0 + 0x08]      ;Recupero SS0
    mov [Nuevo_Stack + 4], eax

    ;LSS --> load stack segment
    lss esp, [Nuevo_Stack]

    ;cargo el stack 
    mov eax, [__TSS_tarea0 + 0x18]      ;Recupero SS2
    add eax, 3                          ;cargo el RPL al selector
    push eax
    mov eax, [__TSS_tarea0 + 0x14]      ;Recupero ESP2
    push eax
    mov eax, [__TSS_tarea0 + 0x24]      ;Recupero EFLAGS
    push eax
    mov eax, [__TSS_tarea0 + 0x4C]      ;Recupero CS
    push eax
    mov eax, [__TSS_tarea0 + 0x20]      ;Recupero EIP
    push eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea0 + 0x28]    
    mov ecx, [__TSS_tarea0 + 0x2C]
    mov edx, [__TSS_tarea0 + 0x30]
    mov ebx, [__TSS_tarea0 + 0x34]       
    mov esi, [__TSS_tarea0 + 0x40]
    mov edi, [__TSS_tarea0 + 0x44]

    ;Cargo la TSS
    push __TSS_tarea0
    call cargar_TSS
    add esp,4

    jmp return_cargar_tarea0

cargar_tarea1:
;xchg bx,bx
;mov eax, 1

    mov byte [tarea_actual], TAREA_1
;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea1
    mov cr3,eax                         ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov eax, [__TSS_tarea1 + 0x48]      ;Recupero es
    mov es, eax 
    mov eax, [__TSS_tarea1 + 0x54]      ;Recupero ds
    mov ds, eax
    mov eax, [__TSS_tarea1 + 0x58]      ;Recupero fs
    mov fs, eax
    mov eax, [__TSS_tarea1 + 0x5C]      ;Recupero gs
    mov gs, eax
    
    ;mov esp, [__TSS_tarea1 + 0x38]
    mov ebp, [__TSS_tarea1 + 0x3C]   

    ;seteo el Stack
    mov eax, [__TSS_tarea1 + 0x04]      ;Recupero ESP0
    mov [Nuevo_Stack], eax
    mov eax, [__TSS_tarea1 + 0x08]      ;Recupero SS0
    mov [Nuevo_Stack + 4], eax

    ;LSS --> load stack segment
    lss esp, [Nuevo_Stack]

    ;cargo el stack 
    mov eax, [__TSS_tarea1 + 0x18]      ;Recupero SS2
;    add eax, 3                          ;cargo el RPL al selector
    push eax
    mov eax, [__TSS_tarea1 + 0x14]      ;Recupero ESP2
    push eax
    mov eax, [__TSS_tarea1 + 0x24]      ;Recupero EFLAGS
    push eax
    mov eax, [__TSS_tarea1 + 0x4C]      ;Recupero CS
    push eax
    mov eax, [__TSS_tarea1 + 0x20]      ;Recupero EIP
    push eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea1 + 0x28]    
    mov ecx, [__TSS_tarea1 + 0x2C]
    mov edx, [__TSS_tarea1 + 0x30]
    mov ebx, [__TSS_tarea1 + 0x34]       
    mov esi, [__TSS_tarea1 + 0x40]
    mov edi, [__TSS_tarea1 + 0x44]

    ;Cargo la TSS
    push __TSS_tarea1
    call cargar_TSS
    add esp,4

    jmp return_cargar_tarea1

cargar_tarea2:
;xchg bx,bx
;mov eax, 2
    mov byte [tarea_actual], TAREA_2
;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea2
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov eax, [__TSS_tarea2 + 0x48]      ;Recupero es
    mov es, eax 
    mov eax, [__TSS_tarea2 + 0x54]      ;Recupero ds
    mov ds, eax
    mov eax, [__TSS_tarea2 + 0x58]      ;Recupero fs
    mov fs, eax
    mov eax, [__TSS_tarea2 + 0x5C]      ;Recupero gs
    mov gs, eax
    
    ;mov esp, [__TSS_tarea2 + 0x38]
    mov ebp, [__TSS_tarea2 + 0x3C]   

    ;seteo el Stack
    mov eax, [__TSS_tarea2 + 0x04]      ;Recupero ESP0
    mov [Nuevo_Stack], eax
    mov eax, [__TSS_tarea2 + 0x08]      ;Recupero SS0
    mov [Nuevo_Stack + 4], eax

    ;LSS --> load stack segment
    lss esp, [Nuevo_Stack]

    ;setear el flag CR0.TS = 1
    smsw ax
    or ax, 0x0008
    lmsw ax

    ;cargo el stack 
    mov eax, [__TSS_tarea2 + 0x18]      ;Recupero SS2
;    add eax, 3                          ;cargo el RPL al selector
    push eax
    mov eax, [__TSS_tarea2 + 0x14]      ;Recupero ESP2
    push eax
    mov eax, [__TSS_tarea2 + 0x24]      ;Recupero EFLAGS
    push eax
    mov eax, [__TSS_tarea2 + 0x4C]      ;Recupero CS
    push eax
    mov eax, [__TSS_tarea2 + 0x20]      ;Recupero EIP
    push eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea2 + 0x28]    
    mov ecx, [__TSS_tarea2 + 0x2C]
    mov edx, [__TSS_tarea2 + 0x30]
    mov ebx, [__TSS_tarea2 + 0x34]       
    mov esi, [__TSS_tarea2 + 0x40]
    mov edi, [__TSS_tarea2 + 0x44]

    ;Cargo la TSS
    push __TSS_tarea2
    call cargar_TSS
    add esp,4
    
    jmp return_cargar_tarea2
    
cargar_tarea3:
;xchg bx,bx
;mov eax, 3
    mov byte [tarea_actual], TAREA_3
;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea3
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov eax, [__TSS_tarea3 + 0x48]       ;Recupero es
    mov es, eax 
    mov eax, [__TSS_tarea3 + 0x54]       ;Recupero ds
    mov ds, eax
    mov eax, [__TSS_tarea3 + 0x58]       ;Recupero fs
    mov fs, eax
    mov eax, [__TSS_tarea3 + 0x5C]       ;Recupero gs
    mov gs, eax
    
    ;mov esp, [__TSS_tarea3 + 0x38]
    mov ebp, [__TSS_tarea3 + 0x3C]   

    ;seteo el Stack
    mov eax, [__TSS_tarea3 + 0x04]      ;Recupero ESP0
    mov [Nuevo_Stack], eax
    mov eax, [__TSS_tarea3 + 0x08]      ;Recupero SS0
    mov [Nuevo_Stack + 4], eax

    ;LSS --> load stack segment
    lss esp, [Nuevo_Stack]

    ;setear el flag CR0.TS = 1
    smsw ax
    or ax, 0x0008
    lmsw ax

    ;cargo el stack 
    mov eax, [__TSS_tarea3 + 0x18]      ;Recupero SS2
;    add eax, 3                          ;cargo el RPL al selector
    push eax
    mov eax, [__TSS_tarea3 + 0x14]      ;Recupero ESP2
    push eax
    mov eax, [__TSS_tarea3 + 0x24]      ;Recupero EFLAGS
    push eax
    mov eax, [__TSS_tarea3 + 0x4C]      ;Recupero CS
    push eax
    mov eax, [__TSS_tarea3 + 0x20]      ;Recupero EIP
    push eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea3 + 0x28]    
    mov ecx, [__TSS_tarea3 + 0x2C]
    mov edx, [__TSS_tarea3 + 0x30]
    mov ebx, [__TSS_tarea3 + 0x34]       
    mov esi, [__TSS_tarea3 + 0x40]
    mov edi, [__TSS_tarea3 + 0x44]

    ;Cargo la TSS
    push __TSS_tarea3
    call cargar_TSS
    add esp,4

    jmp return_cargar_tarea3    

cargar_TSS:

    mov ebx, [esp + 4]

    ;backlink
    mov eax, [ebx]
    mov [__TSS_kernel], eax 
    ;ESP0
    mov eax, [ebx+0x04]
    mov [__TSS_kernel+0x04], eax
    ;SS0
    mov eax, [ebx+0x08]
    mov [__TSS_kernel+0x08], eax
    ;ESP1
    mov eax, [ebx+0x0C]
    mov [__TSS_kernel+0x0C], eax 
    ;SS1
    mov eax, [ebx+0x10]
    mov [__TSS_kernel+0x10], eax
    ;ESP2
    mov eax, [ebx+0x14]
    mov [__TSS_kernel+0x14], eax 
    ;SS2
    mov eax, [ebx+0x18]
    mov [__TSS_kernel+0x18], eax 
    ;CR3
    mov eax, [ebx+0x1C]
    mov [__TSS_kernel+0x1C], eax
    ;EIP
    mov eax, [ebx+0x20]
    mov [__TSS_kernel+0x20], eax 
    ;EFLAGS
    mov eax, [ebx+0x24]
    mov [__TSS_kernel+0x24], eax 
    ;EAX
    mov eax, [ebx+0x28]
    mov [__TSS_kernel+0x28], eax 
    ;ECX
    mov eax, [ebx+0x2C]
    mov [__TSS_kernel+0x2C], eax 
    ;EDX
    mov eax, [ebx+0x30]
    mov [__TSS_kernel+0x30], eax 
    ;EBX
    mov eax, [ebx+0x34]
    mov [__TSS_kernel+0x34], eax 
    ;ESP
    mov eax, [ebx+0x38]
    mov [__TSS_kernel+0x38], eax
    ;EBP
    mov eax, [ebx+0x3C]
    mov [__TSS_kernel+0x3C], eax
    ;ESI
    mov eax, [ebx+0x40]
    mov [__TSS_kernel+0x40], eax
    ;EDI
    mov eax, [ebx+0x44]
    mov [__TSS_kernel+0x44], eax
    ;ES
    mov eax, [ebx+0x48]
    mov [__TSS_kernel+0x48], eax
    ;CS
    mov eax, [ebx+0x4C]
    mov [__TSS_kernel+0x4C], eax
    ;SS
    mov eax, [ebx+0x50]
    mov [__TSS_kernel+0x50], eax
    ;DS
    mov eax, [ebx+0x54]
    mov [__TSS_kernel+0x54], eax
    ;FS
    mov eax, [ebx+0x58]
    mov [__TSS_kernel+0x58], eax
    ;GS
    mov eax, [ebx+0x5C]
    mov [__TSS_kernel+0x5C], eax
    ;LDTR
    mov eax, [ebx+0x60]
    mov [__TSS_kernel+0x60], eax
    ;Bitmap E/S
    mov eax, [ebx+0x64]
    mov [__TSS_kernel+0x64], eax

    ret