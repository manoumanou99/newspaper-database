CREATE DATABASE ekdotikos_oikos;
USE ekdotikos_oikos;

CREATE TABLE newspaper(
news_name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
news_owner VARCHAR(25) DEFAULT 'unknown' NOT NULL,
frequency ENUM('daily','weekly','monthly'),
PRIMARY KEY(news_name)
);

CREATE TABLE employee (
emp_name VARCHAR(25) DEFAULT 'unknown' NOT NULL ,
emp_lname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
email VARCHAR(25) NOT NULL,
salary NUMERIC(6,2) NOT NULL,
start_wrk DATE NOT NULL,
PRIMARY KEY(email)
);

CREATE TABLE working (
wrk_newspaper VARCHAR(25) DEFAULT 'unknown' NOT NULL,
wrk_email VARCHAR(25) DEFAULT 'unknown' NOT NULL,
CONSTRAINT WRKNEWS 
FOREIGN KEY (wrk_newspaper) REFERENCES newspaper(news_name)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT WRKEMAIL 
FOREIGN KEY (wrk_email) REFERENCES employee(email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reporter(
report_email VARCHAR(25) NOT NULL,
wrk_experience TEXT,
biografy TEXT,
CONSTRAINT EMAIL
FOREIGN KEY (report_email) REFERENCES employee(email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE administrative(
duties ENUM('secretary','logistics'),
city VARCHAR(25) NOT NULL,
street_name VARCHAR(25)NOT NULL ,
street_number INT(5) NOT NULL,
admin_email VARCHAR (25) NOT NULL,
CONSTRAINT ADMINEMAIL 
FOREIGN KEY (admin_email) REFERENCES employee (email)
ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE phone(
phonenum BIGINT(10) NOT NULL,
ad_email VARCHAR(25) NOT NULL,
PRIMARY KEY (phonenum),
CONSTRAINT ADEMAIL 
FOREIGN KEY (ad_email) REFERENCES administrative (admin_email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE editor_in_chief(
editor_email VARCHAR(25) NOT NULL,
CONSTRAINT EDEMAIL 
FOREIGN KEY (editor_email) REFERENCES employee(email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sheet(
pages_num INT(2) DEFAULT '30' NOT NULL,
sheet_num INT(7) NOT NULL ,
release_date DATE NOT NULL,
name_news VARCHAR(25) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY (sheet_num),
CONSTRAINT NSHEET 
FOREIGN KEY (name_news) REFERENCES newspaper(news_name)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category(
ID INT(9) NOT NULL AUTO_INCREMENT,
name_categ VARCHAR(25) DEFAULT 'unknown' NOT NULL,
description TEXT,
parent INT(9) NOT NULL,
PRIMARY KEY (ID)
);

CREATE TABLE article(
path VARCHAR(100) NOT NULL,
title VARCHAR(50) NOT NULL,
summary TEXT ,
email_rep VARCHAR(25) NOT NULL,
art_ID INT(9) NOT NULL ,
submitDATE TIMESTAMP,
art_sheet_num INT(7) NOT NULL ,
art_num INT(2) NOT NULL,
PRIMARY KEY(path),
CONSTRAINT REPEMAIL 
FOREIGN KEY (email_rep) REFERENCES reporter(report_email)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTCATEGORY 
FOREIGN KEY (art_ID) REFERENCES category(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTSHEET
FOREIGN KEY (art_sheet_num) REFERENCES sheet(sheet_num)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE key_words(
key_path VARCHAR(45) NOT NULL,
words CHAR(25) NOT NULL,
CONSTRAINT KEYWRDS
FOREIGN KEY (key_path) REFERENCES article(path)
ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE article_check(
art_state ENUM('accept','reject','change','rewatch'),
art_name VARCHAR(45) NOT NULL,
ed_email VARCHAR (25) NOT NULL,
date_check TIMESTAMP,
CONSTRAINT ARTCHECK
FOREIGN KEY (art_name) REFERENCES article(path)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTEMAIL 
FOREIGN KEY (ed_email) REFERENCES editor_in_chief(editor_email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE publisher(
p_name VARCHAR(25) NOT NULL,
p_lname VARCHAR(25) NOT NULL,
p_email VARCHAR(25) NOT NULL,
p_news_name VARCHAR(25) NOT NULL,
PRIMARY KEY (p_email),
CONSTRAINT PUBLISH 
FOREIGN KEY(p_news_name) REFERENCES newspaper(news_name)
ON DELETE CASCADE ON UPDATE CASCADE
);



INSERT INTO newspaper VALUES 
('Kathimerini','Alafouzos','daily'),
('Odigitis','AEBE','monthly'),
('Rizospastis','AEBE','weekly');

INSERT INTO employee VALUES
('Konstantinos','Trikoupis','kontrip@gmail.com','732,50','2019-05-04'),
('Ioannis','Kapsalis','kaps11@gmail.com','800,72','2016-03-02'),
('Sofia','Xristou','sofiexxx@gmail.com','780,00','2018-04-20'),
('Maria','Gkoutha','mariagkoutha@gmail.com','1900,01','2013-02-01'),
('Giorgos', 'Kaplanis', 'gkapl@hotmail.gr', '2000,00' , '2012-03-09'),
('Katerina', 'Stauvrou', 'katias@hotmail.gr', '2000,00', '2012-07-19');

INSERT INTO working VALUES
('Kathimerini','kontrip@gmail.com'),
('Odigitis','kaps11@gmail.com'),
('Kathimerini','mariagkoutha@gmail.com'),
('Rizospastis','sofiexxx@gmail.com'),
('Odigitis','gkapl@hotmail.gr'),
('Kathimerini','katias@hotmail.gr');

INSERT INTO reporter VALUES 
('kontrip@gmail.com','none','ptyxiouxos'),
('mariagkoutha@gmail.com','exei ergastei se 3 efimerides','pryxiouxos');

INSERT INTO administrative VALUES
('secretary','Larisa','Sifnou',34,'sofiexxx@gmail.com'),
('logistics','Patra','Korinthou',156,'kaps11@gmail.com');

INSERT INTO phone VALUES
(6983456577,'sofiexxx@gmail.com'),
(2410811358,'sofiexxx@gmail.com'),
(6972655190,'kaps11@gmail.com'),
(261099300,'kaps11@gmail.com');

INSERT INTO editor_in_chief VALUES 
('katias@hotmail.gr'),
('gkapl@hotmail.gr');

INSERT INTO sheet VALUES 
(DEFAULT,1000,'2019-04-05','Kathimerini'),
(28,360,'2019-04-07','Odigitis'),
(26,970,'2019-03-05','Kathimerini'),
(26,359,'2019-03-05','Odigitis');

INSERT INTO category VALUES
(NULL,'Oikonomika','Oikonomikes ekselikseis',5),
(NULL,'Politiki','Politikes ekselikeis',6),
(NULL,'Lifestyle','Oi kaluteres emfaniseis sto kokkino xali',8);

INSERT INTO article VALUES
('C:\Users\Articles\Submitted\Article10.pdf','Teleutaies ekselikseis tou Brexit',
'Teleutaia nea apo thn apoxwrhsh ths Bretanias apo thn E.E.',
'kontrip@gmail.com','1',DEFAULT,'1',1000),
('C:\Users\Articles\Sumbitted\Article13.pdf','Diloseis tou upourgou oikonomikwn',
'Oi dhlwseis toy upourgou oikonomikwn gia to koinoniko merisma',
'mariagkoutha@gmail.com','2',DEFAULT,'2',360);

INSERT INTO key_words VALUES 
('C:\Users\Articles\Submitted\Article10.pdf','Brexit'),
('C:\Users\Articles\Submitted\Article10.pdf','Bretania'),
('C:\Users\Articles\Sumbitted\Article13.pdf','Xristos Staikouras'),
('C:\Users\Articles\Sumbitted\Article13.pdf','Proupologismos');

INSERT INTO article_check VALUES 
('Accept','C:\Users\Articles\Submitted\Article10.pdf','katias@hotmail.gr',DEFAULT),
('Reject','C:\Users\Articles\Sumbitted\Article13.pdf','gkapl@hotmail.gr',DEFAULT);

INSERT INTO publisher VALUES
('Aleksis','Papaxelas','alexpap@gmail.com','Kathimerini'),
('Petros','Leontis','petran123@gmail.com','Odigitis');

DELIMITER $
CREATE PROCEDURE prwti (IN_OPTION ENUM( 'accept','reject','rewatch'))
BEGIN 
DECLARE state VARCHAR(25);
SET state=ad_state; 
IF (art_state='accept') THEN 
SELECT path FROM article INNER JOIN article_check ON path=art_name 
ORDER BY article_check.date_check DESC ;
end if;
END$

DELIMITER ;

SELECT article.title,employee.emp_name,employee.emp_lname,article_check.date_check,article.art_num FROM article 
INNER JOIN article_check ON path=art_name INNER JOIN editor_in_chief ON ed_email=editor_email INNER JOIN employee on ed_email=email;
