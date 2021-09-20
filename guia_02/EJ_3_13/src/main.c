
//#include "../inc/define.h"
#include "../inc/handler.h"
#include "../inc/init.h"

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
//-------Variables Externas--------------

//----- Variables Globales -----
int pid = 1, pid2 = 1;

char buffer[200];

char *MyFIFO = "myFIFO";

//----- FLAGS ------------
int FLAG_SIG1 = 0;
int FLAG_SIG2 = 0;

//-- MAIN --
int main(int argc, char *argv[])
{
	int i;
	int process = 0;
	char exitwhile = 1;
	char errBuf[256];
	FILE *pFile1;
	FILE *pFile2;

	init_signal();

	pid = fork();

	if (pid == 0)
	{
		//codigo del hijo1
		process = 1;
		printf("Proceso hijo ID=%d, Nº de proceso %d\r\n", getpid(), process);
	}
	else if (pid > 0)
	{
		//Código del padre
		pid2 = fork();
		if (pid2 == 0)
		{
			//codigo del hijo2
			process = 2;
			printf("Proceso hijo ID=%d, Nº de  proceso %d\r\n", getpid(), process);
		}
		else
		{
			
		}
	}

	while (exitwhile)
	{
		switch (process)
		{
		case 0:
			//codigo del padre
			if (FLAG_KILL_PADRE == 1)
			{
				exitwhile = 0;
			}
			sleep(1);


			if(FLAG_SIG1)
			{
				kill(pid, SIGUSR1);
			}

			if(FLAG_SIG2)
			{
				kill(pid, SIGUSR2);
			}

			break;

		case 1:
			//codigo del hijo1
			pFile1 = fopen("data1.txt", "w+");
			if (pFile1 == NULL)
			{
				//-- Error al abrir el archivo --
				strerror_r(errno, errBuf, sizeof(errBuf));					   //-- Obtengo la leyenda del error --
				printf("Error al abrir el archivo %d: %s\r\n", errno, errBuf); //-- Imprime en stdout --
				//perror ("Error al abrir el archivo test00.txt");		//-- Imprime en stderror --
				return (-1);
			}

			pFile2 = fopen("data2.txt", "r");
			if (pFile2 == NULL)
			{
				//-- Error al abrir el archivo --
				strerror_r(errno, errBuf, sizeof(errBuf));					   //-- Obtengo la leyenda del error --
				printf("Error al abrir el archivo %d: %s\r\n", errno, errBuf); //-- Imprime en stdout --
				//perror ("Error al abrir el archivo test00.txt");		//-- Imprime en stderror --
				return (-1);
			}
			
			printf("Hijo1 ID=%d envia señal SIGUSR2\r\n \r\n",getpid());
			kill(getppid(),SIGUSR2);

			fclose(pFile1);
			fclose(pFile2);
			sleep(5);
			break;

		case 2:
			//codigo del hijo2			
			pFile1 = fopen("data1.txt", "r");
			if (pFile1 == NULL)
			{
				//-- Error al abrir el archivo --
				strerror_r(errno, errBuf, sizeof(errBuf));					   //-- Obtengo la leyenda del error --
				printf("Error al abrir el archivo %d: %s\r\n", errno, errBuf); //-- Imprime en stdout --
				//perror ("Error al abrir el archivo test00.txt");		//-- Imprime en stderror --
				return (-1);
			}

			pFile2 = fopen("data2.txt", "w+");
			if (pFile2 == NULL)
			{
				//-- Error al abrir el archivo --
				strerror_r(errno, errBuf, sizeof(errBuf));					   //-- Obtengo la leyenda del error --
				printf("Error al abrir el archivo %d: %s\r\n", errno, errBuf); //-- Imprime en stdout --
				//perror ("Error al abrir el archivo test00.txt");		//-- Imprime en stderror --
				return (-1);
			}

			//printf("Hijo2 ID=%d envia señal SIGUSR1 \r\n \r\n",getpid());
			//raise(SIGUSR1);

			fclose(pFile1);
			fclose(pFile2);
			sleep(5);
			break;

		default:
			break;
		}
	}

	printf("Muere el padre ID = %d\n\r", getpid());

	return (0);
}
