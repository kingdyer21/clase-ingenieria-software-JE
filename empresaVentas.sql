/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `bd_empresaventas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bd_empresaventas`;

CREATE TABLE IF NOT EXISTS `cliente` (
  `Idcliente` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Edad` int(11) NOT NULL,
  PRIMARY KEY (`Idcliente`),
  KEY `Idcliente` (`Idcliente`),
  KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `cliente` (`Idcliente`, `Nombre`, `Apellido`, `Edad`) VALUES
	(7080, 'Carlos', 'Padilla', 25),
	(7081, 'Laura', 'Fuentes', 22),
	(7082, 'Alberto', 'Arroyo', 30),
	(7083, 'Maria', 'Carrascal', 21),
	(7084, 'Vanessa', 'Fontalvo', 28),
	(7085, 'David', 'Villareal', 32),
	(7086, 'Andrea', 'Castañeda', 37),
	(7087, 'Danna', 'sinisterra', 19);

CREATE TABLE IF NOT EXISTS `copia` (
  `Id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `fechaIngreso` date DEFAULT NULL,
  `horaIngreso` time DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `copia` (`Id`, `nombre`, `apellido`, `edad`, `fechaIngreso`, `horaIngreso`) VALUES
	(7086, 'Andrea', '', 0, '2024-04-21', '18:06:13'),
	(7087, 'Danna', 'sinisterra', 19, '2024-04-21', '18:10:35');

CREATE TABLE IF NOT EXISTS `factura` (
  `idFactura` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `Total` int(11) NOT NULL,
  `fk_idCliente` int(11) NOT NULL,
  `fk_idProducto` int(11) NOT NULL,
  PRIMARY KEY (`idFactura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `factura` (`idFactura`, `Fecha`, `Hora`, `Total`, `fk_idCliente`, `fk_idProducto`) VALUES
	(4560, '2024-09-21', '12:40:23', 12000, 0, 0),
	(4561, '2024-04-14', '17:29:50', 8000, 0, 0),
	(4562, '2024-04-28', '10:30:25', 7500, 0, 0),
	(4563, '2024-04-29', '17:31:24', 9000, 0, 0);

CREATE TABLE IF NOT EXISTS `producto` (
  `idProducto` int(11) NOT NULL,
  `NombreProducto` varchar(50) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Precio` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `producto` (`idProducto`, `NombreProducto`, `Cantidad`, `Precio`) VALUES
	(1250, 'Pollo', 4, 4500),
	(1251, 'Zanahoria', 8, 2000),
	(1252, 'Papa', 10, 2200),
	(1253, 'Huevo', 12, 16200);

CREATE TABLE `vista` (
	`nombre` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`apellido` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`edad` INT(11) NOT NULL
) ENGINE=MyISAM;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `disparador` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
INSERT INTO copia (Id,nombre,apellido,edad,fechaIngreso,horaIngreso)
VALUES (NEW.Idcliente, NEW.Nombre, NEW.Apellido, NEW.Edad,NOW(),NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

DROP TABLE IF EXISTS `vista`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista` AS SELECT nombre, apellido, edad 
FROM cliente 
WHERE edad = "30" ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
