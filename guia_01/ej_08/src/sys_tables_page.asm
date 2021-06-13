

;Pagina de 4 KB supervisor R/W
;CR3 = 0x00010000
;Seccion        Direccion lineal    indice dir      indice tabla    offset tabla    
;tabla sis      0x00000 000         0x000           0x000           0x000                            
;tabla pag      0x00010 000         0x000           0x010           0x000               
;video          0x000B8 000         0x000           0x0B8           0x000
;ISR            0x00100 000         0x000           0x100           0x000
;Datos          0x00200 000         0x000           0x200           0x000
;tabla digito   0x00210 000         0x000           0x210           0x000
;kernel         0x00220 000         0x000           0x220           0x000
;TEXT tarea1    0x00310 000         0x000           0x310           0x000
;BSS tarea1     0x00320 000         0x000           0x320           0x000
;DATA tarea1    0x00330 000         0x000           0x330           0x000
;RODATA tarea1  0x00340 000         0x000           0x340           0x000
;pila kernel    0x2FFF8 000         0x0BF           0x2F8           0x000
;pila tarea1    0x2FFFF 000         0x0BF           0x2FF           0x000
;
;Seccion        Direccion FD        Contenido direc    Dir FT       Cont tabla    
;tabla sis      0x00010000          0x00011 003        0x00011000   0x00000 003                            
;tabla pag      0x00010000          0x00011 003        0x00011040   0x00010 003                 
;video          0x00010000          0x00011 003        0x000112E0   0x000B8 003        
;ISR            0x00010000          0x00011 003        0x00011400   0x00100 003        
;Datos          0x00010000          0x00011 003        0x00011800   0x00200 003       
;tabla digito   0x00010000          0x00011 003        0x00011840   0x00210 003        
;kernel         0x00010000          0x00011 003        0x00011880   0x00220 003        
;TEXT tarea1    0x00010000          0x00011 003        0x00011C40   0x00310 003        
;BSS tarea1     0x00010000          0x00011 003        0x00011C80   0x00320 003        
;DATA tarea1    0x00010000          0x00011 003        0x00011CC0   0x00330 003        
;RODATA tarea1  0x00010000          0x00011 003        0x00011D00   0x00340 003        
;pila kernel    0x000102FC          0x000D0 003        0x000D0BE0   0x2FFF8 003        
;pila tarea1    0x000102FC          0x000D0 003        0x000D0BFC   0x2FFFF 003        

section .sys_tables_paginacion



