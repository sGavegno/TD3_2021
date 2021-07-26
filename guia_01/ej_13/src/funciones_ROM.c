
#include "../inc/funciones_ROM.h"

//------------------------------Paginacion------------------------------------------------
__attribute__(( section(".funciones_ROM"))) void carga_paginacion_ROM(dword Init_DP, dword Dir_Lineal, dword Dir_Fisica, word AtDP, word AtTP)
{
	//dword *Dir_DP = 0;
	//dword *Dir_TP = 0;
	dword Cont_DP = 0;
	dword Cont_TP = 0;
	dword Aux = 0;	
	word indice_DP = 0;
	word indice_TP = 0;

	Aux = (Dir_Lineal & 0xFFFFF000) >> 12; 
	indice_DP = (Aux>>10) & 0x3FF;
	indice_TP = Aux & 0x3FF;

	dword *Dir_DP = (dword *)(Init_DP + indice_DP*4);
	//*Dir_DP  = Init_DP + indice_DP*4;
	Cont_DP = (Init_DP + 0x1000 + indice_DP * 0x1000) | AtDP;

	dword *Dir_TP = (dword *)(Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4);
//	*Dir_TP = Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4;
	Cont_TP = Dir_Fisica | AtTP;

	*Dir_DP = Cont_DP;
	*Dir_TP = Cont_TP;
}

// paginacion de la ROM
/*
------------0xFFFF0000 - 0xFFFF0FFF
indice_DP = 0x3FF
indice_TP = 0x3F0

------------0xFFFF1000 - 0xFFFF1FFF
indice_DP = 0x3FF
indice_TP = 0x3F1

------------0xFFFFx000 - 0xFFFFxFFF
indice_TP = 0x3Fx
*/
__attribute__(( section(".funciones_ROM"))) void carga_pag_ROM(dword Init_DP)
{
	dword Cont_DP = 0;
	dword Cont_TP = 0;

	dword *Dir_DP = (dword *)(Init_DP + 0x3FF * 4);
	Cont_DP = Init_DP + 0x1000 + 0xF * 0x1000;
	*Dir_DP = Cont_DP + 0x03;	

	dword *Dir_TP0 = (dword *)(Cont_DP + 0x3F0 * 4);
	Cont_TP = 0xFFFF0000 + 0x03;
	*Dir_TP0 = Cont_TP;

	dword *Dir_TP1 = (dword *)(Cont_DP + 0x3F1 * 4);
	Cont_TP = 0xFFFF1000 + 0x03;
	*Dir_TP1 = Cont_TP;

	dword *Dir_TP2 = (dword *)(Cont_DP + 0x3F2 * 4);
	Cont_TP = 0xFFFF2000 + 0x03;
	*Dir_TP2 = Cont_TP;	
}