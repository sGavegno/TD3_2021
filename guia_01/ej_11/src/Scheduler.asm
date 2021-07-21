


;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN return_Scheduler

EXTERN tarea_actual 
EXTERN tarea_siguiente

EXTERN contador_1
EXTERN contador_2
EXTERN contador_3

EXTERN __CR3_kernel
EXTERN __CR3_tarea1
EXTERN __CR3_tarea2
EXTERN __CR3_tarea3
EXTERN __CR3_tarea4

EXTERN TSS_kernel
EXTERN TSS_tarea1
EXTERN TSS_tarea2
EXTERN TSS_tarea3
EXTERN TSS_tarea4

EXTERN __TSS_kernel
EXTERN __TSS_tarea1
EXTERN __TSS_tarea2
EXTERN __TSS_tarea3
EXTERN __TSS_tarea4

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
%define TAREA_4     4

%define Timer_T1     50
%define Timer_T2     10
%define Timer_T3     20

;-------------------------------------SECTION-----------------------------------------------------
USE32

SECTION .scheduler


Scheduler:
xchg bx,bx	
    inc byte [contador_1]       
    inc byte [contador_2]       
    inc byte [contador_3]

    cmp byte [contador_1], Timer_T1
    je Time_500ms

    cmp byte [contador_2], Timer_T2
    je Time_100ms

    cmp byte [contador_3], Timer_T3
    je Time_200ms

    jmp Scheduler_fin

Time_100ms:
    mov byte [contador_2],0x00
    mov byte [tarea_siguiente], TAREA_2

    mov byte [FLAG_TAREA_2], 0x01

    jmp Scheduler_fin

Time_200ms:
    mov byte [contador_3],0x00
    mov byte [tarea_siguiente], TAREA_3
    mov byte [FLAG_TAREA_3], 0x01

    jmp Scheduler_fin

Time_500ms:
    mov byte [contador_1],0x00
    mov byte [tarea_siguiente], TAREA_1
    mov byte [FLAG_TAREA_1], 0x01

    jmp Scheduler_fin

Scheduler_fin:

    jmp guardar_contexto
return_guardar_contexto:

    jmp cargar_contexto
return_cargar_contexto:

    jmp return_Scheduler


guardar_contexto:

    cmp byte [tarea_actual], TAREA_0
    je fin_guardar_contexto

    cmp byte [tarea_actual], TAREA_1
    jmp guardar_tarea1
return_guardar_tarea1:
    jmp fin_guardar_contexto

    cmp byte [tarea_actual], TAREA_2
    jmp guardar_tarea2
return_guardar_tarea2:
    jmp fin_guardar_contexto

    cmp byte [tarea_actual], TAREA_3
    jmp guardar_tarea3
return_guardar_tarea3:
    jmp fin_guardar_contexto

    cmp byte [tarea_actual], TAREA_4
    jmp guardar_tarea4
return_guardar_tarea4:
    jmp fin_guardar_contexto

fin_guardar_contexto:

    jmp return_guardar_contexto

guardar_tarea1:

    ;Registros Generales
    mov [__TSS_tarea1 + 0x28], eax ;EAX
    mov [__TSS_tarea1 + 0x2C], ecx ;ECX
    mov [__TSS_tarea1 + 0x30], edx ;EDX
    mov [__TSS_tarea1 + 0x34], ebx ;EBX
    mov [__TSS_tarea1 + 0x38], esp ;ESP
    mov [__TSS_tarea1 + 0x3C], ebp ;EBP 
    mov [__TSS_tarea1 + 0x40], esi ;ESI
    mov [__TSS_tarea1 + 0x44], edi ;EDI

    ;Registros del Stack
    mov eax, [esp + 0x04]   ;EIP
    mov [__TSS_tarea1 + 0x20], eax  ;EIP del stack
    mov eax, [esp + 0x08]   ;CS
    mov [__TSS_tarea1 + 0x4C], eax ; CS del stack
    mov eax, [esp + 0x0C]  ;EFLAGS
    mov [__TSS_tarea1 + 0x24], eax  ;EFLAGS del stack

    ;Registros de Segmento
    mov [__TSS_tarea1 + 0x48], es ;reserved / ES
    ;mov [__TSS_tarea1 + 0x4C], cs ;reserved / CS        
    mov [__TSS_tarea1 + 0x50], ss ;reserved / SS
    mov [__TSS_tarea1 + 0x54], ds ;reserved / DS   
    mov [__TSS_tarea1 + 0x58], fs ;reserved / FS       
    mov [__TSS_tarea1 + 0x5C], gs ;reserved / GS   

    jmp return_guardar_tarea1

guardar_tarea2:

    ;Registros Generales
    mov [__TSS_tarea2 + 0x28], eax ;EAX
    mov [__TSS_tarea2 + 0x2C], ecx ;ECX
    mov [__TSS_tarea2 + 0x30], edx ;EDX
    mov [__TSS_tarea2 + 0x34], ebx ;EBX
    mov [__TSS_tarea2 + 0x38], esp ;ESP
    mov [__TSS_tarea2 + 0x3C], ebp ;EBP 
    mov [__TSS_tarea2 + 0x40], esi ;ESI
    mov [__TSS_tarea2 + 0x44], edi ;EDI

    ;Registros del Stack
    mov eax, [esp + 0x04]   ;EIP
    mov [__TSS_tarea2 + 0x20], eax  ;EIP del stack
    mov eax, [esp + 0x08]   ;CS
    mov [__TSS_tarea2 + 0x4C], eax ;reserved / CS del stack
    mov eax, [esp + 0x0C]  ;EFLAGS
    mov [__TSS_tarea2 + 0x24], eax  ;EFLAGS del stack

    ;Registros de Segmento
    mov [__TSS_tarea2 + 0x48], es ;reserved / ES
    ;mov [__TSS_tarea2 + 0x4C], cs ;reserved / CS        
    mov [__TSS_tarea2 + 0x50], ss ;reserved / SS
    mov [__TSS_tarea2 + 0x54], ds ;reserved / DS   
    mov [__TSS_tarea2 + 0x58], fs ;reserved / FS       
    mov [__TSS_tarea2 + 0x5C], gs ;reserved / GS   

        jmp return_guardar_tarea2

guardar_tarea3:

    ;Registros Generales
    mov [__TSS_tarea3 + 0x28], eax ;EAX
    mov [__TSS_tarea3 + 0x2C], ecx ;ECX
    mov [__TSS_tarea3 + 0x30], edx ;EDX
    mov [__TSS_tarea3 + 0x34], ebx ;EBX
    mov [__TSS_tarea3 + 0x38], esp ;ESP
    mov [__TSS_tarea3 + 0x3C], ebp ;EBP 
    mov [__TSS_tarea3 + 0x40], esi ;ESI
    mov [__TSS_tarea3 + 0x44], edi ;EDI

    ;Registros del Stack
    mov eax, [esp + 0x04]   ;EIP
    mov [__TSS_tarea3 + 0x20], eax  ;EIP del stack
    mov eax, [esp + 0x08]   ;CS
    mov [__TSS_tarea3 + 0x4C], eax ;reserved / CS del stack
    mov eax, [esp + 0x0C]  ;EFLAGS
    mov [__TSS_tarea3 + 0x24], eax  ;EFLAGS del stack

    ;Registros de Segmento
    mov [__TSS_tarea3 + 0x48], es ;reserved / ES
    ;mov [TSS_tarea3 + 0x4C], cs ;reserved / CS        
    mov [__TSS_tarea3 + 0x50], ss ;reserved / SS
    mov [__TSS_tarea3 + 0x54], ds ;reserved / DS   
    mov [__TSS_tarea3 + 0x58], fs ;reserved / FS       
    mov [__TSS_tarea3 + 0x5C], gs ;reserved / GS   

        jmp return_guardar_tarea3

guardar_tarea4:

    ;Registros Generales
    mov [__TSS_tarea4 + 0x28], eax ;EAX
    mov [__TSS_tarea4 + 0x2C], ecx ;ECX
    mov [__TSS_tarea4 + 0x30], edx ;EDX
    mov [__TSS_tarea4 + 0x34], ebx ;EBX
    mov [__TSS_tarea4 + 0x38], esp ;ESP
    mov [__TSS_tarea4 + 0x3C], ebp ;EBP 
    mov [__TSS_tarea4 + 0x40], esi ;ESI
    mov [__TSS_tarea4 + 0x44], edi ;EDI

    ;Registros del Stack
    mov eax, [esp + 0x04]   ;EIP
    mov [__TSS_tarea4 + 0x20], eax  ;EIP del stack
    mov eax, [esp + 0x08]   ;CS
    mov [__TSS_tarea4 + 0x4C], eax ;reserved / CS del stack
    mov eax, [esp + 0x0C]  ;EFLAGS
    mov [__TSS_tarea4 + 0x24], eax  ;EFLAGS del stack

    ;Registros de Segmento
    mov [__TSS_tarea4 + 0x48], es ;reserved / ES
    ;mov [__TSS_tarea4 + 0x4C], cs ;reserved / CS        
    mov [__TSS_tarea4 + 0x50], ss ;reserved / SS
    mov [__TSS_tarea4 + 0x54], ds ;reserved / DS   
    mov [__TSS_tarea4 + 0x58], fs ;reserved / FS       
    mov [__TSS_tarea4 + 0x5C], gs ;reserved / GS   

        jmp return_guardar_tarea4


cargar_contexto:

    cmp byte [tarea_siguiente], TAREA_0
    mov byte [tarea_actual], TAREA_0
    je fin_cargar_contexto

    cmp byte [tarea_siguiente], TAREA_1
    mov byte [tarea_actual], TAREA_1
    jne fin_cargar_contexto    
    jmp cargar_tarea1
return_cargar_tarea1:    
    jmp fin_cargar_contexto

    cmp byte [tarea_siguiente], TAREA_2
    mov byte [tarea_actual], TAREA_2
    jne fin_cargar_contexto
    jmp cargar_tarea2
return_cargar_tarea2:
    jmp fin_cargar_contexto

    cmp byte [tarea_siguiente], TAREA_3
    mov byte [tarea_actual], TAREA_3
    jne fin_cargar_contexto
    jmp cargar_tarea3
return_cargar_tarea3:
    jmp fin_cargar_contexto

    cmp byte [tarea_siguiente], TAREA_4
    mov byte [tarea_actual], TAREA_4
    jne fin_cargar_contexto
    jmp cargar_tarea4
return_cargar_tarea4:
    jmp fin_cargar_contexto

fin_cargar_contexto:

    jmp return_cargar_contexto

cargar_tarea1:

;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea1
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov es,[__TSS_tarea1 + 0x48] 
    mov cs,[__TSS_tarea1 + 0x4C]
    mov ss,[__TSS_tarea1 + 0x50] 
    mov ds,[__TSS_tarea1 + 0x54] 
    mov fs,[__TSS_tarea1 + 0x58] 
    mov gs,[__TSS_tarea1 + 0x5C] 

    mov esp, [__TSS_tarea1 + 0x38]
    mov ebp, [__TSS_tarea1 + 0x3C]   

    ;Registros del Stack
    ;hago el push para poder cargar los registros en el stack
    push eax 
    push eax
    push eax

    mov eax, [__TSS_tarea1 + 0x20] ;EIP
    mov [esp], eax
    mov eax, [__TSS_tarea1 + 0x4C] ;CS
    mov [esp + 0x04], eax
    mov eax, [__TSS_tarea1 + 0x24] ;EFLAGS
    or eax, 0x0202                   ;Enable int
    mov [esp + 0x08], eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea1 + 0x28]    
    mov ecx, [__TSS_tarea1 + 0x2C]
    mov edx, [__TSS_tarea1 + 0x30]
    mov ebx, [__TSS_tarea1 + 0x34]
    ;mov esp, [__TSS_tarea1 + 0x38]
    ;mov ebp, [__TSS_tarea1 + 0x3C]        
    mov esi, [__TSS_tarea1 + 0x40]
    mov edi, [__TSS_tarea1 + 0x44]

    jmp return_cargar_tarea1

cargar_tarea2:

;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea2
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov es,[__TSS_tarea2 + 0x48] 
    mov cs,[__TSS_tarea2 + 0x4C]
    mov ss,[__TSS_tarea2 + 0x50] 
    mov ds,[__TSS_tarea2 + 0x54] 
    mov fs,[__TSS_tarea2 + 0x58] 
    mov gs,[__TSS_tarea2 + 0x5C] 

    mov esp, [__TSS_tarea2 + 0x38]
    mov ebp, [__TSS_tarea2 + 0x3C]   

    ;Registros del Stack
    ;hago el push para poder cargar los registros en el stack
    push eax 
    push eax
    push eax

    mov eax, [__TSS_tarea2 + 0x20] ;EIP
    mov [esp], eax
    mov eax, [__TSS_tarea2 + 0x4C] ;CS
    mov [esp + 0x04], eax
    mov eax, [__TSS_tarea2 + 0x24] ;EFLAGS
    or eax, 0x0202                   ;Enable int
    mov [esp + 0x08], eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea2 + 0x28]    
    mov ecx, [__TSS_tarea2 + 0x2C]
    mov edx, [__TSS_tarea2 + 0x30]
    mov ebx, [__TSS_tarea2 + 0x34]
    ;mov esp, [__TSS_tarea2 + 0x38]
    ;mov ebp, [__TSS_tarea2 + 0x3C]        
    mov esi, [__TSS_tarea2 + 0x40]
    mov edi, [__TSS_tarea2 + 0x44]

    jmp return_cargar_tarea2
    

cargar_tarea3:

;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea3
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov es,[__TSS_tarea3 + 0x48] 
    mov cs,[__TSS_tarea3 + 0x4C]
    mov ss,[__TSS_tarea3 + 0x50] 
    mov ds,[__TSS_tarea3 + 0x54] 
    mov fs,[__TSS_tarea3 + 0x58] 
    mov gs,[__TSS_tarea3 + 0x5C] 

    mov esp, [__TSS_tarea3 + 0x38]
    mov ebp, [__TSS_tarea3 + 0x3C]   

    ;Registros del Stack
    ;hago el push para poder cargar los registros en el stack
    push eax 
    push eax
    push eax

    mov eax, [__TSS_tarea3 + 0x20] ;EIP
    mov [esp], eax
    mov eax, [__TSS_tarea3 + 0x4C] ;CS
    mov [esp + 0x04], eax
    mov eax, [__TSS_tarea3 + 0x24] ;EFLAGS
    or eax, 0x0202                   ;Enable int
    mov [esp + 0x08], eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea3 + 0x28]    
    mov ecx, [__TSS_tarea3 + 0x2C]
    mov edx, [__TSS_tarea3 + 0x30]
    mov ebx, [__TSS_tarea3 + 0x34]
    ;mov esp, [__TSS_tarea3 + 0x38]
    ;mov ebp, [__TSS_tarea3 + 0x3C]        
    mov esi, [__TSS_tarea3 + 0x40]
    mov edi, [__TSS_tarea3 + 0x44]

    jmp return_cargar_tarea3    

cargar_tarea4:

;cambiar CR3 para que apunte a la tabla de paginacion de la tarea_x
    mov eax,__CR3_tarea4
    mov cr3,eax                ;Apuntar a directorio de paginas de la tarea_x

    ;Cargo los registros de segmento
    mov es,[__TSS_tarea4 + 0x48]
    mov cs,[__TSS_tarea4 + 0x4C] 
    mov ss,[__TSS_tarea4 + 0x50] 
    mov ds,[__TSS_tarea4 + 0x54] 
    mov fs,[__TSS_tarea4 + 0x58] 
    mov gs,[__TSS_tarea4 + 0x5C] 

    mov esp, [__TSS_tarea4 + 0x38]
    mov ebp, [__TSS_tarea4 + 0x3C]   

    ;Registros del Stack
    ;hago el push para poder cargar los registros en el stack
    push eax 
    push eax
    push eax

    mov eax, [__TSS_tarea4 + 0x20] ;EIP
    mov [esp], eax
    mov eax, [__TSS_tarea4 + 0x4C] ;CS
    mov [esp + 0x04], eax
    mov eax, [__TSS_tarea4 + 0x24] ;EFLAGS
    or eax, 0x0202                   ;Enable int
    mov [esp + 0x08], eax

    ;Registros de Proposito general
    mov eax, [__TSS_tarea4 + 0x28]    
    mov ecx, [__TSS_tarea4 + 0x2C]
    mov edx, [__TSS_tarea4 + 0x30]
    mov ebx, [__TSS_tarea4 + 0x34]
    ;mov esp, [__TSS_tarea4 + 0x38]
    ;mov ebp, [__TSS_tarea4 + 0x3C]        
    mov esi, [__TSS_tarea4 + 0x40]
    mov edi, [__TSS_tarea4 + 0x44]

    jmp return_cargar_tarea4 

