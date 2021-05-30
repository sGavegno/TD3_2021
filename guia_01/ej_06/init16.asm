USE16

;-------------------------------VARIABLES EXTERNAS-------------------------------------------------

;------------------------------VARIABLES GLOBALES--------------------------------------------------

;-------------------------------------SECTION------------------------------------------------------
DIR_LINEAL_ROM   EQU 0xFFFF0000

init:

    jmp inicio

;------------------------------------GDT PROVISORIA------------------------------------------------
GDT:
NULL_SEL_16    equ $-GDT
    DQ 0
CS_SEL_16 equ $-GDT          ;Base 0x00000000 Limite 0xFFFFFFFF
    dw  0xFFFF                          ;Limite del segmento(bits 15 -0)
    dw  0                               ;Base del segmento(bits 15-0)
    db  0                               ;Base del segmento(bits 23-16)
    db  0x9A                            ;DPL=00 / bit3=1 seg.codigo/bit2=0/bit1=1 Lectura
    db  0xCF                            ;G=1/D=1 32 bits/Limite(bits 19:16)
    db  0x00                            ;Base del segmento(bits 31-24)

DS_SEL_16 equ $-GDT          ;Base 0x00000000 Limite 0xFFFFFFFF
    dw  0xFFFF                          ;Limite del segmento(bits 15 -0)
    dw  0                               ;Base del segmento(bits 15-0)
    db  0                               ;Base del segmento(bits 23-16)
    db  0x92                            ;DPL=00 / bit3=0 seg.dato/bit2=0/bit1=1 (R/W)
    db  0xCF                            ;G=1/D=1 32 bits/Limite(bits 19:16)
    db  0x00                            ;Base del segmento(bits 31-24) 

GDT_SIZE equ $-GDT

gdtr_16:                                
       dw  GDT_SIZE - 1                 ;Li­mite GDT (16 bits).
       dd  GDT + DIR_LINEAL_ROM         ;Base GDT (32 bits). __SYS_TABLES_LMA


;---------------------------------------16 BITS------------------------------------------------------

inicio:
    test eax,0x0    ;verificar que el uP no este en falla
    jne fault_end

    xchg bx,bx

    xor eax,eax

    ;Paso a Modo Protejido 
    cli                                 ;Desabilito interupciones
    
    o32 lgdt[cs:gdtr_16]                ;cargo gdt provisoria

    mov eax,cr0	                        ;copio el contenido del registro de control 0 a eax
    or  eax,1	                        ;pongo el bit 0 a 1
    mov cr0,eax	                        ;pongo el valor de eax en cr0 (activo modo protegido)
    ;xchg bx,bx                          ;magic beackpoin


    jmp dword CS_SEL_16:modo_prot + DIR_LINEAL_ROM

fault_end:

    jmp fault_end
;--------------------------------Modo Protegido-------------------------------------
USE32

modo_prot:

    ;inicializa los selectores de datos
    mov ax, DS_SEL_16
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
