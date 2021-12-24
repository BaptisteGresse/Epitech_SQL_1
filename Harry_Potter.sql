CREATE DATABASE HarryPotter;
USE HarryPotter;

-- creation of tables and insert values --

CREATE TABLE ROLE (
    RO_ID INT NOT NULL AUTO_INCREMENT,
    RO_LASTNAME VARCHAR(100),
    RO_FIRSTNAME VARCHAR(100),
    PRIMARY KEY(RO_ID)
)ENGINE=INNODB;

INSERT INTO ROLE (RO_LASTNAME, RO_FIRSTNAME) VALUES
    ("Potter", "Harry"),
    ("Granger", "Hermione"),
    ("Weasley", "Ron"),
    ("Rogue", "Severus"),
    ("Malefoy", "Drago"),
    ("Weasley", "Ginnie"),
    ("Londubat", "Neville"),
    ("Dumbledore", "Albus");

-- 1 to 1 --

CREATE TABLE ACTOR (
    AC_ID INT NOT NULL AUTO_INCREMENT,
    AC_LASTNAME VARCHAR(100) NOT NULL,
    AC_FIRSTNAME VARCHAR(100) NOT NULL,
    AC_BIRTHDATE DATE NOT NULL,
    AC_ROLE_FK INT NOT NULL UNIQUE,
    FOREIGN KEY (AC_ROLE_FK)
        REFERENCES ROLE(RO_ID),
    PRIMARY KEY(AC_ID)
)ENGINE=INNODB;

INSERT INTO ACTOR (AC_LASTNAME, AC_FIRSTNAME, AC_BIRTHDATE, AC_ROLE_FK) VALUES
    ("Radcliffe", "Daniel", "1989-07-23", 1),
    ("Watson", "Emma", "1990-04-15", 2),
    ("Grint", "Rupert", "1988-08-24", 3),
    ("Rickman", "Alan", "1946-02-21", 4),
    ("Felton", "Tom", "1987-09-22", 5),
    ("Wright", "Bonnie", "1991-02-17", 6),
    ("Lewis", "Matthew", "1989-06-27", 7),
    ("Gambon", "Michael", "1940-10-19", 8);   

CREATE TABLE DIRECTOR (
    DI_ID INT NOT NULL AUTO_INCREMENT,
    DI_LASTNAME VARCHAR(100) NOT NULL,
    DI_FIRSTNAME VARCHAR(100) NOT NULL,
    PRIMARY KEY(DI_ID)
)ENGINE=INNODB;

INSERT INTO DIRECTOR (DI_LASTNAME, DI_FIRSTNAME) VALUES
    ("Colombus", "Chris"),
    ("Cuaron", "Alfonso"),
    ("Newell", "Mike"),
    ("Yates", "David");

-- 1 to * --

CREATE TABLE MOVIE (
    MO_ID INT NOT NULL AUTO_INCREMENT,
    MO_TITLE VARCHAR(225),
    MO_RELEASEYEAR YEAR(4),
    MO_DESCRIPTION VARCHAR(255),
    MO_DIRECTOR_FK INT NOT NULL,
    FOREIGN KEY (MO_DIRECTOR_FK)
        REFERENCES DIRECTOR(DI_ID),
    MO_BOOK_FK INT NOT NULL UNIQUE,
    FOREIGN KEY (MO_BOOK_FK)
        REFERENCES BOOK(BO_ID),
    PRIMARY KEY(MO_ID)
)ENGINE=INNODB;

INSERT INTO MOVIE (MO_TITLE, MO_RELEASEYEAR, MO_DESCRIPTION, MO_DIRECTOR_FK, MO_BOOK_FK) VALUES
    ("Harry Potter à l'école des sorciers", "2001", "Le début du destin magique d'un garçon pas comme les autres",1 ,1 ),
    ("Harry Potter et la chambre des secrets", "2002", "Dans les entrails de Poudlard, le mal se réveille",1 ,2 ),
    ("Harry Potter et le prisonnier d'azkaban", "2004", "Les secrets du passé glissent. Tout ce qui a été imaginé sera transformé",2 ,3 ),
    ("Harry Potter et la coupe de feu", "2005", "Des heures sombres et difficiles s'annoncent",3 ,4 ),
    ("Harry Potter et l'ordre du phénix", "2007", "La rébellion commence à Poudlard",4 ,5 ),
    ("Harry Potter et le prince de sang-mélé", "2009", "De sombres secrets dévoilés pour faire face à la bataille finale",4 ,6 );

-- 1 to 1 --

CREATE TABLE BOOK (
    BO_ID INT NOT NULL AUTO_INCREMENT,
    BO_TITLE VARCHAR(100) NOT NULL,
    BO_DESCRIPTION VARCHAR(255),
    PRIMARY KEY(BO_ID)
)ENGINE=INNODB;

INSERT INTO BOOK (BO_TITLE, BO_DESCRIPTION) VALUES
    ("Harry Potter à l'Ecole des Sorciers", "Que cache la trappe du troisième étage?"),
    ("Harry Potter et la Chambre des Secrets", "Harry résoudra t'il le mystère de la chambre des secrets?"),
    ("Harry Potter et le Prisonnier d'Azkaban", "Qui est Sirius Black"),
    ("Harry Potter et la coupe de feu", "Qui gagnera le tournoi des trois sorciers?"),
    ("Harry Potter et l'ordre du Phénix", "Harry et ses amies réussiront-ils à sauver Sirius Black (Harry en a révé)?"),
    ("Harry Potter et le prince de sang mélé", "Qui est le prince de sang-mélé?"),
    ("Harry Potter et les reliques de la mort", "Harry parviendra t'il à retrouver tous les horcruxes et à les détruire?");

-- 1 to * --

CREATE TABLE CHAPTER (
    CH_ID INT NOT NULL AUTO_INCREMENT,
    CH_TITLE VARCHAR(100) NOT NULL,
    CH_BOOK_FK INT NOT NULL,
    FOREIGN KEY (CH_BOOK_FK)
        REFERENCES BOOK(BO_ID),
    PRIMARY KEY(CH_ID)
)ENGINE=INNODB;

INSERT INTO CHAPTER (CH_TITLE, CH_BOOK_FK) VALUES
    ("Le Survivant", 1),
    ("Une Vitre Disparaît", 1),
    ("Les Lettres de Nulle Part", 1),
    ("Un très Mauvais Anniversaire", 2),
    ("L'Avertissement de Dobby", 2),
    ("Le Terrier", 2),
    ("Chez Fleury et Bott", 2),
    ("Hibou Express", 3),
    ("La Grosse Erreur de la Tante Marge", 3),
    ("Le Magicobus", 3),
    ("Le Chaudron Baveur", 3),
    ("Le Détraqueur", 3);

-- table associative beetween MOVIE and ACTOR -- 

CREATE TABLE CASTING (
    CA_MOVIE_FK INT NOT NULL,
    FOREIGN KEY (CA_MOVIE_FK)
        REFERENCES MOVIE(MO_ID),
    CA_ACTOR_FK INT NOT NULL,
    FOREIGN KEY (CA_ACTOR_FK)
        REFERENCES ACTOR(AC_ID),
    PRIMARY KEY(CA_MOVIE_FK, CA_ACTOR_FK)
)ENGINE=INNODB;

INSERT INTO CASTING (CA_MOVIE_FK, CA_ACTOR_FK) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (1, 7),
    (1, 8);

-- end of creation of tables and insert values --

-- standar request --     

SELECT AC_FIRSTNAME, YEAR(AC_BIRTHDATE) AS BIRTHYEAR FROM ACTOR;

SELECT AC_FIRSTNAME, AC_BIRTHDATE AS BIRTHDATE FROM ACTOR;

SELECT CONCAT(AC_FIRSTNAME," ",AC_LASTNAME) AS NAME FROM ACTOR WHERE YEAR(AC_BIRTHDATE) = "1989";

SELECT AC_FIRSTNAME FROM ACTOR WHERE YEAR(AC_BIRTHDATE) = (SELECT MAX(YEAR(AC_BIRTHDATE)) FROM ACTOR);

SELECT AC_FIRSTNAME FROM ACTOR WHERE YEAR(AC_BIRTHDATE) = (SELECT MIN(YEAR(AC_BIRTHDATE)) FROM ACTOR);

SELECT SUBSTRING(MO_TITLE, 14) AS PART_TITLE FROM MOVIE;

SELECT REPLACE(CH_TITLE, "Le", "77")FROM CHAPTER;

SELECT DATE_FORMAT(AC_BIRTHDATE, '%M',) AS MONTHBIRTH FROM ACTOR ORDER BY MONTHBIRTH DESC;

-- inner join request --

SELECT CONCAT(AC_FIRSTNAME,"/",RO_FIRSTNAME) AS ACTORROLE FROM ACTOR INNER JOIN ROLE ON AC_ID = RO_ID;






