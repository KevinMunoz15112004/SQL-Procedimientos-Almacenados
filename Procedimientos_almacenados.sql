CREATE DATABASE procedimientos_almacenados;

USE procedimientos_almacenados;

CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  
    Nombre VARCHAR(100),                      
    Estatura DECIMAL(5,2),                   
    FechaNacimiento DATE,                    
    Sueldo DECIMAL(10,2),
    Edad INT
);

-- Crear un procedimiento simple que seleccione datos de la tabla cliente

DELIMITER $$

CREATE PROCEDURE SeleccionarClientes()
BEGIN
    SELECT * FROM cliente;
END $$

DELIMITER ;

-- 	Ejectuar LLAMAR (CALL)

CALL SeleccionarClientes();

-- Inserción, Actualización y Eliminación de Datos

DELIMITER $$

CREATE PROCEDURE InserciónCliente(
    IN c_Nombre VARCHAR(100),
    IN c_Estatura DECIMAL(5,2),
    IN c_FechaNacimiento DATE,
    IN c_Sueldo DECIMAL(10,2),
    IN c_Edad INT
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo, Edad)
    VALUES (c_Nombre, c_Estatura, c_FechaNacimiento, c_Sueldo, c_Edad);
END $$

DELIMITER ;

-- Ejecución de CALL

CALL InserciónCliente('Pedro Pérez', 1.75, '1985-04-23', 4500.00, 25);
CALL InserciónCliente('Juan Gonzales', 1.80, '1999-03-20', 3500.00, 25);

-- Actualización

DELIMITER $$

CREATE PROCEDURE ActualizarEdadCliente(
    IN c_ClienteID INT,
    IN c_NuevaEdad INT
)
BEGIN
    UPDATE cliente
    SET Edad = c_NuevaEdad
    WHERE ClienteID = c_ClienteID;
END $$

DELIMITER ;

-- Ejecución CALL

CALL ActualizarEdadCliente(1, 39);

-- Eliminación

DELIMITER $$

CREATE PROCEDURE EliminarCliente(
    IN c_ClienteID INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = c_ClienteID;
END $$

DELIMITER ;

-- Ejecución CALL

CALL EliminarCliente(2);

-- Condicionales dentro de un procedimiento

DELIMITER $$

CREATE PROCEDURE VerificarEdadCliente(
    IN c_ClienteID INT
)
BEGIN
    DECLARE v_Edad INT;

    SELECT Edad INTO v_Edad
    FROM cliente
    WHERE ClienteID = c_ClienteID;

    IF v_Edad >= 22 THEN
        SELECT 'La edad es mayor o igual a 22' AS Resultado;
    ELSE
        SELECT 'La edad es menor a 22' AS Resultado;
    END IF;
END $$

DELIMITER ;

-- Ejecución CALL

CALL VerificarEdadCliente(1);

-- Creación tabla Ordenes

CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaOrden DATE,
    MontoTotal DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

-- Insertar Orden

DELIMITER $$

CREATE PROCEDURE InsertarOrden(
    IN o_ClienteID INT,
    IN o_FechaOrden DATE,
    IN o_MontoTotal DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, MontoTotal)
    VALUES (o_ClienteID, o_FechaOrden, o_MontoTotal);
END $$

DELIMITER ;

-- Ejecución CALL

CALL InsertarOrden(1, '2024-11-25', 700.00);

-- Actualización Orden

DELIMITER $$

CREATE PROCEDURE ActualizarOrden(
    IN o_OrdenID INT,
    IN o_FechaOrden DATE,
    IN o_MontoTotal DECIMAL(10,2)
)
BEGIN
    UPDATE ordenes
    SET FechaOrden = o_FechaOrden, MontoTotal = o_MontoTotal
    WHERE OrdenID = o_OrdenID;
END $$

DELIMITER ;

-- Ejecución CALL

CALL ActualizarOrden(1, '2024-12-22', 1000.00);

-- Eliminar Orden

DELIMITER $$

CREATE PROCEDURE EliminarOrden(
    IN o_OrdenID INT
)
BEGIN
    DELETE FROM ordenes WHERE OrdenID = o_OrdenID;
END $$

DELIMITER ;

-- Ejecución CALL

CALL EliminarOrden(1);
