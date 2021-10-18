/*
*   Autor: Gavegno Sebastian
*   Fecha: 17/10/2021
*   Detalles: Driver para la lectura del sensor MPU6050 por medio de I2C
*/

#include "./inc/I2Cdriver.h"
#include "./inc/MPU6050.h"
#include "./inc/BBB_reg_I2C.h"


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

    return 0;
}

int I2C_MPU6050_release(struct inode *inode, struct file *file)
{

    return 0;
}

ssize_t I2C_MPU6050_write(struct file *file, const char __user *userbuff, size_t tamano, loff_t *offset)
{
    return 0;
}

ssize_t I2C_MPU6050_read(struct file *file, char __user *userbuff, size_t tamano, loff_t *offset)
{

    return 0;
}


/*
* Función para verificar que el dispositivo esté presente dentro del platform-bus, se reservan los recursos de hardware
* del sistema que sean necesarios (Memoria de kernel, IRQ line, handler de interrupción, …) 
* y se configura el platform device para el funcionamiento del mismo
*/
int I2C_MPU6050_probe(struct i2c_client *client, const struct i2c_device_id *id)
{

    return 0;
}

//remove function
/*
* Función para remover un dispositivo dentro del platform-bus
*/
int I2C_MPU6050_remove(struct i2c_client *client)
{

    return 0;
}

static char *I2C_MPU6050_devnode(struct device *dev, umode_t *mode)
{
    if (mode == NULL)
    {
        return NULL;
    }
    *mode = 0666;
    return NULL;
}

/*
    intalacion del driver
comandos:
    sudo insmod driver-i2c.ko
    lsmod | grep driver-i2c  --> me dice los modulos que tengo instalados. con grep filtro 
*/
static int __init I2C_MPU6050_init(void)
{
	int retorno = 0;
	pr_alert("%s: Set CharDriver\n", ID);
	dev.I2C_MPU6050_cdev = cdev_alloc();

    //Asigna un rango de números de char device.
	if((retorno = alloc_chrdev_region(&dev.I2C_MPU6050 , FIRST_MINOR, CANT_DISP, COMPATIBLE)) < 0){
		pr_alert("%s: No es posible asignar el numero mayor\n", ID);
		return retorno;
	}

	pr_alert("%s: Numero mayor asignado %d 0x%X\n", ID, MAJOR(dev.I2C_MPU6050), MAJOR(dev.I2C_MPU6050));

    //Inicializa cdev, recordando fops, preparándolo para añadirlo al sistema con cdev_add.
	cdev_init(dev.I2C_MPU6050cdev , &I2C_MPU6050_ops);        // Equivale a:  dev.I2C_MPU6050cdev->ops = &I2C_MPU6050_ops;

    // añadir un char device al sistema 
	if((retorno = cdev_add(dev.I2C_MPU6050cdev, dev.myi2c, CANT_DISP)) < 0)   // Equivale a: dev.I2C_MPU6050cdev->owner = THIS_MODULE;
	{                                                                         // 	         dev.I2C_MPU6050cdev->dev = dev.I2C_MPU6050;
		// anular el registro de un rango de números de char device
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		pr_alert("%s: No es no es posible registrar el dispositivo\n", ID);
		return retorno;
	}

	// Creo clase de dispositivo
	if((dev.I2C_MPU6050_clase = class_create( THIS_MODULE, CLASS_NAME)) == NULL){
		pr_alert("%s: Cannot create the struct class for device\n", ID);
		cdev_del(state.myi2c_cdev);
		unregister_chrdev_region(state.myi2c, CANT_DISP);
		return EFAULT;
	}

	// cambiar el permiso 
	dev.I2C_MPU6050_clase->dev_uevent = I2C_MPU6050_devnode;

	// Creo device
	if((device_create(dev.I2C_MPU6050_clase, NULL, dev.I2C_MPU6050, NULL, COMPATIBLE)) == NULL){
		pr_alert("%s: Cannot create the Device\n", ID);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
		return EFAULT;
	}

	pr_alert("%s: Inicializacion del modulo I2C \n", ID);

	if((retorno = platform_driver_register(&I2C_MPU6050_driver)) <0){
		pr_alert("%s: No se pudo registrar el platformDevice\n", ID);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
		class_destroy(dev.I2C_MPU6050_clase);
		return retorno;
	}

    printk("I2C driver added\n");
    return 0;
}

/*
    desintalacion del driver
    sudo rmmod driver-i2c
*/
static void __exit I2C_MPU6050_exit(void)
{
 	printk(KERN_ALERT "%s: Cerrando el CharDriver\n", ID);
	cdev_del(dev.I2C_MPU6050_cdev);
	unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
	device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
    class_destroy(dev.I2C_MPU6050_clase);
	platform_driver_unregister(&I2C_MPU6050_driver);
}

module_init(I2C_MPU6050_init);
module_exit(I2C_MPU6050_exit);
