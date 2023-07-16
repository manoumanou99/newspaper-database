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
experience_in_months INT(4) not null,
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
sheet_num INT(9) NOT NULL ,
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
parent INT(9) DEFAULT NULL,
PRIMARY KEY (ID),
CONSTRAINT PARENTCAT
FOREIGN KEY (parent) REFERENCES category(ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE article(
path VARCHAR(100) NOT NULL,
title VARCHAR(30) NOT NULL,
summary TEXT ,
length INT(2) NOT NULL,
email_rep VARCHAR(25) NOT NULL,
art_ID INT(9) NOT NULL ,
art_sheet_num INT(2) NOT NULL ,
art_state ENUM('accept','reject','change','rewatch'),
submitDATE TIMESTAMP,
place INT(2) ,
ed_email VARCHAR (25) NOT NULL,
PRIMARY KEY(path),
CONSTRAINT REPEMAIL 
FOREIGN KEY (email_rep) REFERENCES reporter(report_email)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTCATEGORY 
FOREIGN KEY (art_ID) REFERENCES category(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTSHEET
FOREIGN KEY (art_sheet_num) REFERENCES sheet(sheet_num)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ARTEMAIL 
FOREIGN KEY (ed_email) REFERENCES editor_in_chief(editor_email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE key_words(
key_path VARCHAR(45) NOT NULL,
words CHAR(25) NOT NULL,
CONSTRAINT KEYWRDS
FOREIGN KEY (key_path) REFERENCES article(path)
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
('Rizospastis','AEBE','weekly');

INSERT INTO employee VALUES
('Konstantinos','Trikoupis','kontrip@gmail.com','732.50','2019-05-04','0'),
('Ioannis','Kapsalis','kaps11@gmail.com','800.72','2016-03-02','6'),
('Sofia','Xristou','sofiexxx@gmail.com','780.00','2018-04-20','7'),
('Maria','Gkoutha','mariagkoutha@gmail.com','1900.01','2013-02-01','47'),
('Giorgos', 'Kaplanis', 'gkapl@hotmail.gr', '2000.00' , '2012-03-09','56'),
('Katerina', 'Stauvrou', 'katias@hotmail.gr', '2000.00', '2012-07-19','67'),
('Paraskeuh', 'Kwstoulh', 'paskw@gmail.com', '1350.00', '2015-12-03','36'),
('Petros', 'Papakyriakou', 'pepas12@gmail.com', '980.00', '2016-01-26','12'),
('Xara', 'Panagoy', 'pxara@hotmail.gr', '780.00','2018-07-31','3');

INSERT INTO working VALUES
('Kathimerini','kontrip@gmail.com'),
('Kathimerini','kaps11@gmail.com'),
('Rizospastis','mariagkoutha@gmail.com'),
('Rizospastis','sofiexxx@gmail.com'),
('Rizospastis','gkapl@hotmail.gr'),
('Kathimerini','katias@hotmail.gr'),
('Rizospastis','paskw@gmail.com'),
('Kathimerini','pepas12@gmail.com'),
('Kathimerini','pxara@hotmail.gr');

INSERT INTO reporter VALUES 
('kontrip@gmail.com','none','ptyxiouxos'),
('mariagkoutha@gmail.com','exei ergastei se 3 efimerides','ptyxiouxos'),
('paskw@gmail.com','polyeth ergasia se megalh efhmerida', 'ena metaptyxiako' ),
('pepas12@gmail.com','polla xronia ws boithos kai 1 xrono ws epaggelmatias reporter', 'ptyxioyxos');
('gkapl@hotmail.gr','anwteros','ptyxiouxos')

INSERT INTO administrative VALUES
('secretary','Larisa','Sifnou',34,'sofiexxx@gmail.com'),
('logistics','Patra','Korinthou',156,'kaps11@gmail.com'),
('secretary', 'Larisa', 'Panagoulh', 45,'pxara@hotmail.gr');

INSERT INTO phone VALUES
(6983456577,'sofiexxx@gmail.com'),
(2410811358,'sofiexxx@gmail.com'),
(6972655190,'kaps11@gmail.com'),
(261099300,'kaps11@gmail.com'),
(6972743486, 'pxara@hotmail.gr');

INSERT INTO editor_in_chief VALUES 
('katias@hotmail.gr'),
('gkapl@hotmail.gr');

INSERT INTO sheet VALUES 
(DEFAULT,677000,'2019-04-05','Kathimerini'),
(28,167789,'2019-04-07','Rizospastis'),
(26,676969,'2019-03-05','Kathimerini'),
(26,167788,'2019-03-05','Rizospastis');

INSERT INTO category VALUES
(NULL,'Oikonomika','Oikonomikes ekselikseis',null),
(NULL,'Politiki','Politikes ekselikeis',null),
(NULL,'Lifestyle','Oi kaluteres emfaniseis sto kokkino xali',null);

INSERT INTO article VALUES
('C:\Users\Articles\Submitted\Article10.pdf','Ta nea metra gia ton korwnio',
'ola osa anakoinwthikan oti tha isxysoyn thn erxomenh ebdomada','2','kontrip@gmail.com','2','677000','Accept', NULL,'1','katias@hotmail.gr'),
('C:\Users\Articles\Sumbitted\Article13.pdf','Diloseis tou upourgou oikonomikwn',
'Oi dhlwseis toy upourgou oikonomikwn gia to koinoniko merisma','3','mariagkoutha@gmail.com','1','167789','Reject', null, '6','gkapl@hotmail.gr'),
('C:\Users\Articles\Submitted\Article11.pdf','Tourkiko metwpo',
'teleytaies ekselikseis sta ellhnika ydata','4','pepas12@gmail.com','2','677000','Accept', NULL,'3','katias@hotmail.gr'),
('C:\Users\Articles\Sumbitted\Article15.pdf','toyrkia-Ellada',
'Oi proklhseis synexizontai','3','paskw@gmail.com','2','167789','Reject', null, '6','gkapl@hotmail.gr');

INSERT INTO key_words VALUES 
('C:\Users\Articles\Submitted\Article10.pdf','koronoios'),
('C:\Users\Articles\Submitted\Article10.pdf','metra'),
('C:\Users\Articles\Sumbitted\Article13.pdf','Xristos Staikouras'),
('C:\Users\Articles\Sumbitted\Article13.pdf','Proupologismos');

INSERT INTO publisher VALUES
('Aleksis','Papaxelas','alexpap@gmail.com','Kathimerini'),
('Petros','Leontis','petran123@gmail.com','Rizospastis');

/*1o procedure*/
DELIMITER $
CREATE PROCEDURE a(IN sheet_num INT(9), IN name_news VARCHAR(25))
BEGIN
    DECLARE num INT(9);
    DECLARE namen VARCHAR(25);
    DECLARE summ INT(3);
    DECLARE all INT(2);
    DECLARE rest INT(2);

    SET num = sheet_num;
    SET namen = name_news;
    
    SELECT title, emp_name AS firstname, emp_lname AS lastname, submitDATE, place AS pagenumber, length 
    FROM article INNER JOIN reporter ON article.email_rep = reporter.report_email INNER JOIN employee ON reporter.report_email= employee.email
    WHERE sheet_num = num AND name_news = namen AND art_state LIKE 'Accept' ORDER BY pagenumber;
    SELECT sum(length) INTO summ FROM article 
        WHERE papernum=art_sheet_num AND art_state='Accept';
    SELECT pages_num INTO all FROM sheet 
        INNER JOIN article ON sheet.sheet_num=article.art_sheet_num 
        WHERE papernum=art_sheet_num;
    IF (summ < all) THEN 
        SET rest=all-summ;
        SELECT 'to fyllo ;exei akomh ', rest, 'selides kenes';
    END IF;
END$
DELIMITER ;
call a(677000, Kathimerini);

/*2o procedure*/
DELIMITER $
CREATE PROCEDURE b(IN email VARCHAR(25))
BEGIN
    DECLARE tempdate DATE;
    DECLARE empemail VARCHAR(25);
    DECLARE newsalary NUMERIC(6,2);
    DECLARE months_of_working INT(5);
    DECLARE start_wrk_month DATE;

    SET empemail = email;
    SET tempdate = CURRENTDATE();

    SELECT start_wrk INTO start_wrk_month FROM employee WHERE empemail = email;
    SET DATEDIFF(month, start_wrk_month , tempdate )= months_of_working;
    SET monthexp=experience_in_months + months_of_working;
    SELECT salary INTO newsalary FROM employee WHERE empemail = email;
    SET newsalary= newsalary + newsalary*(0,5*monthexp);
    UPDATE employee SET salary = newsalary WHERE email = empemail;

END$
DELIMITER ;
call b('mariagkoutha@gmail.com');

/*1o trigger */
DELIMITER $
CREATE TRIGGER addemployee BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN
    IF (salary <> 650.00) THEN SET NEW.salary = 650.00;
    END IF;
END$
DELIMITER ;

INSERT INTO employee VALUES 
('Manos','Zoras','mzoras@gmail.com','732.50','2020-08-29','2');

/*2o trigger */
DELIMITER $
CREATE TRIGGER checkarticle BEFORE INSERT ON article
FOR EACH ROW 
BEGIN
    DECLARE tempemail VARCHAR(25);
    DECLARE checkm VARCHAR(25);

    SET tempemail=email_rep;

    SELECT email_rep INTO checkm FROM article 
        INNER JOIN reporter ON article.email_rep=reporter.report_email 
        INNER JOIN employee ON reporter.report_email=employeee.mail
        INNER JOIN editor_in_chief ON employee.email=editor_in_chief.editor_email
        WHERE article.email_rep=editor_in_chief.editor_email AND tempemail = email_rep;
    IF (checkm NOT NULL) THEN 
        SET article.art_state = Accept;
    END IF;
END$
DELIMITER ;

INSERT INTO article VALUES
('C:\Users\Articles\Sumbitted\Article35.pdf','2o trigger test',
'Oi proklhseis synexizontai','3','gkapl@hotmail.gr','2','167789','Reject', null, '6','gkapl@hotmail.gr');



/*3o trigger */
DELIMITER $
CREATE TRIGGER checksheet BEFORE INSERT ON article
FOR EACH ROW 
BEGIN
    DECLARE papernum INT(9);
    DECLARE summ INT(3);
    DECLARE all INT(2);
    SET papernum = art_sheet_num;
    
    SELECT sum(length) INTO summ FROM article 
        WHERE papernum=art_sheet_num AND art_state='Accept';
    SELECT pages_num INTO all FROM sheet 
        INNER JOIN article ON sheet.sheet_num=article.art_sheet_num 
        WHERE papernum=art_sheet_num;
    IF (summ + length<=all) THEN 
        INSERT INTO sheet(path, title, summary, length, email_rep, art_ID , art_sheet_num, art_state, submitDATE, place, ed_email) 
        VALUES (new.path, new.title, new.summary, new.length, new.email_rep, new.art_ID , new.art_sheet_num, new.art_state, new.submitDATE, new.place, new.ed_email) 
    END IF;
END$
DELIMITER ;

INSERT INTO article VALUES
('C:\Users\Articles\Submitted\Article24.pdf','Ta nea metra gia ton korwnio 2',
'ola osa anakoinwthikan oti tha isxysoyn thn erxomenh ebdomada','4','kontrip@gmail.com','2','677000','Accept', NULL,'1','katias@hotmail.gr')




