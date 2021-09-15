
//#include "../inc/define.h"
#include "../inc/handler.h"
#include "../inc/init.h"

//-------Variables Externas--------------
extern int FLAG_KILL_PADRE;

//----- Variables Globales -----
int pid = 1;
int var = 0, varP = 0;
int CANTCHLD = 0;

int FLAG_FIRST = 0;


//-- MAIN --
int main (int argc, char *argv[]) 
{
//int i = 0;

char file_name[10]; 
FILE *pFile;				//--Puntero al archivo --
char errBuf[256];

	init_signal();

	if(argc > 1)
	{
		CANTCHLD = (int)*argv[1] - '0'; 
	}

/*
	for(i = 0; i < CANTCHLD; i++) 
    {
		pid = fork();

    	if(pid == 0)
    	{
			//Código del hijo
			while (1)
			{
				printf("Proceso hijo ID=%d, mi padre es ID=%d, mi grupo ID=%d, var=%d\r\n", getpid(), getppid(), getpgrp(),var);
				sleep(10);
			}
        	//raise( SIGKILL);		
    	}
    }
*/
    
	while(1)
	{
		if(pid == 0)
    	{
			//Código del hijo
			if(FLAG_FIRST == 0)
			{
				//Creo archivo
				sprintf(file_name, "%d", getpid());
				//-- Abro el archivo como lectura --
				pFile = fopen ( file_name, "w+");
				if (pFile == NULL) {
					//-- Error al abrir el archivo --
					strerror_r (errno, errBuf, sizeof (errBuf));			//-- Obtengo la leyenda del error --
					printf ("Error al abrir el archivo %d: %s\r\n", errno, errBuf);	//-- Imprime en stdout --
					//perror ("Error al abrir el archivo test00.txt");		//-- Imprime en stderror --
					return (-1);
				}
			FLAG_FIRST=1;
			}
			else
			{
				//escrivo archivo	
				printf("Proceso hijo ID=%d, mi padre es ID=%d, mi grupo ID=%d, var=%d\r\n", getpid(), getppid(), getpgrp(),var);
			}

			
			sleep(10);
    	}
		else if(pid > 0)
		{
			//Código del padre
			printf("Yo soy tu padre %d, mi grupo ID=%d\n\r", getpid(), getpgrp());
/*
			if(FLAG_KILL_PADRE == 1)
			{
				
				for(i=0; i < CANTCHLD; i++)
				{

				}

			}
*/
			sleep(20);
		}
	}

	printf("Muere el padre ID = %d\n\r", getpid());

	return(0);
} 

