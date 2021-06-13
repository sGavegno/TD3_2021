


section .sys_tables_paginacion

;Seccion               Direccion lineal    
;tabla sis               0x00000000     
;tabla pag               0x00010000
;video                   0x000B8000
;ISR                     0x00100000
;               0x00200000
;               0x00210000
;               0x00220000
;               0x00310000
;               0x00320000
;               0x00330000
;               0x00340000
;               0x2FFF8000
;               0x2FFFF000
;
; Directorio de paginas
;   indice  contenido
;   0x3FF  |00000000|   No presente
;    ...      ...    
;   0x200  |00501003|   Tabla de paginas comienza en 0x00501000
;    ...      ...
;   0x004  |01000083|   Pagina de 4 MB supervisor R/W comienza en 16 MB
;   0x003  |00C00083|   Pagina de 4 MB supervisor R/W comienza en 12 MB
;   0x002  |00800083|   Pagina de 4 MB supervisor R/W comienza en 8 MB
;   0x001  |00400083|   Pagina de 4 MB supervisor R/W comienza en 4 MB
;   0x000  |00000083|   Pagina de 4 MB supervisor R/W comienza en 0 MB
;
; Tabla de paginacion
;   indice  contenido
;   0x3FF  |00000000|   No presente
;    ...      ...    
;   0x000  |000B8003|   Pagina de 4 KB supervisor R/W comienza en 0x000B8000
;
;
;
;