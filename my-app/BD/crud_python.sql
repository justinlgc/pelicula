-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para crud_python
CREATE DATABASE IF NOT EXISTS `crud_python`  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `crud_python`;

DROP TABLE IF EXISTS `tbl_empleados`;

-- Volcando estructura para tabla crud_python.peliculas
CREATE TABLE IF NOT EXISTS `tbl_peliculas` (
  `id_pelicula` int NOT NULL AUTO_INCREMENT,       
  `titulo_pelicula` varchar(100) DEFAULT NULL,    
  `categoria_pelicula` varchar(50) DEFAULT NULL,   
  `ano_estreno` year DEFAULT NULL,                 
  `duracion_minutos` int DEFAULT NULL,          
  `descripcion` text,                              
  `director` varchar(100) DEFAULT NULL,            
  `poster_pelicula` mediumtext,                    
  `presupuesto` bigint DEFAULT NULL,           
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (`id_pelicula`)                      
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Volcando datos para la tabla crud_python.tbl_peliculas: ~3 rows (aproximadamente)
INSERT INTO `tbl_peliculas` (titulo_pelicula, categoria_pelicula, ano_estreno, duracion_minutos, descripcion, director, poster_pelicula, presupuesto, fecha_registro)
VALUES 
('Inception', 'Ciencia Ficción', 2010, 148, 'Un ladrón roba secretos a través de los sueños.', 'Christopher Nolan', 'inception.png', 160000000, NOW()),
('Titanic', 'Drama', 1997, 195, 'Una historia de amor en el fatídico viaje del Titanic.', 'James Cameron', 'titanic.png', 200000000, NOW()),
('El Padrino', 'Crimen', 1972, 175, 'Historia de una familia de la mafia italiana.', 'Francis Ford Coppola', 'godfather.png', 6000000, NOW());

-- Volcando estructura para tabla crud_python.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_surname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla crud_python.users: ~2 rows (aproximadamente)
INSERT INTO `users` (`id`, `name_surname`, `email_user`, `pass_user`, `created_user`) VALUES
	(1, 'Urian', 'dev@gmail.com', 'scrypt:32768:8:1$ZXqvqovbXYQZdrAB$66758083429739f4f8985992b22cb89fb58c04b99010858e7fb26f73078a23dd3e16019a17bf881108d582a91a635d2c21d26d80da1612c2d9c9bbb9b06452dc', '2023-07-21 20:10:01'),
	(2, 'demo', 'demo@gmail.com', 'scrypt:32768:8:1$Yl2tGU1Ru1Q4Jrzq$d88a0ded538dcfc3a01c8ebf4ea77700576203f6a7cc765f04627464c6047bdcf8eaad84ca3cf0bb5ed058d2dff8ee7a0ba690803538764bedc3ba6173ac6a8a', '2023-07-21 20:29:28');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
