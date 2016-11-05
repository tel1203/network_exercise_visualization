# 管理サーバのMySQL構築


create database rpidb default character set utf8 collate utf8_unicode_ci;
create user rpiusr@localhost identified by 'rpipass';
grant all on rpidb.* to rpiusr@localhost;
flush privileges;
use rpidb
create table rpitbl (
	id INT AUTO_INCREMENT,
	Link int NOT NULL,
	device VARCHAR(10) NOT NULL,
	HWaddr VARCHAR(100) NOT NULL,
	inet_addr VARCHAR(100) NULL,
	Bcast VARCHAR(100) NULL,
	Mask VARCHAR(100) NULL,
	memory_free int NOT NULL,
	cpu_id int NOT NULL,
	dt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
	);

