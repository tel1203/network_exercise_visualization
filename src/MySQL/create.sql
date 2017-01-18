# 管理サーバのMySQL構築


create database rpidb default character set utf8 collate utf8_unicode_ci;
create user rpiusr@localhost identified by 'rpipass';
grant all on rpidb.* to rpiusr@localhost;
flush privileges;
use rpidb
create table rpitbl (
	id INT AUTO_INCREMENT,
	Hostname VARCHAR(50) NOT NULL,
	device0 VARCHAR(10) NOT NULL,
	Link0 int NOT NULL,
	HWaddr0 VARCHAR(20) NOT NULL,
	inet_addr0 VARCHAR(20) NULL,
	Bcast0 VARCHAR(20) NULL,
	Mask0 VARCHAR(20) NULL,
	Rx0 int NULL,
	Tx0 int NULL,
	device1 VARCHAR(10) NOT NULL,
	Link1 int NOT NULL,
	HWaddr1 VARCHAR(20) NOT NULL,
	inet_addr1 VARCHAR(20) NULL,
	Bcast1 VARCHAR(20) NULL,
	Mask1 VARCHAR(20) NULL,
	Rx1 int NULL,
	Tx1 int NULL,
	Route VARCHAR(1024) NULL,
	memory_free int NOT NULL,
	cpu_id int NOT NULL,
	dt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
	);

