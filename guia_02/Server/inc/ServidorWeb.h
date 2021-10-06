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

#define KEY_SENSOR   0x1245
#define KEY_CONFIG   0x1232

union semun
{
    int val;
    struct semid_ds *buf;
    unsigned short *array;
    struct seminfo  *__buf;
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
    int conexiones_max;         
    int backlog;                
    int muestreo;
    int conexiones;               
};

void ManejadorSensor(void);
void ProcesarCliente(int s_aux, struct sockaddr_in *pDireccionCliente, int puerto);
void ManejadorConfiguracion(void);
// Signal handlers.
void SIGINT_handler(int sig);
void SIGUSR1_handler(int sig);
void SIGUSR2_handler(int sig);
void SIGCHLD_handler(int sig);

// Signal handlers sensor
void SIGINT_handler_Sensor(int signbr);
