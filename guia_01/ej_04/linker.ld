ENTRY (reset)

    __INIT_ROM              = 0xFFFF0000;
    __RESET                 = 0xFFFFFFF0;

    __STACK_START = 0x2FFF4000;
    __STACK_END = 0x2FFF8000 - 4;
    __STACK_SIZE = (__STACK_END - __STACK_START); /*32b word*/

   /*-----------------VMA-----------------*/
    __RUTINAS_VMA           = 0x00010000; 
    __KERNEL_VMA            = 0x00020200;

    /*-----------------LMA-----------------*/
    __INIT_LMA              = 0xFFFF0000; 


SECTIONS
{   
    .init __INIT_ROM :                              
        AT ( __INIT_ROM )
        { 
            *(.init);
            __INIT_size = SIZEOF(.init);        
        }

    __SYS_TABLES_VMA = .;
    .data :
        AT ( LOADADDR(.init) + SIZEOF(.init))
        {
            __SYS_TABLES_LMA = LOADADDR(.data);
            *(.sys_tables); 
            __SYS_TABLES_size = SIZEOF(.data);
        }

    .rutinas __RUTINAS_VMA :
        AT ( LOADADDR(.data) + SIZEOF(.data) )
        { 
            __RUTINAS_LMA = LOADADDR(.rutinas);
            *(.rutinas); 
            __RUTINAS_size = SIZEOF(.rutinas);
        }
        __RUTINAS_VMA_END = .;

    .kernel __KERNEL_VMA :
        AT ( LOADADDR(.rutinas) + SIZEOF(.rutinas) )
        { 
            __KERNEL_LMA = LOADADDR(.kernel);            
            *(.main32); 
            __KERNEL_size = SIZEOF(.kernel);        
        }
        __KERNEL_VMA_END = .;

    .reset __RESET :
        AT (__RESET)
        { *(.reset); }

}