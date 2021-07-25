

;Pagina de 4 KB supervisor R/W
;CR3 = 0x00010000

;Sección                            Dirección fisica inicial         Dirección lineal inicial
;Tablas de sistema                  0x00000000                       0x00000000
;Tablas de Paginación               0x00010000                       0x00010000
;Video                              0x000B8000                       0x00E80000
;ISRs                               0x00100000                       0x00100000
;Datos                              0x00200000                       0x01200000
;Tabla de Dígitos                   0x00210000                       0x01210000
;Kernel                             0x00220000                       0x01220000
;TEXT Tarea1                        0x00310000                       0x01310000
;BSS Tarea 1                        0x00320000                       0x01320000
;Data Tarea 1                       0x00330000                       0x01330000
;RODATA Tarea 1                     0x00340000                       0x01340000
;Pila Kernel                        0x1FFF8000                       0x2FFF8000
;PIla Tarea 1                       0x1FFFF000                       0x0078F000
;Secuencia inicialización ROM       0xFFFF0000                       0xFFFF0000    
;Vector de reset                    0xFFFFFFF0                       0xFFFFFFF0
                  
;-----------------Tablas Kernel--------------------------------
section .sys_tables_paginacion

;tamaño de directorio = 0x1000  4kB
;tamaño de una tabla = 0x1000
;tamaño de las 1024(0x400) tablas = 0x1000*0x400 = 0x400000 4MB ???

PagT:
DPT EQU $ - PagT
    times 0x1000 db 0
PTE EQU $ - PagT
    times 0x1000 db 0
