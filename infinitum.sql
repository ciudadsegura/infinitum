-- MySQL dump 10.13  Distrib 5.7.13, for Linux (x86_64)
--
-- Host: 192.168.1.72    Database: infinitum
-- ------------------------------------------------------
-- Server version	5.7.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sisa_cap`
--
CREATE DATABASE infinitum;

DROP TABLE IF EXISTS `sisa_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sisa_cap` (
  `folio_pisaplex` int(11) NOT NULL,
  `folio_pisa` int(11) DEFAULT NULL,
  `tipo_tarea` varchar(30) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `nombre_del_cliente` varchar(300) DEFAULT NULL,
  `distrito` varchar(45) DEFAULT NULL,
  `fecha_contratacion_recepcion` date DEFAULT NULL,
  `fecha_llegada` date DEFAULT NULL,
  `grupo_de_asignacion` varchar(30) DEFAULT NULL,
  `dilacion` int(11) DEFAULT NULL,
  `expediente` varchar(30) DEFAULT NULL,
  `nombre_del_tecnico` varchar(120) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `calificador` varchar(30) DEFAULT NULL,
  `zona` varchar(30) DEFAULT NULL,
  `fibra_optica` varchar(30) DEFAULT NULL,
  `fibra_opt_tba` varchar(30) DEFAULT NULL,
  `telealimentacion` varchar(30) DEFAULT NULL,
  `direccion_cliente` varchar(300) DEFAULT NULL,
  `cable_par` varchar(70) DEFAULT NULL,
  `posicion_dg` varchar(20) DEFAULT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `clave_recepcion` varchar(20) DEFAULT NULL,
  `atencion` int(11) DEFAULT NULL,
  `valor_cliente` int(11) DEFAULT NULL,
  `mercado` varchar(20) DEFAULT NULL,
  `segmento` varchar(60) DEFAULT NULL,
  `division` varchar(20) DEFAULT NULL,
  `fecha_insercion` datetime DEFAULT NULL,
  `ultima_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`folio_pisaplex`),
  KEY `index2` (`telefono`),
  KEY `index3` (`folio_pisa`),
  KEY `index4` (`fecha_insercion`),
  KEY `index5` (`ultima_actualizacion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `infinitum`.`sisa_cap_BEFORE_INSERT` BEFORE INSERT ON `sisa_cap` FOR EACH ROW
BEGIN
	SELECT fecha_insercion,fecha_insercion INTO @fecha_insercion,@fecha_insercion
    FROM  sisa_cap where folio_pisaplex=new.folio_pisaplex;
    
	if (isnull(@fecha_insercion)) then
		set new.fecha_insercion=(select now());
        set new.ultima_actualizacion=(select now());
	ELSE
		set new.fecha_insercion=@fecha_insercion;
        set new.ultima_actualizacion=(select now());
    end if;
    
    select ems into @ems 
        from sisa_proceso where new.telefono=new.telefono and folio_pisaplex is null 
        order by ems desc limit 1;
        
        if(@ems is not null)then        
			update sisa_proceso set
			folio_pisaplex=new.folio_pisaplex
            where 
			ems=@ems;
        end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `infinitum`.`sisa_cap_BEFORE_UPDATE` BEFORE UPDATE ON `sisa_cap` FOR EACH ROW
BEGIN
	SELECT fecha_insercion,fecha_insercion INTO @fecha_insercion,@fecha_insercion
    FROM  sisa_cap where folio_pisaplex=new.folio_pisaplex;
    
	if (isnull(@fecha_insercion)) then
		set new.fecha_insercion=(select now());
        set new.ultima_actualizacion=(select now());
	ELSE
		set new.fecha_insercion=@fecha_insercion;
        set new.ultima_actualizacion=(select now());
    end if;
    
    select ems into @ems 
        from sisa_proceso where new.telefono=new.telefono and folio_pisaplex is null 
        order by ems desc limit 1;
        
        if(@ems is not null)then        
			update sisa_proceso set
			folio_pisaplex=new.folio_pisaplex
            where 
			ems=@ems;
        end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sisa_complemento`
--

DROP TABLE IF EXISTS `sisa_complemento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sisa_complemento` (
  `ems` int(11) NOT NULL,
  `folio_int` varchar(30) DEFAULT NULL,
  `f_pisa` varchar(50) DEFAULT NULL,
  `cmant` varchar(30) DEFAULT NULL,
  `t_serv` varchar(10) DEFAULT NULL,
  `fase_edo` varchar(10) DEFAULT NULL,
  `empresa` varchar(300) DEFAULT NULL,
  `cuc` varchar(20) DEFAULT NULL,
  `acu_rec` varchar(20) DEFAULT NULL,
  `dir_pta_a` varchar(300) DEFAULT NULL,
  `dir_pta_b` varchar(300) DEFAULT NULL,
  `punta_a` varchar(30) DEFAULT NULL,
  `punta_b` varchar(30) DEFAULT NULL,
  `emp_sit_a` varchar(30) DEFAULT NULL,
  `emp_sit_b` varchar(30) DEFAULT NULL,
  `oqu` varchar(20) DEFAULT NULL,
  `q_p` varchar(5) DEFAULT NULL,
  `ctro_trabajo` varchar(45) DEFAULT NULL,
  `cod_f1` int(11) DEFAULT NULL,
  `desc_f1` varchar(40) DEFAULT NULL,
  `cod_f2` int(11) DEFAULT NULL,
  `desc_f2` varchar(40) DEFAULT NULL,
  `cod_f3` int(11) DEFAULT NULL,
  `desc_f3` varchar(40) DEFAULT NULL,
  `tipo_red` varchar(45) DEFAULT NULL,
  `efa` int(11) DEFAULT NULL,
  `est_efa` varchar(10) DEFAULT NULL,
  `tfa_asig_1er` varchar(120) DEFAULT NULL,
  `tfa_reasig` varchar(120) DEFAULT NULL,
  `ult_niv_esc` varchar(40) DEFAULT NULL,
  `f_ult_esc` varchar(40) DEFAULT NULL,
  `h_ul_esc` varchar(40) DEFAULT NULL,
  `ete_comp1` varchar(20) DEFAULT NULL,
  `act_comp1` varchar(20) DEFAULT NULL,
  `ete_comp2` varchar(20) DEFAULT NULL,
  `act_com2` varchar(20) DEFAULT NULL,
  `ete_comp3` varchar(20) DEFAULT NULL,
  `act_com3` varchar(20) DEFAULT NULL,
  `dilacion_ems` double(12,2) DEFAULT NULL,
  `tel_reporta` varchar(50) DEFAULT NULL,
  `cel_reporta` varchar(50) DEFAULT NULL,
  `email_reporta` varchar(130) DEFAULT NULL,
  `des_ult_esc` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ems`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sisa_principal`
--

DROP TABLE IF EXISTS `sisa_principal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sisa_principal` (
  `ems` int(15) NOT NULL,
  `est_ems` varchar(10) DEFAULT NULL,
  `id` varchar(15) DEFAULT NULL,
  `f_h_ini_ems` datetime DEFAULT NULL,
  `f_h_liq_ems` datetime DEFAULT NULL,
  `f_h_real_liq_ems` datetime DEFAULT NULL,
  `dur_ems` double(12,2) DEFAULT NULL,
  `f_h_ini_efa` datetime DEFAULT NULL,
  `f_h_liq_efa` datetime DEFAULT NULL,
  `dur_efa` double(12,2) DEFAULT NULL,
  `dura_rep` double(12,2) DEFAULT NULL,
  `fecha_recepcion` datetime DEFAULT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  PRIMARY KEY (`ems`),
  KEY `index2` (`est_ems`),
  KEY `index3` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `infinitum`.`sisa_principal_BEFORE_INSERT` 
BEFORE INSERT ON `sisa_principal` FOR EACH ROW
BEGIN
	SELECT fecha_recepcion, fecha_cierre INTO @fecha_recepcion, @fecha_cierre FROM  sisa_principal where ems=new.ems;
	if (isnull(@fecha_recepcion)) then
		set new.fecha_recepcion=(select now());
        
	ELSE
        set new.fecha_recepcion=@fecha_recepcion;
    end if;
    
    if (new.est_ems like('LIQ') and isnull(@fecha_cierre)) then
		set new.fecha_cierre=(select now());
	ELSE
        set new.fecha_cierre=@fecha_cierre;
    end if; 
    
    if not exists (select * from sisa_proceso where ems=new.ems) then
		select folio_pisaplex into @folio_pisaplex 
		from sisa_cap where new.id=telefono order by folio_pisaplex desc limit 1;
		
		if( isnull(@folio_pisaplex)) then
			insert into sisa_proceso set
			ems=new.ems,
			telefono=new.id;
		else
			insert into sisa_proceso set
			folio_pisaplex=@folio_pisaplex,
			ems=new.ems,
			telefono=new.id;
		end if;
    end if;
    
     
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `infinitum`.`sisa_principal_BEFORE_UPDATE` BEFORE update ON `sisa_principal` FOR EACH ROW
BEGIN
SELECT fecha_recepcion, fecha_cierre INTO @fecha_recepcion, @fecha_cierre FROM  sisa_principal where ems=new.ems;
	if (isnull(@fecha_recepcion)) then
		set new.fecha_recepcion=(select now());
        
	ELSE
        set new.fecha_recepcion=@fecha_recepcion;
    end if;
    
    if (new.est_ems like('LIQ') and isnull(@fecha_cierre)) then
		set new.fecha_cierre=(select now());
	ELSE
        set new.fecha_cierre=@fecha_cierre;
    end if; 
    
    if not exists (select * from sisa_proceso where ems=new.ems) then
		select folio_pisaplex into @folio_pisaplex 
		from sisa_cap where new.id=telefono order by folio_pisaplex desc limit 1;
		
		if( isnull(@folio_pisaplex)) then
			insert into sisa_proceso set
			ems=new.ems,
			telefono=new.id;
		else
			insert into sisa_proceso set
			folio_pisaplex=@folio_pisaplex,
			ems=new.ems,
			telefono=new.id;
		end if;
    end if;
    
     
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sisa_proceso`
--

DROP TABLE IF EXISTS `sisa_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sisa_proceso` (
  `ems` int(11) NOT NULL,
  `folio_pisaplex` int(11) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ems`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `tabloide`
--

/*DROP TABLE IF EXISTS `tabloide`;*/
/*!50001 DROP VIEW IF EXISTS `tabloide`*/;
/*SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
*/
/*!50001 CREATE VIEW `tabloide` AS SELECT 
 1 AS `ems`,
 1 AS `est_ems`,
 1 AS `id`,
 1 AS `cmant`,
 1 AS `t_serv`,
 1 AS `empresa`,
 1 AS `dir_pta_a`,
 1 AS `tel_reporta`,
 1 AS `cel_reporta`,
 1 AS `email_reporta`,
 1 AS `desc_f1`,
 1 AS `desc_f2`,
 1 AS `ctro_trabajo`,
 1 AS `division`,
 1 AS `nombre_del_tecnico`,
 1 AS `folio_pisaplex`,
 1 AS `folio_pisa`,
 1 AS `fecha_llegada`,
 1 AS `estado`,
 1 AS `distrito`,
 1 AS `cable_par`,
 1 AS `posicion_dg`*/;
/*SET character_set_client = @saved_cs_client;*/

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `ap_paterno` varchar(45) DEFAULT NULL,
  `ap_materno` varchar(45) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` int(10) DEFAULT NULL,
  `permisos` int(11) DEFAULT NULL,
  PRIMARY KEY (`idusers`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'infinitum'
--

--
-- Dumping routines for database 'infinitum'
--

--
-- Final view structure for view `tabloide`
--

DROP VIEW IF EXISTS `tabloide`;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
CREATE ALGORITHM=UNDEFINED 
DEFINER=`rec1`@`%` SQL SECURITY DEFINER 
VIEW `tabloide` AS select `a`.`ems` AS `ems`,`a`.`est_ems` AS `est_ems`,`a`.`id` AS `id`,`b`.`cmant` AS `cmant`,`b`.`t_serv` AS `t_serv`,`b`.`empresa` AS `empresa`,`b`.`dir_pta_a` AS `dir_pta_a`,`b`.`tel_reporta` AS `tel_reporta`,`b`.`cel_reporta` AS `cel_reporta`,`b`.`email_reporta` AS `email_reporta`,`b`.`desc_f1` AS `desc_f1`,`b`.`desc_f2` AS `desc_f2`,`b`.`ctro_trabajo` AS `ctro_trabajo`,`c`.`division` AS `division`,`c`.`nombre_del_tecnico` AS `nombre_del_tecnico`,`c`.`folio_pisaplex` AS `folio_pisaplex`,`c`.`folio_pisa` AS `folio_pisa`,`c`.`fecha_llegada` AS `fecha_llegada`,`c`.`estado` AS `estado`,`c`.`distrito` AS `distrito`,`c`.`cable_par` AS `cable_par`,`c`.`posicion_dg` AS `posicion_dg` from (((`sisa_proceso` `aa` join `sisa_principal` `a` on((`aa`.`ems` = `a`.`ems`))) join `sisa_complemento` `b` on((`a`.`ems` = `b`.`ems`))) left join `sisa_cap` `c` on((`aa`.`folio_pisaplex` = `c`.`folio_pisaplex`))) ;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-14  9:55:05
