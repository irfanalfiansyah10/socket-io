# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: halokes.co.id (MySQL 5.5.5-10.1.44-MariaDB-0+deb9u1)
# Database: admin_dev_demo
# Generation Time: 2020-03-31 04:51:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table tbl_chat_conversation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_chat_conversation`;

CREATE TABLE `tbl_chat_conversation` (
  `id_conversation` varchar(50) NOT NULL,
  `from_user_id_url` varchar(20) NOT NULL,
  `to_user_id_url` varchar(20) NOT NULL,
  `conversation` text NOT NULL,
  `send_at` double DEFAULT NULL,
  `received_by_server_at` double DEFAULT NULL,
  `sent_at` double DEFAULT NULL,
  `read_at` double DEFAULT NULL,
  `deleted_at` double DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0 = send, 1 = received by server, 2 = sent to target, 3 = read, -1 = deleted',
  PRIMARY KEY (`id_conversation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tbl_chat_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_chat_user`;

CREATE TABLE `tbl_chat_user` (
  `id_user_url` varchar(20) NOT NULL,
  `socket_id` varchar(30) NOT NULL,
  `last_logout` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_login` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_user_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tbl_master_guru
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_master_guru`;

CREATE TABLE `tbl_master_guru` (
  `id_guru` int(11) NOT NULL AUTO_INCREMENT,
  `id_guru_url` varchar(10) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `guru_nama` varchar(50) DEFAULT NULL,
  `guru_nip` varchar(20) DEFAULT NULL,
  `guru_nign` varchar(30) DEFAULT NULL,
  `guru_gelar_depan` varchar(20) DEFAULT NULL,
  `guru_gelar_belakang` varchar(20) DEFAULT NULL,
  `guru_tgl_lahir` date DEFAULT NULL,
  `guru_tempat_lahir` varchar(30) DEFAULT NULL,
  `guru_jkel` char(2) DEFAULT NULL,
  `guru_alamat` longtext,
  `guru_no_hp` varchar(20) DEFAULT NULL,
  `guru_agama` varchar(10) DEFAULT NULL,
  `guru_status_peg` int(11) DEFAULT NULL,
  `guru_jenis_ptk` int(11) DEFAULT NULL,
  `guru_jenjang` int(11) DEFAULT NULL,
  `guru_jurusan` varchar(100) DEFAULT NULL,
  `guru_sertifikasi` varchar(100) DEFAULT NULL,
  `tmt_kerja` date DEFAULT NULL,
  `guru_tugas_tbh` varchar(50) DEFAULT NULL,
  `jtt` int(11) DEFAULT NULL,
  `jjm` int(11) DEFAULT NULL,
  `total_jjm` int(11) DEFAULT NULL,
  `guru_kompetensi` varchar(100) DEFAULT NULL,
  `guru_status` varchar(10) DEFAULT NULL,
  `guru_foto` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_guru`) USING BTREE,
  KEY `guru_ke_user` (`id_user`) USING BTREE,
  CONSTRAINT `guru_ke_user` FOREIGN KEY (`id_user`) REFERENCES `tbl_sys_users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

LOCK TABLES `tbl_master_guru` WRITE;
/*!40000 ALTER TABLE `tbl_master_guru` DISABLE KEYS */;

INSERT INTO `tbl_master_guru` (`id_guru`, `id_guru_url`, `id_user`, `guru_nama`, `guru_nip`, `guru_nign`, `guru_gelar_depan`, `guru_gelar_belakang`, `guru_tgl_lahir`, `guru_tempat_lahir`, `guru_jkel`, `guru_alamat`, `guru_no_hp`, `guru_agama`, `guru_status_peg`, `guru_jenis_ptk`, `guru_jenjang`, `guru_jurusan`, `guru_sertifikasi`, `tmt_kerja`, `guru_tugas_tbh`, `jtt`, `jjm`, `total_jjm`, `guru_kompetensi`, `guru_status`, `guru_foto`, `created_at`, `modified_at`, `status`)
VALUES
	(1,'gevua5VLQS',8,'Priyadi Suprapto','010010',NULL,NULL,'S.Pd','1980-01-01','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:34:20',NULL,1),
	(2,'I0DfwXp2sz',9,'Darussalam','010011',NULL,NULL,'S.Pd','1981-08-07','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:39:07',NULL,1),
	(3,'lIL6nwHgMU',10,'Syahroni','010012',NULL,'Drs. H.',NULL,'1980-07-03','Lumajang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:41:03',NULL,1),
	(4,'o1Jx0LuD9t',11,'Bambang Syaifudin','010013',NULL,NULL,'S.Ag','1976-09-02','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,'2019-07-13 16:44:15',NULL,1),
	(5,'10Qwt4RMZf',12,'Siti Marzuqoh','010014',NULL,NULL,'S.Pd','1980-09-10','Probolinggo','P','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:51:14',NULL,1),
	(6,'MlP6nN1eVJ',13,'Burhanudin','010015',NULL,NULL,'S.Pd','1988-08-23','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:55:23',NULL,1),
	(7,'TMkoA2hnUY',14,'Takhril','010016',NULL,'Drs. H.',NULL,'1970-12-12','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:56:16',NULL,1),
	(8,'kop6vqZQCJ',15,'Muhammad Sahdi Rosidi','010017',NULL,NULL,'S.Pd','1981-09-09','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 16:57:12',NULL,1),
	(9,'z5o9CYjuc0',16,'Kamali','010018',NULL,'Drs.',NULL,'1980-01-01','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,'2019-07-13 17:16:02',NULL,1),
	(10,'1EVqAx2FHi',17,'Sudalmanto','010019',NULL,NULL,'S.Pd.Si','1976-09-05','Banyuwangi','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 17:17:06',NULL,1),
	(11,'YIi30zKbVT',18,'Sri Suprihati','010020',NULL,'Dra. Hj.',NULL,'1960-01-09','Malang','P','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:15:51',NULL,1),
	(12,'RrozmbMEOu',19,'Lies Erning R','010021',NULL,'Dra. Hj.',NULL,'1965-08-30','Yogyakarta','P','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:16:44',NULL,1),
	(13,'HE3oMkYtL9',20,'Kasmaboti','010022',NULL,NULL,'S.Ag','1985-12-01','Madiun','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:19:21',NULL,1),
	(14,'Bz69pAd14E',21,'Dedeh Kurniasih','010023',NULL,NULL,'S.E','1981-02-02','Malang','P','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:20:09',NULL,1),
	(15,'e5oAxNlKjY',22,'Diding Tajuddin','010024',NULL,'Drs.',NULL,'1976-01-30','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:21:28',NULL,1),
	(16,'YEI8bKXajS',23,'Iden Sujana','010025',NULL,'Drs.',NULL,'1977-07-31','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 21:22:29',NULL,1),
	(17,'MW2jTQ0IKG',24,'Ahmad Faridi','010026',NULL,NULL,'S.Pd','1980-08-08','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:16:49',NULL,1),
	(18,'OsjMeAWD3S',25,'Diki Hernandi','010027',NULL,NULL,'S.Pd','1979-06-30','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:17:39',NULL,1),
	(19,'pmrMcEJ5Wy',26,'Muhammad Hatta','010028',NULL,NULL,'S.Pd','1984-12-15','Surabaya','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:18:45',NULL,1),
	(20,'5PXaSyI0JM',27,'Agus Singgih','010029',NULL,NULL,'S.Sn','1987-02-28','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:20:32',NULL,1),
	(21,'4HMiJCDtUq',28,'Testiwati','010030',NULL,NULL,'S.Ag','1976-08-09','Lumajang','P','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:21:21',NULL,1),
	(22,'QOYRCxA8Se',29,'M. Arifin','010031',NULL,NULL,'S.Pd','1988-08-08','Malang','L','Malang',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:22:06',NULL,1),
	(23,'vhRiLAytb1',30,'Dwi Astuti','010032','','','S.Pd','1980-11-23','Malang','P','Malang','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:33:02',NULL,1),
	(24,'C8OTGgLhyQ',1,'Fitriani','010033','','','S.Pd','1985-04-23','Malang','P','Malang','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:33:54',NULL,1),
	(25,'ZPX0tRu57s',31,'Fauziah','010034','','','S.Pd','1985-02-19','Pasuruan','P','Malang','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:34:39',NULL,1),
	(26,'SRzCQ24rPt',32,'Suhaemi Haryani','010035','','','S.Pd','1980-02-03','Malang','P','Malang','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:35:26',NULL,1),
	(27,'P0lYwHaKxM',33,'Teguh Prasetyo','010036',NULL,NULL,NULL,'1986-10-28','Pasuruan','L','Malang',NULL,'islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-07-13 22:36:01','2019-12-29 19:37:37',1),
	(28,'y7aeft248n',34,'Fajar Rachmadyan Putra','010037','','','S.Pd','1991-08-19','Malang','L','Malang','','islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2019-12-29 19:18:23','2019-12-29 19:21:24',0),
	(29,'TuBCZSs2Iv',35,'Tanto Qustantowi','010038','338774064120','H.','M.Pd.','1962-10-25','Majalengka','L','','','Islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 13:51:33',NULL,1),
	(30,'jV9LIoFS8r',36,'Agus Parulian Sinaga','010039','196512719890','','M.Pd','1965-11-27','Ciamis','L','','','Kristen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 13:56:24',NULL,1),
	(31,'lkzAFLVGJ8',37,'Sujana','010040','903574364320','','S.Pd','1965-07-03','Majalengka','L','','','Islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 13:58:22',NULL,1),
	(32,'YlLi6TjbPu',38,'Aruman','010041','333774064320','','A.md','1962-10-05','Majalengka','L','','','Islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 13:59:02',NULL,1),
	(33,'AJrHcYUpPI',39,'Aan Janah','010042','305374264330','','A.md','1979-07-11','Majalengka','P','','','Islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 13:59:55',NULL,1),
	(34,'L5xbB9y6OX',40,'Udin Tajudin','010043','196073063320','Ir.','','1952-02-28','Majalengka','L','','','Islam',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,'2020-01-07 14:01:31',NULL,1);

/*!40000 ALTER TABLE `tbl_master_guru` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tbl_master_siswa
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_master_siswa`;

CREATE TABLE `tbl_master_siswa` (
  `id_siswa` int(11) NOT NULL AUTO_INCREMENT,
  `id_siswa_url` varchar(20) DEFAULT NULL,
  `id_tapel` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `siswa_nama` varchar(50) DEFAULT NULL,
  `siswa_nisn` varchar(30) DEFAULT NULL,
  `siswa_nis` varchar(30) DEFAULT NULL,
  `siswa_tgl_lahir` date DEFAULT NULL,
  `siswa_tempat_lahir` varchar(30) DEFAULT NULL,
  `siswa_jkel` char(2) DEFAULT NULL,
  `siswa_alamat` longtext,
  `siswa_no_hp` varchar(20) DEFAULT NULL,
  `siswa_email` varchar(100) DEFAULT NULL,
  `siswa_agama` varchar(10) DEFAULT NULL,
  `siswa_status` int(11) DEFAULT NULL,
  `siswa_foto` varchar(150) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_siswa`) USING BTREE,
  KEY `fk_tapel_ke_siswa` (`id_tapel`) USING BTREE,
  KEY `siswa_ke_user` (`id_user`) USING BTREE,
  CONSTRAINT `fk_tapel_ke_siswa` FOREIGN KEY (`id_tapel`) REFERENCES `tbl_sys_tapel` (`id_tapel`),
  CONSTRAINT `siswa_ke_user` FOREIGN KEY (`id_user`) REFERENCES `tbl_sys_users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

LOCK TABLES `tbl_master_siswa` WRITE;
/*!40000 ALTER TABLE `tbl_master_siswa` DISABLE KEYS */;

INSERT INTO `tbl_master_siswa` (`id_siswa`, `id_siswa_url`, `id_tapel`, `id_user`, `siswa_nama`, `siswa_nisn`, `siswa_nis`, `siswa_tgl_lahir`, `siswa_tempat_lahir`, `siswa_jkel`, `siswa_alamat`, `siswa_no_hp`, `siswa_email`, `siswa_agama`, `siswa_status`, `siswa_foto`, `created_at`, `modified_at`, `status`)
VALUES
	(1,'TBOuGhQHUxMjfrqJ19Vd',1,2,'Raham Sutan Iliyas','3818066514','1019-234-4','1998-12-05','Malang','P','Malang','089650691537','hanifahhputri2@gmail.com','islam',1,'8a8cc772dccf6e7c64bc202b3ed9f3cf.jpg','2019-09-09 13:17:45','2019-12-11 11:57:38',1),
	(2,'A3mif4yTdX5buZKlChsY',1,NULL,'Muhammad Reza Fachle','3818066515','1019-234-5','1998-02-28','Malang','L','Surabaya','088988726133','yohanesdwilistio@gmail.com','islam',1,NULL,'2019-09-09 13:18:52',NULL,1),
	(3,'uoI7YAdtT1sy4EpKSL5P',1,NULL,'Dedi Wansah Solin','3818066516','1019-234-6','1998-11-02','Malang','L','Sidoarjo','087788273191','user2@halokes.co.id','islam',1,NULL,'2019-09-12 13:35:16',NULL,1),
	(4,'B9sMZyqrbkDhXPtY6T8U',1,NULL,'Teuku Shahibul Auzar','3818066517','1019-234-7','1997-03-14','Aceh Besar','L','Lamongan','081599482811','user3@halokes.co.id','islam',1,NULL,'2019-09-12 13:37:05',NULL,1),
	(5,'kbKwINXHBidOSUATyaun',1,NULL,'Fachri Al Achmed','3818066518','1019-234-8','1998-06-01','Malang','L','Yogyakarta','0895663718912','user4@halokes.co.id','islam',1,NULL,'2019-09-12 13:37:55',NULL,1),
	(6,'Tx7Vs5vFJuwoOhXILeE6',1,NULL,'Novi Mulia Sari','3818066519','1019-234-9','1998-06-27','Malang','P','Kediri','089675837172','user5@halokes.co.id','islam',1,NULL,'2019-09-12 13:39:12',NULL,1),
	(7,'mHYD0fsqZprnaUVtoFgJ',1,NULL,'Akbar Tri Wicaksono','3818066520','1019-235-0','1998-01-18','Malang','L',NULL,NULL,'akbar3wicaksono@gmail.com',NULL,1,NULL,'2019-09-12 13:42:01',NULL,1),
	(8,'jsDmBGJoMIhUQ84fkp0x',1,NULL,'Radinal Suryadinata','3818066521','1019-235-1','1998-03-03','Blitar','L',NULL,NULL,'dinaldinata@gmail.com',NULL,1,NULL,'2019-09-12 13:42:35',NULL,1),
	(9,'X4SVFGbKizJdjET7NB3O',1,NULL,'Bambang Edi Syahputra','3818066522','1019-235-2','1998-09-11','Malang','L',NULL,NULL,'ediputrabang@gmail.com',NULL,1,NULL,'2019-09-12 13:43:11',NULL,1),
	(10,'a89IZP2wMzjyHtx6oR3F',1,NULL,'Muhammad Rizal Khada','3818066524','1019-235-4','1998-10-20','Malang','L',NULL,NULL,'rizalkhada@gmail.com',NULL,1,NULL,'2019-09-12 13:51:14',NULL,1),
	(11,'fQVzdnNgLK7yrCvRbSYq',1,NULL,'Maulana Muslim Harahap','3818066525','1019-235-5','1998-04-05','Malang','L',NULL,NULL,'muslimhrp@gmail.com',NULL,1,NULL,'2019-09-12 13:53:18',NULL,1),
	(12,'tCxYr83Zv6B9biHmpdSR',1,NULL,'Cut Novia Indrayana','3818066526','1019-235-6','1998-04-12','Sabang','P',NULL,NULL,'noviayana@gmail.com',NULL,1,NULL,'2019-09-12 13:54:23',NULL,1),
	(13,'cqeVth09Hoa74DYSWTXn',1,NULL,'Fitratansyah Nashara','3818066528','1019-235-8','1998-05-12','Malang','P',NULL,NULL,'nasharap@gmail.com',NULL,1,NULL,'2019-09-12 14:11:42',NULL,1),
	(14,'8UisvrVYGSmFegdR5z4k',1,NULL,'Resa Yulia Citra','3818066529','1019-235-9','1998-07-09','Malang','P',NULL,NULL,'yuliacitra@gmail.com',NULL,1,NULL,'2019-09-12 14:12:17',NULL,1),
	(15,'vZTm69GLWIsfkrbuYUNF',1,NULL,'Angga Aziz Firmansyah','3818066530','1019-236-0','1998-09-13','Malang','L',NULL,NULL,'pirmanajis@gmail.com',NULL,1,NULL,'2019-09-12 14:21:25',NULL,1),
	(16,'3Bl1J7VhmTdIv0qMRtcQ',1,NULL,'Novia Ledrya','3818066531','1019-236-1','1998-10-19','Malang','P',NULL,NULL,'novialedrya@gmail.com',NULL,1,NULL,'2019-09-12 14:27:45',NULL,1),
	(17,'LXYDx7lUGMtkVSTKHzRN',1,NULL,'Resi Karnila','3818066532','1019-236-2','1998-12-26','Malang','P',NULL,NULL,'resikarnila@gmail.com',NULL,1,NULL,'2019-09-12 14:35:13',NULL,1),
	(18,'NAvpX417tEgyOxUhJQn9',1,NULL,'Ika Rahmita Sari','3818066533','1019-236-3','1998-03-24','Malang','P',NULL,NULL,'ikarahmita@gmail.com',NULL,1,NULL,'2019-09-12 14:39:03',NULL,1),
	(19,'wvUoVpkzx9g8301SutIj',1,NULL,'Raja Pradonli Prawirya','3818066534','1019-236-4','1998-05-12','Malang','L',NULL,NULL,'pradonliwirya@gmail.com',NULL,1,NULL,'2019-09-12 14:39:47',NULL,1),
	(20,'lbZA6JqeF9N83K2rHyWS',1,NULL,'Forkhan Hartono','3818066535','1019-236-5','1998-08-11','Malang','L',NULL,NULL,'khantono@gmail.com',NULL,1,NULL,'2019-09-12 14:40:20',NULL,1),
	(21,'mR731FkCGVrXDcdhY9SP',1,NULL,'Ayu Hastuti Dewi','3818066536','1019-236-6','1998-05-18','Malang','P',NULL,NULL,'yutiwi231@gmail.com',NULL,1,NULL,'2019-09-12 14:40:59',NULL,1),
	(22,'p8cdaIWFX1AGJSqfHTno',1,NULL,'David Laksamana','3818066537','1019-236-7','1997-02-03','Tulungagung','L',NULL,NULL,'davidmanaa@gmail.com',NULL,1,NULL,'2019-09-12 14:51:22',NULL,1),
	(23,'1m94wD6gK7hviOrYsuHa',1,NULL,'Davis Vickry Supriadi','3818066538','1019-236-8','1997-10-02','Malang','L',NULL,NULL,'vickryadi21@gmail.com',NULL,1,NULL,'2019-09-12 14:52:35',NULL,1),
	(24,'SrG1DaluvYeIwEWo8Mg5',1,NULL,'Teuku Ismul Hadi','3818066539','1019-236-9','1998-10-02','Aceh Besar','L',NULL,NULL,'ismulteuku99@gmail.com',NULL,1,NULL,'2019-09-12 14:53:26',NULL,1),
	(25,'cTGoL1p5tJyxFZbk673I',1,NULL,'Viche Ayu Viralisti','3818066540','1019-237-0','1998-08-07','Malang','P',NULL,NULL,'vicheayuu27@gmail.com',NULL,1,NULL,'2019-09-12 14:54:13',NULL,1),
	(27,'g0gWPZ1vshGWicuwQK7m',1,NULL,'Muhammad Bima Indra Kusuma','3818066541',NULL,'1998-07-04','Malang','L','Jl. Wijaya Barat 108 RT 03 RW 03, Pagentan, Singosari','089650691537','bimaindra444@gmail.com','islam',0,NULL,'2019-09-22 22:16:42',NULL,1),
	(28,'IYcbgei4OQPGH8pvsNEz',1,NULL,'Yohanes Dwi Listio','3818066542','1019-237-1','1997-05-09','Malang','L','Jl. Kelapa Sawit 122 A, RT 10 RW 03, Pisangcandi, Sukun','082234221832','yohanesdl9@gmail.com','Kristen',1,NULL,'2019-12-18 16:26:42',NULL,1),
	(29,'zXQZdfk3bSNIKW6B4ua8',1,NULL,'Rafi Pratama Adji','3818066543','1019-237-2','1997-02-13','Trenggalek','L','Jl. Gambuta III-H11, Karangbesuki, Sukun','081808586861','rafiadji13@gmail.com','Islam',1,NULL,'2019-12-18 16:26:42',NULL,1),
	(30,'L1OXJ0DRYSV4pdxPwnAq',1,NULL,'Margaretha Cindy Olivia','3818066544','1019-237-3','1997-09-23','Malang','P',NULL,'081233903300','margarethacindy97@gmail.com','Katolik',1,NULL,'2019-12-18 16:26:43',NULL,1),
	(31,'Hu89XzWDnfUswKFeaVCq',1,NULL,'Amy Kartika Sari','3818066545','1019-237-4','1996-09-07','Malang','P','Jl. Whisnuwardhana, Sekarpuro, Pakis','081331757924','amykartika96@gmail.com','Islam',1,NULL,'2019-12-18 16:26:43',NULL,1),
	(32,'MWLDtadruGpAQOokExzH',1,NULL,'Baiq Farida Nolawangi','3818066546','1019-237-5','1996-11-14','Mataram','P','Jl. Candi III no. 309, Karangbesuki, Sukun','082340641828','faridanolawangi@gmail.com','Islam',1,NULL,'2019-12-18 16:26:43','2020-01-02 10:50:47',1),
	(33,'fyBJbuOavzwqD92hVxUo',1,NULL,'Arizki Redita','3818066547','1019-237-6','1997-04-26','Malang','P','Perum Randuagung J7 Jl. Rajawali VI-18 Singosari','081230072321','arizkiredita9770@gmail.com','Islam',1,NULL,'2019-12-18 16:26:44','2020-01-02 10:50:47',1),
	(34,'hIXKjU0yCHZ7NneBRzkx',1,NULL,'Maulidta Yuli Pratiwi','3818066548','1019-237-7','1996-07-25','Malang','P',NULL,'082264058208','maulidta_lita@gmail.com','Islam',1,NULL,'2019-12-18 16:26:44',NULL,1),
	(35,'oeiygtC9HfjAmPZauWQ3',1,NULL,'Danni Nur Cahyani','3818066549','1019-237-8','1997-02-24','Malang','P',NULL,'082233672141','danninurcahyani@gmail.com','Islam',3,NULL,'2019-12-18 16:26:44','2020-01-02 10:25:22',1),
	(36,'KtgY1vs2QWl9kGh8IuwT',1,NULL,'Vina Dwi Elviani','3818066550','1019-237-9','1996-12-31','Malang','P','Jl. Perusahaan Raya, Bodosari, Tanjungtirto, Singosari','083113184502','vinaelvia@gmail.com','Islam',1,NULL,'2019-12-18 16:26:45',NULL,1),
	(37,'IcpQN3wytzEb8GR0ViD5',NULL,NULL,'Victoria Luna Terang Lotussa','3818066551',NULL,'1999-04-12','Batu','P','Jl. Mulyoagung 12 Dau, Malang','087788391128','lunalotussa@gmail.com','Katolik',0,NULL,'2019-12-23 06:18:17',NULL,1),
	(38,'n7HkblwYA9jZT0FqCyrc',1,NULL,'Ashlih Qurota A\'yuni','3818066552','1019-238-1','1997-06-05','Banyuwangi','P','Jl. Candi IV no. 339 Malang','089848271213','ashlihlana@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(39,'BGTobw9UJialgR4Vs7nD',1,NULL,'Melanaumi Apriza Fahira Sa\'i','3818066553','1019-238-2','2000-03-08','Malang','P','Jl. Wukir Temas, Batu, Malang','085852086332','melanaumi@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(40,'Q4lOkFfJIUB8563Dy1zK',1,NULL,'Weni Tri Setya','3818066554','1019-238-3','1998-07-03','Malang','P','Jl. Candi III No. 311 Malang','08887373481','wenitrisetya@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(41,'dF3J0RLIY1WGz5Ko6yke',1,NULL,'Mohammad Andy Sampurno','3818066555','1019-238-4','1999-05-04','Malang','L','Jl. Balearjosari Gg. Payaman Malang','087877647263','andywhite@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(42,'hQF32ugaGYboCPrIlpcx',1,NULL,'Panji Iman Baskoro','3818066556','1019-238-5','1995-03-04','Malang','L','Jl. Akordion No. 77 Malang','089566473822','panjidia95@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(43,'aulgNtVUXi18bCqWkyDj',1,NULL,'Eka Mei Ayu Widyati Prastyo','3818066557','1019-238-6','2001-08-29','Malang','P','Jl. Candi V No. 344 Malang','085877629319','eka.mei@gmail.com','Islam',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(44,'eEnAatRNj0fO3XuFdPmT',1,NULL,'Gracia Steffy Angela Masterin','3818066558','1019-238-7','1998-08-24','Batu','P','Jl. R.A. Dewi Sartika No. 14 Batu','087785738281','grac.steffy@gmail.com','Katolik',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(45,'RxXalz9poM4Y7hOP5ten',1,NULL,'Amanda Dorothys','3818066559','1019-238-8','2001-01-19','Malang','P','Villa Bukit Tidar B-9 Malang','089677583921','amanda_1901@gmail.com','Katolik',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(46,'hPdcFlrgNXJs7wHV605C',1,NULL,'Christopher Jason','3818066560','1019-238-9','2005-03-19','Malang','L','Perumahan Araya JJ-4 Malang','081394857712','christopher.json@gmail.com','Kristen',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(47,'xCGurAcXZE7N8tS5Tw0M',1,NULL,'Andrea Amanda','3818066561','1019-239-0','2000-04-23','Malang','P','Perumahan Araya JJ-3 Malang','082364157274','andrea.ea@gmail.com','Katolik',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(48,'ZGvUWeIHjnoTOm8pk4gV',1,NULL,'Panny Gesagie Thessalonica','3818066562','1019-239-1','2004-01-20','Palangkaraya','P','Jl. Telomoyo No. 1A Malang','085674929182','pannygsieca@gmail.com','Kristen',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(49,'JMarxgdbABLt41Z9CTP8',1,NULL,'Panna Gesagie Thessalonica','3818066563','1019-239-2','2004-01-20','Palangkaraya','P','Jl. Telomoyo No. 1A Malang','085673881819','pannagsgie@gmail.com','Kristen',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(50,'6Ye4pJBVgWsK8I3cjOu0',1,NULL,'Yohanes Adi Setiawan','3818066564','1019-239-3','2000-12-14','Malang','L','Jl. Mondoroko Raya No. 37 Singosari, Malang','088774628191','yohanesadis@gmail.com','Kristen',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(51,'Qnh1oRBTwl9yaIWUkiHp',1,NULL,'Yosef Moscati Kresna Chrisnadi','3818066565','1019-239-4','1998-04-30','Malang','L','Jl. Manyar No. 49 Malang','085877262919','yosefkresna@gmail.com','Katolik',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(52,'iLgyTjC5bdJUFtPG4snQ',1,NULL,'Michelle Cindy Lay','3818066566','1019-239-5','2005-10-30','Kupang','P','Jl. Telomoyo No. 1A Malang','088764928283','michellelay30@gmail.com','Kristen',1,NULL,'2020-01-07 05:13:17',NULL,1),
	(53,'GDE3XNZ1c0loeTjsitqk',1,NULL,'Ricky Subagio','3818066567','1019-239-6','2002-04-09','Malang','L','Jl. Elang No. 14 Malang','085752604277','ricky_58@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(54,'FjnOoyaflvugU6PXdT9V',1,NULL,'Tius Chandra Permana','3818066568','1019-239-7','2002-10-15','Malang','L','Jl. Kelapa Sawit No. 36 Malang','087519635186','tiuscp10@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(55,'HQpc65otnTxXwZGsryMY',1,NULL,'Alexander Hendry S.S.','3818066569','1019-239-8','2002-01-19','Malang','L','Perum Duta Randuagung Jl. Garuda V No. 14','085830937170','alexander.hss@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(56,'29KTbGcRZNezgjkC7JLm',1,NULL,'Agnes Kartika Putri','3818066570','1019-239-9','2002-08-22','Malang','P','Gempol Marga Bhakti Gg. III No. 4 Malang','083153582884','agneskp22@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(57,'s9AauYoy6HDvl47zSmbh',1,NULL,'Triyas Putri Angela','3818066571','1019-240-0','2004-09-03','Malang','P','Jl. Telomoyo No. 1A Malang','087505492177','triyasputriangela@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(58,'2r3F5scynS4WPHa6XtDU',1,NULL,'Michelle Patricia','3818066572','1019-240-1','2004-03-20','Kupang','P','Jl. Telomoyo No. 1A Malang','083222503817','chellepatricia@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(59,'kLsHDoZd94YBEJAhCWXm',1,NULL,'Delfine Brigitta A.','3818066573','1019-240-2','2004-04-25','Kupang','P','Jl. Telomoyo No. 1A Malang','081931989313','delfine@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(60,'sRCqL6heUnSaWTDBIPAl',1,NULL,'Elia Listyawan','3818066574','1019-240-3','2002-11-10','Malang','L','Jl. Perusahaan Raya No.33 Singosari Malang','081123874762','e.listyawan@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(61,'if5ljdUQSMa3h4vWBTLC',1,NULL,'Elsa Marianne','3818066575','1019-240-4','2004-07-12','Kupang','P','Jl. Telomoyo No. 1A Malang','083896834535','elsa.marianne@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(62,'PjaNERO83SzGtiXewVlx',1,NULL,'Febian Dwika','3818066576','1019-240-5','2004-06-24','Malang','L','Sukun Pondok Indah C-12 Malang','087707622996','febiandwika@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(63,'xQRh1dT2FOgZosn5I0al',1,NULL,'Febriana Andini','3818066577','1019-240-6','2000-02-22','Malang','P','Villa Bukit Tidar B-29 Malang','082147592825','feina_22@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(64,'g7b0o2WXLTrJHImu1EjQ',1,NULL,'Fransiska Indriati','3818066578','1019-240-7','2000-04-20','Malang','P','Jl. Mayjend Sungkono No. 144 Malang','081547007328','frain_hunter@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(65,'DLb01htSw9zjx4raiTsG',1,NULL,'Jessica Stephanie','3818066579','1019-240-8','2002-06-28','Malang','P','Jl. Telomoyo No. 1A Malang','088983835345','jso@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(66,'NPUg0zh1R6KwLQJv7Gpt',1,NULL,'Kristian Joe','3818066580','1019-240-9','2002-06-05','Malang','L','Jl. Karya Timur Gg. II No. 18 Malang','088971493458','joekristian@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(67,'ae8DW2U7RiwZJOAcHzNu',1,NULL,'Monica Angelina','3818066581','1019-241-0','2002-07-11','Samarinda','P','Jl. Kedondong No. 15 Malang','088827851840','monicangelina@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(68,'IDdR3cMnKWQwXkbytaVg',1,NULL,'Nevia Melitsa','3818066582','1019-241-1','2004-02-28','Malang','P','Jl. Kedondong No. 15 Malang','085623985516','nevia_maingak@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(69,'6BdKPyVxRcOkYq2mLf8H',1,NULL,'Gabriella Marble Tan','3818066583','1019-241-2','2003-03-21','Malang','P','Jl. Betet No. 15 Malang','087735523161','marbleeee@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(70,'neWvFOBjp6hmIJEX9LbM',1,NULL,'Tasya da Costa','3818066584','1019-241-3','2004-01-29','Kupang','P','Jl. Telomoyo No. 1A Malang','083858516398','tasyadacosta@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(71,'UQnKf5GsFXEl64zTh2d7',1,NULL,'Jennifer Alinanda de Mayu Neves','3818066585','1019-241-4','2002-04-21','Dili','P','Jl. Mandalika No. 24 Malang','088913790042','jennev15@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(72,'r9QcvqF6nSfzRNplEPmM',1,NULL,'Vito Timotius Yuwanda','3818066586','1019-241-5','2004-07-02','Malang','L','Jl. Moch. Gatot Soebroto No. 21 Kendalpayak','089521639787','vitoty@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(73,'Zc1yI9iXBkaT3FluKpVs',1,NULL,'Zevanya Christania','3818066587','1019-241-6','2001-08-04','Malang','P','Jl. Candi III No. 240 Malang','081659634824','vanyachristania@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(74,'DmKdP42LWIhqbvpeNX93',1,NULL,'Niken Savitri','3818066588','1019-241-7','2004-07-10','Mataram','P','Jl. S. Supriadi No. 46 Malang','082330339340','nikensavitri@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(75,'SnNMDwp2Utg371mZLCuF',1,NULL,'Rani Wongso','3818066589','1019-241-8','2003-03-16','Kupang','P','Jl. Telomoyo No. 1A Malang','085353679507','raniwongso@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(76,'0MeCVvdlk6x7iKS2ZWfX',1,NULL,'Rendy Cornelius','3818066590','1019-241-9','2002-12-08','Malang','L','Gempol Marga Bhakti Gg. III No. 12 Malang','088857691670','rendycornel@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(77,'8AVt0larxcpGj21qUNu9',1,NULL,'Reyna Clarissa','3818066591','1019-242-0','2004-09-30','Makassar','P','Jl. Telomoyo No. 1A Malang','082187787666','reyclarissa@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(78,'KNa07InUHsjX81CmRitr',1,NULL,'Yohanes Ronald Herry','3818066592','1019-242-1','2002-11-14','Lamongan','L','Perumahan Bukit Dieng C-3 Malang','082200003167','ronald_herry@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(79,'Fbl4RuJ70dpP16cTZXgo',1,NULL,'Stanley Marcelino','3818066593','1019-242-2','2004-05-09','Surabaya','L','Jl. Kawi Atas No. 4 Malang','082270573404','stanmarcel@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(80,'iZFtsa8QJuXGnIdDxphm',1,NULL,'Suzan Mega Virginia Tjahjono','3818066594','1019-242-3','2000-08-24','Malang','P','Jl. Menuwo No. 14 Malang','083831829713','angelia_suzan24@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(81,'eRagAjH7mkpIMCON6S52',1,NULL,'Theana Regina L.','3818066595','1019-242-4','2004-01-10','Malang','P','Jl. Telomoyo No. 1A Malang','089673671346','thearegina@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(82,'VrL2Sial9e1q8UKcXjwG',1,NULL,'Vincentius Devyn','3818066596','1019-242-5','2004-05-08','Manokwari','L','Jl. Pandan No. 6 Malang','087723060119','vincent_devyn@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(83,'TDuQrb4WRPUvh8LG60Jk',1,NULL,'Yoda Karunia','3818066597','1019-242-6','2002-04-05','Malang','L','Jl. Dieng Atas No. 27 Malang','082388455773','yodagapapa@gmail.com','Katolik',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(84,'r2481bU7CEvqPgswKhdx',1,NULL,'Tasya Eka','3818066598','1019-242-7','2004-03-12','Malang','P','Jl. Telomoyo No. 1A Malang','087899481172','tasyaeka@gmail.com','Kristen',1,NULL,'2020-01-23 09:10:46',NULL,1),
	(85,'0KL5FT6WeRco74hnXPqu',1,NULL,'Thomas Kristanto Wijaya','3818066599','1019-242-8','1999-12-31','Malang','L',NULL,NULL,'thomaskristantow@gmail.com','Kristen',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(86,'ewkyPomq5sTCiuEFcN4A',1,NULL,'Teofilus Jodi Saputra','3818066600','1019-242-9','1999-12-14','Malang','L',NULL,NULL,'teofilusjodi@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(87,'1r8ajbF7tnINSJfQUL6w',1,NULL,'Supianur','3818066601','1019-243-0','1999-08-30','Malang','L',NULL,NULL,'pian_samli@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(88,'IwE3aQtrxqivG9cldK01',1,NULL,'Stefanus Salem','3818066602','1019-243-1','1999-05-24','Malang','L',NULL,NULL,'salem.stef@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(89,'1nm4skDq0eNoGa7JCjEL',1,NULL,'Shania Saraswati','3818066603','1019-243-2','1999-05-05','Malang','P',NULL,NULL,'shansaraswati@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(90,'pqxlF7goja6ISvyBeYtd',1,NULL,'Fransiskus Handika Putra','3818066604','1019-243-3','1999-03-12','Surabaya','L',NULL,NULL,'franshandika@gmail.com','Kristen',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(91,'TzxIjd0s8mZpeKnHNLiE',1,NULL,'M. Bagus Setiawan','3818066605','1019-243-4','1996-04-10','Malang','L',NULL,NULL,'bagussetiawan@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(92,'9gaTrtkOczeF5ZB2ylxs',1,NULL,'Muhammad Ade Ikhsan','3818066606','1019-243-5','1999-02-07','Malang','L',NULL,NULL,'adeikhsan@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(93,'uDP4AOBTZG7jQpkLerV9',1,NULL,'Rheza Chandra Kurniawan','3818066607','1019-243-6','1999-03-14','Surabaya','L',NULL,NULL,'rhezaceka@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(94,'8qEX1ox0yhRASizcsC4I',1,NULL,'Ade Ramadhana Pratama','3818066608','1019-243-7','1999-01-16','Malang','L',NULL,NULL,'aderamadhana03@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(95,'KMbCY7uWti9zXVJjv4Gk',1,NULL,'Danu Kuncoro Aji','3818066609','1019-243-8','1999-02-09','Pasuruan','L',NULL,NULL,'danukuncoroaji@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(96,'n6WOqRAeEcDwJ37GMXdB',1,NULL,'Rifda Ammarina Karsita','3818066610','1019-243-9','1999-08-15','Malang','P',NULL,NULL,'rifda_ammarina@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(97,'zQjndrocHhIaZ1KJmC3M',1,NULL,'Nataniel David Tektanto','3818066611','1019-244-0','1999-06-04','Surabaya','L',NULL,NULL,'ndt4699@gmail.com','Kristen',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(98,'bu3neckVPJHWqYUgalFf',1,NULL,'Varrell Fauzan Widyatamaka','3818066612','1019-244-1','1999-03-18','Malang','L',NULL,NULL,'varreltbob@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(99,'nTf8RqbPHEAUjGYWpwmz',1,NULL,'Yordan Al Yudha Ardhanta Putra','3818066613','1019-244-2','1999-04-29','Malang','L',NULL,NULL,'yudhabcd@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(100,'rWwkq43TcRxge6tE8Y7s',1,NULL,'Ronald Arrival Fajar','3818066614','1019-244-3','1999-05-10','Malang','L',NULL,NULL,'jrg.pisang@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(101,'qERCjyihf0b9esYQLWO7',1,NULL,'Monica Tifani Zahara','3818066615','1019-244-4','1998-11-10','Kupang','P',NULL,NULL,'monicatifanyz@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(102,'HjLnZx9pFCGfzwTko51v',1,NULL,'Mahsa Savira Berlianti Putri','3818066616','1019-244-5','1998-11-04','Malang','P',NULL,NULL,'mahsasaviraa@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(103,'28mvtTcQyUsYdBXb0Ofk',1,NULL,'Muhammad Reyhan Firnas Adani','3818066617','1019-244-6','1998-08-13','Malang','L',NULL,NULL,'firnasreyhan@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(104,'mxpXM9aLEDRGI34uCyKZ',1,NULL,'Billy Andreanto Sutikno','3818066618','1019-244-7','1999-04-17','Malang','L',NULL,NULL,'billysutikno@gmail.com','Katolik',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(105,'VYq2bK0OrlA5M6TXiCZo',1,NULL,'Hermawan Prasetyo','3818066619','1019-244-8','1999-12-18','Malang','L',NULL,NULL,'hermawan@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(106,'WJEKPYdyhtcqoxe5Ns61',1,NULL,'Dewi Azizah Satyarini Sugiono','3818066620','1019-244-9','1999-02-17','Malang','P',NULL,NULL,'dewiazizah@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(107,'9qCg5L2JrWRA7cuYOG4s',1,NULL,'Alfian Azis','3818066621','1019-245-0','1999-05-26','Malang','L',NULL,NULL,'alfianaziz@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(108,'N8pVAhk6BsCniDfcemMg',1,NULL,'Muhammad Hafidz Agung Mabrury','3818066622','1019-245-1','1999-05-10','Malang','L',NULL,NULL,'hafidzmabrury@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(109,'hVRFwIoUDiKfSy3kY65J',1,NULL,'Qorie\' Insyira Fitria','3818066623','1019-245-2','2000-12-30','Malang','P',NULL,NULL,'qorie.irra.fitria30@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(110,'k5KDMqG6pz04dCye7VYw',1,NULL,'Nanda Bima Mahendra','3818066624','1019-245-3','1999-02-16','Malang','L',NULL,NULL,'bimasaishoku@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(111,'l1yLrHAgWi62I5BYmTUw',1,NULL,'Gilang Zakaria Putra','3818066625','1019-245-4','1999-02-02','Jember','L',NULL,NULL,'gilangzp@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(112,'91LhU0OPKTA7EWou6mav',1,NULL,'Ahmad Masrud Mubarok','3818066626','1019-245-5','1999-03-21','Malang','L',NULL,NULL,'masrudmubarok@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(113,'9E84MPQrSpo5fVs0FLGT',1,NULL,'Marsellianus Herdian Setyanugraha','3818066627','1019-245-6','1999-04-08','Surabaya','L',NULL,NULL,'marselherdian@gmail.com','Katolik',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(114,'85FQMKwVi7qaZS0AfIUm',1,NULL,'Titania Tara Swastika','3818066628','1019-245-7','1999-02-04','Tuban','P',NULL,NULL,'titania_tara04@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(115,'hoZPBlRyuLnVA7QIUmzp',1,NULL,'Robert Mahendra Setiawan','3818066629','1019-245-8','1998-04-11','Malang','L',NULL,NULL,'robertmahendra@gmail.com','Kristen',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(116,'REQnx1qzNATOLZiBr6MG',1,NULL,'M. Aldin Yulis Setiawan','3818066630','1019-245-9','1997-05-23','Malang','L',NULL,NULL,'aldinyulis@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(117,'e7kyoDq6i4NWQT2Fjrau',1,NULL,'Moch. Alfian Fernanda','3818066631','1019-246-0','1999-01-20','Malang','L',NULL,NULL,'alfianfernanda@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(118,'6NjDxb3qdPT4O1vs0JXh',1,NULL,'Steven Leonard Anggoro','3818066632','1019-246-1','1999-07-31','Malang','L',NULL,NULL,'stevenleonard31@gmail.com','Kristen',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(119,'ERUpr4tlWX0LhxfyDSbw',1,NULL,'Stefano Zaghallo Sandah','3818066633','1019-246-2','1998-12-24','Malang','L',NULL,NULL,'sagasandah@gmail.com','Katolik',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(120,'72wJ1XFl5z0HMB8QdAkj',1,NULL,'Anggoro Yudhistira Putra','3818066634','1019-246-3','1999-09-27','Malang','L',NULL,NULL,'anggoroyp@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(121,'NizLjPO8ArK6X3Z1FtqM',1,NULL,'Eka Agustina Pratiwi','3818066635','1019-246-4','1999-08-24','Malang','P',NULL,NULL,'ekaagustinapratiwi@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(122,'BFJHPqK28LGuAZsgem6Q',1,NULL,'Eka Novita Christin','3818066636','1019-246-5','1998-10-30','Tulungagung','P',NULL,NULL,'ekanovita30@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(123,'OpJEMjUvsi7neFTNufS0',1,NULL,'Rinda Putri Agustyanitasari','3818066637','1019-246-6','1999-08-28','Malang','P',NULL,NULL,'rindaputri99@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(124,'U9mc2kwRZouWTgLS8YFA',1,NULL,'Ryan Candra Sugianto','3818066638','1019-246-7','1997-01-31','Malang','L',NULL,NULL,'rayyanshow@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(125,'ODGu8wBvg2VULePyZ43H',1,NULL,'Rully Anggraeni Ega Pertiwi','3818066639','1019-246-8','1999-07-03','Malang','P',NULL,NULL,'rullyega37@gmail.com','Islam',1,NULL,'2020-01-23 10:35:38',NULL,1),
	(126,'GzV3HsOwrnkRDEKU06xo',1,NULL,'Rusmadeta Okta Nugraha','3818066640','1019-246-9','1997-12-04','Ende','L',NULL,NULL,'dedeokta57@gmail.com','Kristen',1,NULL,'2020-01-26 22:43:58',NULL,1),
	(127,'6tMmAXhVFdPObnBvND8w',1,NULL,'Hendy Rama Dhany','3818066641','1019-247-0','1999-05-23','Malang','L',NULL,NULL,'hendyrama13@gmail.com','Islam',1,NULL,'2020-01-26 22:43:58',NULL,1),
	(128,'6ZXafU9SmOQgDCWPcTeV',1,NULL,'Mohammad Fajar','3818066642','1019-247-1','1999-05-05','Malang','L',NULL,NULL,'fajarm@gmail.com','Islam',1,NULL,'2020-01-26 22:44:00',NULL,1),
	(129,'O7TIRKaknviNrBflyJpz',1,NULL,'Muhammad Irfan Syarifuddin','3818066643','1019-247-2','1997-09-03','Malang','L',NULL,NULL,'irfansyarifuddin@gmail.com','Islam',1,NULL,'2020-01-26 22:44:01',NULL,1),
	(130,'YacseROMKzHvL4yCNt1q',1,NULL,'Muhammad Alam Wahyudi','3818066644','1019-247-3','1997-09-12','Banyuwangi','L',NULL,NULL,'alamwahyudi@gmail.com','Islam',1,NULL,'2020-01-26 22:44:01',NULL,1),
	(131,'Hg4LFOl1vY3DzwhQA7kd',1,NULL,'Daffa Zulkananta','3818066645','1019-247-4','1999-04-05','Malang','L',NULL,NULL,'d.zulkananta@gmail.com','Islam',1,NULL,'2020-01-26 22:44:02',NULL,1),
	(132,'P46uy23Op9UeIhqzbfBD',1,NULL,'Teuku Rionaldi Syahputra','3818066646','1019-247-5','1999-08-20','Malang','L',NULL,NULL,'riosyahputra@gmail.com','Islam',1,NULL,'2020-01-26 22:44:03',NULL,1),
	(133,'zukyCvfUKwa6rG3pdOIH',1,NULL,'Tito Ainurrakhman','3818066647','1019-247-6','1997-04-01','Malang','L',NULL,NULL,'tito.vx@gmail.com','Islam',1,NULL,'2020-01-26 22:44:08',NULL,1),
	(134,'civNl7kgBUCsAYabn4oP',1,NULL,'Risky Feryansyah Pribadi','3818066648','1019-247-7','1998-09-10','Malang','L',NULL,NULL,'riskytebo@gmail.com','Islam',1,NULL,'2020-01-26 22:44:09',NULL,1),
	(135,'hwzgREtprT8xF6YaPyKG',1,NULL,'Aldino Wildhan Kurniawan','3818066649','1019-247-8','1999-01-03','Malang','L',NULL,NULL,'aldinowildhan@gmail.com','Islam',1,NULL,'2020-01-26 22:44:10',NULL,1),
	(136,'Pf6hjRrWuqTEIyo7ic8M',1,NULL,'Nurami Nasrullah','3818066650','1019-247-9','1999-07-27','Malang','L',NULL,NULL,'nuraminasrullah@gmail.com','Islam',1,NULL,'2020-01-26 22:44:11',NULL,1),
	(137,'yGXTOexR0mP7i3dt1DHc',1,NULL,'Hendry Anggono','3818066651','1019-248-0','1999-08-21','Malang','L',NULL,NULL,'hendryanggono@gmail.com','Islam',1,NULL,'2020-01-26 22:44:13',NULL,1),
	(138,'pcxyz2AbHrKlOWeG9mBi',1,NULL,'Ariya Djayanto','3818066652','1019-248-1','1999-12-12','Lamongan','L',NULL,NULL,'ariyadj@gmail.com','Islam',1,NULL,'2020-01-26 22:45:21',NULL,1),
	(139,'FwICq0DveOtVZMskgdcL',1,NULL,'Samuel Ardiyanto','3818066653','1019-248-2','2002-02-02','Malang','L',NULL,NULL,'samuelardi@gmail.com','Islam',1,NULL,'2020-01-26 22:45:24',NULL,1),
	(140,'Rb75MurCY36peh1xz4G0',1,NULL,'Ika Ercha Rahmawati Sunarya','3818066654','1019-248-3','2000-07-14','Palangkaraya','P',NULL,NULL,'ikaerc@gmail.com','Islam',1,NULL,'2020-01-26 22:45:24',NULL,1),
	(141,'MGtrBwOfmFbKuT271VYg',1,NULL,'Nadiva Ramandani','3818066655','1019-248-4','2000-01-01','Sidoarjo','P',NULL,NULL,'nadivara@gmail.com','Islam',1,NULL,'2020-01-26 22:45:26',NULL,1),
	(142,'xQEqvM1rmalXWiG3zkpP',1,NULL,'Arnando Ristanta','3818066656','1019-248-5','2000-04-20','Malang','L',NULL,NULL,'arnandoristanta@gmail.com','Islam',1,NULL,'2020-01-26 22:45:27',NULL,1),
	(143,'CMW2eBJzNVq0HgtS7Ayu',1,NULL,'Achmad Buyung Riyadi','3818066657','1019-248-6','2000-01-03','Malang','L',NULL,NULL,'buyungriyadi@gmail.com','Islam',1,NULL,'2020-01-26 22:45:27',NULL,1),
	(144,'kJL6DGPnXETwWBlyx7vI',1,NULL,'Kurniat Idaman Sukur Telaumbanua','3818066658','1019-248-7','2000-08-18','Makassar','L',NULL,NULL,'kurniatsukurtel@gmail.com','Katolik',1,NULL,'2020-01-26 22:45:29',NULL,1),
	(145,'lt1V4GHshSn0y6kZQ9vf',1,NULL,'Muhammad Fadjrin Listo Abadi','3818066659','1019-248-8','1999-05-02','Malang','L',NULL,NULL,'fadjrinlistoabadi@gmail.com','Islam',1,NULL,'2020-01-26 22:45:33',NULL,1),
	(146,'m4oXqZIWcTPwv7fduFsa',1,NULL,'Muhammad Asrofudin Hidayat','3818066660','1019-248-9','1999-04-03','Malang','L',NULL,NULL,'asrofudinhidayat@gmail.com','Islam',1,NULL,'2020-01-26 22:45:36',NULL,1),
	(147,'T4evW5hlRyGaQxS3AHC0',1,NULL,'Muhammad Faisal Akbar','3818066661','1019-249-0','1999-05-14','Samarinda','L',NULL,NULL,'faisalakbar@gmail.com','Islam',1,NULL,'2020-01-26 22:45:37',NULL,1),
	(148,'bwWucUmL3a57E2FBOKyx',1,NULL,'Farrel Akbar Ramadhan','3818066662','1019-249-1','2000-07-19','Tarakan','L',NULL,NULL,'farrel.ar@gmail.com','Islam',1,NULL,'2020-01-26 22:45:37',NULL,1),
	(149,'aomjrJUSWfiGwZlyb2uq',1,NULL,'Aldiansyah Rayyan Muhammad Ramadhan','3818066663','1019-249-2','1999-02-20','Malang','L',NULL,NULL,'aldirayyan@gmail.com','Islam',1,NULL,'2020-01-26 22:45:38',NULL,1),
	(150,'7Mv8aJlIW4SGq6X3FyLf',1,NULL,'Arifasiwi Milanda Putri','3818066664','1019-249-3','2000-07-07','Tuban','P',NULL,NULL,'siwiputri@gmail.com','Islam',1,NULL,'2020-01-26 22:45:39',NULL,1),
	(151,'n2azY9GbEHTS7cy3BtgV',1,NULL,'Bayu Sekti Nago Prakosa','3818066665','1019-249-4','1999-11-27','Malang','L',NULL,NULL,'b.sekti@gmail.com','Kristen',1,NULL,'2020-01-26 22:45:39',NULL,1),
	(152,'8Kt45yCZcruibGwNeQpj',1,NULL,'Briyan','3818066666','1019-249-5','1999-03-31','Jakarta','L',NULL,NULL,'briyan_jo@gmail.com','Kristen',1,NULL,'2020-01-26 22:45:42',NULL,1),
	(153,'rfV1aKvCAnhylbYXWH2p',1,NULL,'Joshua Christian Oetomo','3818066667','1019-249-6','1999-12-27','Malang','L',NULL,NULL,'joshuaoetomo@gmail.com','Kristen',1,NULL,'2020-01-26 22:45:42',NULL,1),
	(154,'Gs1qtvFpfojMVShDcxaA',1,NULL,'Mohammad Zarkasih Ramadhan','3818066668','1019-249-7','1999-01-19','Bandung','L',NULL,NULL,'zarkasih@gmail.com','Islam',1,NULL,'2020-01-26 22:45:43',NULL,1),
	(155,'yEORaTVzfMNA2QxDjqpL',1,NULL,'Elfan Fabrianto','3818066669','1019-249-8','2000-06-22','Surabaya','L',NULL,NULL,'elfan@gmail.com','Islam',1,NULL,'2020-01-26 22:45:44',NULL,1),
	(156,'G9Q5HneX4idmkCOfMsE2',1,NULL,'Muhammad Tegar','3818066670','1019-249-9','1999-06-19','Semarang','L',NULL,NULL,'muhammadtegar@gmail.com','Islam',1,NULL,'2020-01-26 22:45:45',NULL,1),
	(157,'kVn97aEIxJuctB285PO0',1,NULL,'Deo Armandito Anardy','3818066671','1019-250-0','1999-05-24','Kulonprogo','L',NULL,NULL,'deoarmandito@gmail.com','Islam',1,NULL,'2020-01-26 22:45:47',NULL,1),
	(158,'IBJm9n72V6Ebj8cWGAd5',1,NULL,'Maria Gita Teresa Febriani','3818066672','1019-250-1','1970-01-01','2000/02/25','P',NULL,NULL,'tesafebriani@gmail.com','Katolik',1,NULL,'2020-02-07 11:28:43',NULL,1),
	(159,'3soShZdJ28FE6MHfu0gr',1,NULL,'Kresna Ajicaraka Effendi','3818066673','1019-250-2','1970-01-01','1998/07/15','L',NULL,NULL,'kresnaaji@gmail.com','Islam',1,NULL,'2020-02-07 11:28:43',NULL,1),
	(160,'0tbcfxakRNUW9O6TVBH5',1,NULL,'Karlina','3818066674','1019-250-3','1970-01-01','2000/05/29','P',NULL,NULL,'karlina.na99@gmail.com','Kristen',1,NULL,'2020-02-07 11:28:44',NULL,1),
	(161,'CY08OIHLbAGvaTx5rqkp',1,NULL,'Resya Al Mufqi','3818066675','1019-250-4','1970-01-01','2000/01/04','L',NULL,NULL,'kiki_resya@gmail.com','Islam',1,NULL,'2020-02-07 11:28:44',NULL,1),
	(162,'qoAdi2uL1M9l7vwPGmab',1,NULL,'Robby Alamsyah','3818066676','1019-250-5','1970-01-01','1999/12/08','L',NULL,NULL,'robbyalamsyah@gmail.com','Islam',1,NULL,'2020-02-07 11:28:45',NULL,1),
	(163,'KPlUc9witmBDFVhzNWke',1,NULL,'Rafli Putranto','3818066677','1019-250-6','1970-01-01','2001/02/05','L',NULL,NULL,'rafliputranto@gmain.com','Islam',1,NULL,'2020-02-07 11:28:45',NULL,1),
	(164,'ZbEFsRwex407OyIPpYzl',1,NULL,'Mahendra Dwi Purwanto','3818066678','1019-250-7','1970-01-01','2000/09/04','L',NULL,NULL,'mahendradp@gmail.com','Islam',1,NULL,'2020-02-07 11:28:45',NULL,1),
	(165,'os6aFImOV5dvr8zuJTUP',1,NULL,'Clara','3818066679','1019-250-8','1970-01-01','2000/06/02','P',NULL,NULL,'clara_sudarsono@gmail.com','Kristen',1,NULL,'2020-02-07 11:28:46',NULL,1),
	(166,'H3GDeBS0ItXZpi2PdoCJ',1,NULL,'Donella Monica Ilham','3818066680','1019-250-9','1970-01-01','2000/10/29','P',NULL,NULL,'donella_monica@gmail.com','Kristen',1,NULL,'2020-02-07 11:28:46',NULL,1),
	(167,'PkXSziyKQojUe24RaFOh',1,NULL,'Feby Diansyah','3818066681','1019-251-0','1970-01-01','2000/04/20','L',NULL,NULL,'febydiansyah@gmail.com','Kristen',1,NULL,'2020-02-07 11:28:46',NULL,1),
	(168,'2ZXz1BlgWh5mUw46naNY',1,NULL,'Kristina Ayu Saputri','3818066682','1019-251-1','1970-01-01','1998/07/24','P',NULL,NULL,'kristinayusaputri@gmail.com','Islam',1,NULL,'2020-02-07 11:28:47',NULL,1);

/*!40000 ALTER TABLE `tbl_master_siswa` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tbl_siswa_ortu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_siswa_ortu`;

CREATE TABLE `tbl_siswa_ortu` (
  `id_siswa_ortu` int(11) NOT NULL AUTO_INCREMENT,
  `id_siswa_ortu_url` varchar(20) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_siswa` int(11) NOT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `thn_lahir_ayah` int(11) DEFAULT NULL,
  `pendidikan_ayah` int(11) DEFAULT NULL,
  `pekerjaan_ayah` int(11) DEFAULT NULL,
  `rentang_penghasilan_ayah` int(11) DEFAULT NULL,
  `nik_ayah` varchar(16) DEFAULT NULL,
  `no_hp_ayah` varchar(20) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `thn_lahir_ibu` int(11) DEFAULT NULL,
  `pendidikan_ibu` int(11) DEFAULT NULL,
  `pekerjaan_ibu` int(11) DEFAULT NULL,
  `rentang_penghasilan_ibu` int(11) DEFAULT NULL,
  `nik_ibu` varchar(16) DEFAULT NULL,
  `no_hp_ibu` varchar(20) DEFAULT NULL,
  `nama_wali` varchar(50) DEFAULT NULL,
  `thn_lahir_wali` int(11) DEFAULT NULL,
  `pendidikan_wali` int(11) DEFAULT NULL,
  `pekerjaan_wali` int(11) DEFAULT NULL,
  `rentang_penghasilan_wali` int(11) DEFAULT NULL,
  `nik_wali` varchar(16) DEFAULT NULL,
  `no_hp_wali` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_siswa_ortu`) USING BTREE,
  KEY `fk_siswa_ortu2` (`id_siswa`) USING BTREE,
  KEY `pekerjaan_ayah` (`pekerjaan_ayah`) USING BTREE,
  KEY `rentang_penghasilan_ayah` (`rentang_penghasilan_ayah`) USING BTREE,
  KEY `pekerjaan_ibu` (`pekerjaan_ibu`) USING BTREE,
  KEY `rentang_penghasilan_ibu` (`rentang_penghasilan_ibu`) USING BTREE,
  KEY `pekerjaan_wali` (`pekerjaan_wali`) USING BTREE,
  KEY `rentang_penghasilan_wali` (`rentang_penghasilan_wali`) USING BTREE,
  KEY `pendidikan_ayah` (`pendidikan_ayah`) USING BTREE,
  KEY `pendidikan_ibu` (`pendidikan_ibu`) USING BTREE,
  KEY `pendidikan_wali` (`pendidikan_wali`) USING BTREE,
  KEY `ortu_ke_user` (`id_user`) USING BTREE,
  CONSTRAINT `fk_siswa_ortu2` FOREIGN KEY (`id_siswa`) REFERENCES `tbl_master_siswa` (`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ortu_ke_user` FOREIGN KEY (`id_user`) REFERENCES `tbl_sys_users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_10` FOREIGN KEY (`pendidikan_ayah`) REFERENCES `tbl_jenjang_pendidikan` (`id_jenjang_pendidikan`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_11` FOREIGN KEY (`pendidikan_ibu`) REFERENCES `tbl_jenjang_pendidikan` (`id_jenjang_pendidikan`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_12` FOREIGN KEY (`pendidikan_wali`) REFERENCES `tbl_jenjang_pendidikan` (`id_jenjang_pendidikan`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_2` FOREIGN KEY (`pekerjaan_ayah`) REFERENCES `tbl_pekerjaan_ortu_siswa` (`id_pekerjaan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_3` FOREIGN KEY (`rentang_penghasilan_ayah`) REFERENCES `tbl_penghasilan_ortu_siswa` (`id_penghasilan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_5` FOREIGN KEY (`pekerjaan_ibu`) REFERENCES `tbl_pekerjaan_ortu_siswa` (`id_pekerjaan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_6` FOREIGN KEY (`rentang_penghasilan_ibu`) REFERENCES `tbl_penghasilan_ortu_siswa` (`id_penghasilan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_8` FOREIGN KEY (`pekerjaan_wali`) REFERENCES `tbl_pekerjaan_ortu_siswa` (`id_pekerjaan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tbl_siswa_ortu_ibfk_9` FOREIGN KEY (`rentang_penghasilan_wali`) REFERENCES `tbl_penghasilan_ortu_siswa` (`id_penghasilan_ortu`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

LOCK TABLES `tbl_siswa_ortu` WRITE;
/*!40000 ALTER TABLE `tbl_siswa_ortu` DISABLE KEYS */;

INSERT INTO `tbl_siswa_ortu` (`id_siswa_ortu`, `id_siswa_ortu_url`, `id_user`, `id_siswa`, `nama_ayah`, `thn_lahir_ayah`, `pendidikan_ayah`, `pekerjaan_ayah`, `rentang_penghasilan_ayah`, `nik_ayah`, `no_hp_ayah`, `nama_ibu`, `thn_lahir_ibu`, `pendidikan_ibu`, `pekerjaan_ibu`, `rentang_penghasilan_ibu`, `nik_ibu`, `no_hp_ibu`, `nama_wali`, `thn_lahir_wali`, `pendidikan_wali`, `pekerjaan_wali`, `rentang_penghasilan_wali`, `nik_wali`, `no_hp_wali`, `created_at`, `modified_at`, `status`)
VALUES
	(1,'EYoTXOIryhpldc6mH9yc',5,1,'D',NULL,NULL,NULL,NULL,NULL,'081','D',NULL,NULL,NULL,NULL,NULL,'085',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-09-22 22:16:42',NULL,1),
	(2,'vfrP1tKZoajpEXYQJgAk',NULL,37,'Aluwicius Andreawan',NULL,NULL,NULL,NULL,NULL,'0895859382823','Emilita Lotussa',NULL,NULL,NULL,NULL,NULL,'085674829918',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-12-23 12:18:17',NULL,1);

/*!40000 ALTER TABLE `tbl_siswa_ortu` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
