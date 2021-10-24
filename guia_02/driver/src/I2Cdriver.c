/*
*   Autor: Gavegno Sebastian
*   Fecha: 17/10/2021
*   Detalles: Driver para la lectura del sensor MPU6050 por medio de I2C
*/
#include "../inc/I2Cdriver.h"
#include "../inc/MPU6050.h"
#include "../inc/BBB_reg_I2C.h"

static DECLARE_WAIT_QUEUE_HEAD (queue);
static void __iomem *cmper_baseAddr, *ctlmod_baseAddr, *i2c2_baseAddr;
volatile int virq;

/*  ID table */
static struct of_device_id MPU6050_id[] = {
    {
        .compatible = COMPATIBLE,
    }, {}
};

MODULE_DEVICE_TABLE(of, MPU6050_id);

//driver functions
static struct platform_driver I2C_MPU6050_driver = {
	.probe = I2C_MPU6050_probe,
	.remove = I2C_MPU6050_remove,
	.driver = {
		.name = COMPATIBLE,
		.of_match_table = of_match_ptr(MPU6050_id)
	},
};

char kbuffer[BUF_SIZE]; //KERNEL buffer


int I2C_MPU6050_open(struct inode *inode, struct file *file)
{
	pr_alert("%s: I2C driver open\n", ID);
	// pido una pagina para usar como espacio lectura (vector)
	if ((data_i2c.buff_rx = (char *) __get_free_page(GFP_KERNEL)) < 0)
	{
		pr_alert("%s: Falla al pedir memoria\n", ID);
		return -1;
	}
    return 0;
}

int I2C_MPU6050_release(struct inode *inode, struct file *file)
{
	pr_alert("%s: I2C driver close\n", ID);
	// libero la pagina que tome para lectura
	free_page((unsigned long)data_i2c.buff_rx);
    return 0;
}

ssize_t I2C_MPU6050_write(struct file *file, const char __user *userbuff, size_t tamano, loff_t *offset)
{
	pr_alert("%s: I2C driver write\n", ID);
    return 0;
}

ssize_t I2C_MPU6050_read(struct file *file, char __user *userbuff, size_t tamano, loff_t *offset)
{
	pr_alert("%s: I2C driver read\n", ID);
	//Nunca leer mas del tamaño limite de memoria de datos.
	if(tamano > sizeof(sensor_t))
	{
		tamano  = sizeof(sensor_t);			//Si me pasan un tamaño mayor al de la estructura lo seteo con el maximo
	}
	datosI2C.accel_xout = 1;
	datosI2C.accel_yout = 2;
	datosI2C.accel_zout = 3;
	datosI2C.temp_out = 25;
	datosI2C.gyro_xout = 4;
	datosI2C.gyro_yout = 5;
	datosI2C.gyro_zout = 6;
	if(copy_to_user(userbuff, &datosI2C, tamano) > 0)		//en copia correcta devuelve 0
	{
		pr_alert("%s: Falla en copia de buffer de kernel a buffer de usuario\n", ID);
		return -1;
	}

    return 0;
}


irqreturn_t i2c_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
{

	return 0;
}


/*
* Función para verificar que el dispositivo esté presente dentro del platform-bus, se reservan los recursos de hardware
* del sistema que sean necesarios (Memoria de kernel, IRQ line, handler de interrupción, …) 
* y se configura el platform device para el funcionamiento del mismo
*/
int I2C_MPU6050_probe(struct platform_device *i2c_pd)
{
	int status = 0;
	int aux;
	
	pr_alert("%s: I2C driver probe\n", ID);
	// ----Mapeo el registro CM_PER----
	if((cmper_baseAddr = ioremap(CM_PER, CM_PER_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear CM_PER\n", ID);
		return 1;
	}
	pr_info("%s: cmper_baseAddr: 0x%X\n", ID, (unsigned int)cmper_baseAddr);

	// ----Mapeo el registro CONTROL MODULE----
	if((ctlmod_baseAddr = ioremap(CTRL_MODULE_BASE, CTRL_MODULE_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear CONTROL MODULE\n", ID);
		iounmap(cmper_baseAddr);
		return 1;
	}
	pr_info("%s: ctlmod_baseAddr: 0x%X\n", ID, (unsigned int)ctlmod_baseAddr);

	// ----Mapeo el registro I2C2----
	if((i2c2_baseAddr = ioremap(I2C2, I2C2_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear I2C\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		return 1;
	}
	pr_info("%s: i2c2_baseAddr: 0x%X\n", ID, (unsigned int)i2c2_baseAddr);

	// ----Configuracion de VirtualIRQ----
	// Pido un número de interrupcion
	if((virq = platform_get_irq(i2c_pd, 0)) < 0) {
		pr_alert("%s: No se le pudo asignar una VIRQ\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		iounmap(i2c2_baseAddr);
		return 1;
	}

	// Lo asigno a mi handler
	if(request_irq(virq, (irq_handler_t) i2c_irq_handler, IRQF_TRIGGER_RISING, COMPATIBLE, NULL))
	{
		pr_alert("%s: No se le pudo bindear VIRQ con handler\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		iounmap(i2c2_baseAddr);
		return 1;
	}
	pr_info("%s: Numero de IRQ %d\n", ID, virq);
	
	// ----Habilito el clock del I2C----
	aux = ioread32(cmper_baseAddr + IDCM_PER_I2C2_CLKCTRL);
	aux |= 0x02;												//MODULEMODE - 0x2 = ENABLE
	iowrite32(aux, cmper_baseAddr + IDCM_PER_I2C2_CLKCTRL);

	do{
		msleep(1);
		pr_info("%s: Configurando registro CM_PER..\n", ID);
	}while(ioread32(cmper_baseAddr + IDCM_PER_I2C2_CLKCTRL) != 2);
    msleep(10); // Espero a que este listo el clock

	// ----Seteo de Registros de los pines I2C----
	iowrite32(0x00, i2c2_baseAddr + I2C_CON);
	iowrite32(0x03, i2c2_baseAddr + I2C_PSC);
	iowrite32(I2C_SCLL_400K, i2c2_baseAddr + I2C_SCLL);
	iowrite32(I2C_SCLH_400K, i2c2_baseAddr + I2C_SCLH);
	iowrite32(0x36, i2c2_baseAddr + I2C_OA);
    iowrite32(0x00, i2c2_baseAddr + I2C_SYSC);
	iowrite32(0x76, i2c2_baseAddr + I2C_SA);
	iowrite32(0x8000, i2c2_baseAddr + I2C_CON);

	// ----Habilito el capacidades de pines de SDA y SCL-----
	iowrite32(0x33, ctlmod_baseAddr + CTRL_MODULE_UART1_CTSN);
	iowrite32(0x33, ctlmod_baseAddr + CTRL_MODULE_UART1_RTSN);

	pr_info("%s: Termina PROBE ..\n", ID);
	return status;
}

//remove function
/*
* Función para remover un dispositivo dentro del platform-bus
*/
int I2C_MPU6050_remove(struct platform_device *i2c_pd)
{
	int status = 0;

	pr_alert("%s: I2C driver remove\n", ID);
	iounmap(cmper_baseAddr);
	iounmap(ctlmod_baseAddr);
	iounmap(i2c2_baseAddr);

	free_irq(virq, NULL);

	pr_alert("%s: Salí del REMOVE\n", ID);
	return status;
}


static int I2C_MPU6050_devnode(struct device *dev, struct kobj_uevent_env *env)
{
    add_uevent_var(env, "DEVMODE=%#o", 0666);
    return 0;
}

/*
static int I2C_MPU6050_devnode(struct device *dev, umode_t *mode)
{
    if (mode == NULL)
    {
        return NULL;
    }
    *mode = 0666;
    return NULL;
}
*/

/*
    intalacion del driver
comandos:
    sudo insmod driver-i2c.ko
    lsmod | grep driver-i2c  --> me dice los modulos que tengo instalados. con grep filtro 
*/
static int __init I2C_MPU6050_init(void)
{
	int retorno = 0;
	pr_alert("%s: Asignar memoria al Char Device\n", ID);

   //Asigna un rango de números de char device.
	if((retorno = alloc_chrdev_region(&dev.I2C_MPU6050 , FIRST_MINOR, CANT_DISP, NOMBRE)) < 0)
	{
		pr_alert("%s: No es posible asignar el numero mayor\n", ID);
		return retorno;
	}
	pr_alert("%s: Numero mayor asignado %d 0x%X\n", ID, MAJOR(dev.I2C_MPU6050), MAJOR(dev.I2C_MPU6050));

	dev.I2C_MPU6050_cdev = cdev_alloc();
    if (dev.I2C_MPU6050_cdev < 0)
    {
		pr_alert("%s: No se pudo realizar cdev_alloc\n", ID);
        unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
        return -1;
    }

    //Inicializa cdev, recordando fops, preparándolo para añadirlo al sistema con cdev_add.
	cdev_init(dev.I2C_MPU6050_cdev , &I2C_MPU6050_ops);        // Equivale a:  dev.I2C_MPU6050cdev->ops = &I2C_MPU6050_ops;

    // añadir un char device al sistema 
	if((retorno = cdev_add(dev.I2C_MPU6050_cdev, dev.I2C_MPU6050, CANT_DISP)) < 0)   // Equivale a: dev.I2C_MPU6050cdev->owner = THIS_MODULE;
	{                                                                         // 	         dev.I2C_MPU6050cdev->dev = dev.I2C_MPU6050;
		// anular el registro de un rango de números de char device
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		pr_alert("%s: No es no es posible registrar el dispositivo\n", ID);
		return retorno;
	}

	// Creo clase de dispositivo
	if((dev.I2C_MPU6050_clase = class_create( THIS_MODULE, CLASS_NAME)) == NULL)
	{
		pr_alert("%s: No se pudo crear la estructura class\n", ID);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return EFAULT;
	}

	// cambiar el permiso
	dev.I2C_MPU6050_clase->dev_uevent = I2C_MPU6050_devnode;

	// Creo device
	if((device_create(dev.I2C_MPU6050_clase, NULL, dev.I2C_MPU6050, NULL, COMPATIBLE)) == NULL)
	{
		pr_alert("%s: No se pudo crear el Device\n", ID);
		class_destroy(dev.I2C_MPU6050_clase);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return EFAULT;
	}

	pr_alert("%s: Inicializacion del modulo I2C \n", ID);

	if((retorno = platform_driver_register(&I2C_MPU6050_driver)) <0)
	{
		pr_alert("%s: No se pudo registrar el platformDevice\n", ID);
		device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
		class_destroy(dev.I2C_MPU6050_clase);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return retorno;
	}
	
	pr_alert("%s: I2C driver instalado\n", ID);
    return 0;
}

/*
    desintalacion del driver
    sudo rmmod driver-i2c
*/
static void __exit I2C_MPU6050_exit(void)
{
 	pr_alert("%s: Cerrando el CharDriver\n", ID);
	cdev_del(dev.I2C_MPU6050_cdev);
	unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
	device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
    class_destroy(dev.I2C_MPU6050_clase);
	platform_driver_unregister(&I2C_MPU6050_driver);
 	pr_alert("%s: I2C driver desinstalado\n", ID);
}

module_init(I2C_MPU6050_init);
module_exit(I2C_MPU6050_exit);
