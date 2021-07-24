
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
	Cont_DP = Init_DP + 0x1000 + indice_DP * 0x1000 + AtDP;

	dword *Dir_TP = (dword *)(Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4);
//	*Dir_TP = Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4;
	Cont_TP = Dir_Fisica | AtTP;

	*Dir_DP = Cont_DP;
	*Dir_TP = Cont_TP;
}