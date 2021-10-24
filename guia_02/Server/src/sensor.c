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

#include "../inc/ServidorWeb.h"

sensor_t leer_Sensor(void)
{
int fd;
sensor_t aux;

  fd = open ("/dev/driverI2C", O_RDWR);
  if (fd < 0)
  {
    perror("No puedo abrir toupper");
    exit(1);
  }

  read("/dev/driverI2C", &aux, sizeof(sensor_t));

  close(fd);

  return aux;
}