#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <math.h>
#include <signal.h>
#include <stdbool.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <sys/stat.h>
#include <sys/select.h>
#include <sys/sendfile.h>

// Define SHARED MEMORY
#define SHARED_SIZE             4096

#define KEY 0x1111

union semun
{
    int val;
    struct semid_ds *buf;
    unsigned short *array;
};

struct MPU6050_REGS
{
    uint16_t accel_xout;
    uint16_t accel_yout;
    uint16_t accel_zout;
    int16_t temp_out;
    uint16_t gyro_xout;
    uint16_t gyro_yout;
    uint16_t gyro_zout;
};

struct confServer {
    int conexiones_actuales;    // en configuracion.cfg = a
    int backlog;                // en configuracion.cfg = b
    int conexiones_max;         // en configuracion.cfg = c
    int muestreo;               // en configuracion.cfg = m
    //int X_HardOffset;           // en configuracion.cfg = x
    //int Y_HardOffset;           // en configuracion.cfg = y
    //float sensor_period;        // en configuracion.cfg = f 
};


void ProcesarCliente(int s_aux, struct sockaddr_in *pDireccionCliente, int puerto);

// Signal handlers.
void SIGINT_handler(int signbr);
void SIGUSR1_handler(int signbr);
void SIGCHLD_handler(int signbr);
