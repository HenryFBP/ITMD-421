-- Henry Post, hpost@hawk.iit.edu, HW 4, Lab 2, ITMD421

SET SQL_SAFE_UPDATES = 1;

DROP DATABASE IF EXISTS lab2;
CREATE DATABASE IF NOT EXISTS lab2;

USE lab2;

-- Question 1
-- PerformanceTypes(PerformanceTypeName)
-- Types of performance
DROP TABLE IF EXISTS PerformanceTypes;
CREATE TABLE PerformanceTypes
(
  PerformanceTypeName       	VARCHAR(30) NOT NULL UNIQUE,
  
  CONSTRAINT PerformanceTypeName
    PRIMARY KEY(PerformanceTypeName)
);
DESCRIBE PerformanceTypes;


-- Performers(PerformerID, FirstName, LastName, Address, PerformanceTypeName)
-- Each performer has a performedID (integer), a name, address and type of performance
DROP TABLE IF EXISTS Performers;
CREATE TABLE Performers
(
  PerformerID       	INT(30) NOT NULL UNIQUE AUTO_INCREMENT,
  FirstName       		VARCHAR(30),
  LastName       		VARCHAR(30),
  Address       		VARCHAR(30),
  PerformanceTypeName	VARCHAR(30),
  
  CONSTRAINT PerformerID
    PRIMARY KEY(PerformerID),

  CONSTRAINT PerformanceTypeName 
    FOREIGN KEY (PerformanceTypeName)
    REFERENCES PerformanceTypes(PerformanceTypeName)

);
DESCRIBE Performers;


-- Arenas(ArenaID, ArenaName, City, Capacity) 
-- Each arena has an id (integer), a name (Ex. Allstate  Center),
-- a city where the arena is located, and seating capacity of the arena
DROP TABLE IF EXISTS Arenas;
CREATE TABLE Arenas
(
  ArenaID       		INT(30) NOT NULL UNIQUE AUTO_INCREMENT,
  ArenaName   			VARCHAR(30),
  City       			VARCHAR(30),
  Capacity				INT(30),
  
  CONSTRAINT ArenaID
    PRIMARY KEY (ArenaID)
);
DESCRIBE Arenas;


-- Concerts(PerformerID, ArenaID, ConcertDate)
-- Each concert is given by one performer, on a given arena, at a given date.
DROP TABLE IF EXISTS Concerts;
CREATE TABLE Concerts
(
  PerformerID      	 	INT(30) 	NOT NULL,
  ArenaID   			INT(30) 	NOT NULL,
  ConcertDate       	DATE 		NOT NULL,
	
  CONSTRAINT PerformerID 
    FOREIGN KEY (PerformerID)
    REFERENCES Performers(PerformerID),
  
  CONSTRAINT ArenaID
	FOREIGN KEY (ArenaID)
    REFERENCES Arenas(ArenaID),
    
  CONSTRAINT Concert
	PRIMARY KEY (ConcertDate)
);
DESCRIBE Concerts;


-- Question 2
INSERT INTO PerformanceTypes VALUES
	('singer'),
	('dancer'),
	('comedian');

SELECT * FROM PerformanceTypes;

-- Question 3
ALTER TABLE Performers
	ADD DateOfBirth Date;
    
-- Question 4
INSERT INTO Performers VALUES(NULL, 'John', 'Doe', 'Annapolis', 'singer', NULL);
SELECT * FROM Performers;

-- Question 5...it doesn't error? I don't know why.
INSERT INTO Performers VALUES(NULL, 'Grohn', 'Groe', 'Grannapolis', 'wringer', NULL);
SELECT * FROM Performers;

-- Question 6
INSERT INTO Performers VALUES(NULL, 'Matt', 'Smith', 'Baltimore, MD', 'dancer', NULL);
INSERT INTO Performers VALUES(NULL, 'Jane', 'Brown', 'New York, NY', 'dancer', NULL);
INSERT INTO Performers VALUES(NULL, 'Jennifer', 'Shade', 'Seattle, WA', 'dancer', NULL);
SELECT * FROM Performers;

-- Question 7
UPDATE Performers
	SET DateOfBirth = DATE('1990-03-02')
    WHERE PerformerID = 1;
SELECT * FROM Performers;

-- Question 8
DELETE FROM Performers
	WHERE FirstName = 'Matt' AND LastName = 'Smith';
SELECT * FROM Performers;

-- Question 9 ...again, it works. Probably because I don't set it as a FK correctly.
DELETE FROM PerformanceTypes
	WHERE PerformanceTypeName = 'singer';
SELECT * FROM PerformanceTypes;

-- Question 10: see question 9


-- Question 11

UPDATE PerformanceTypes
	SET PerformanceTypeName = 'dancer performer'
    WHERE PerformanceTypeName = 'dancer';
SELECT * FROM PerformanceTypes;

-- Question 12: It does, again as I might have messed up setting it as a foreign key, thus not
-- 				having it trigger updates.

-- Question 13

INSERT INTO Arenas VALUES(NULL, 'Banana Arena', 'Bananaville', 30);
INSERT INTO Arenas VALUES(NULL, 'Orange Arena', 'Orangetown', 40);
INSERT INTO Arenas VALUES(NULL, 'Cat Arena', 'Kitty City', 50);
SELECT * FROM Arenas;

-- Question 14

INSERT INTO Concerts VALUES(1, 1, CURDATE()+2);
INSERT INTO Concerts VALUES(2, 1, CURDATE()+4);
INSERT INTO Concerts VALUES(4, 1, CURDATE()+6);
SELECT * FROM Concerts;

-- Question 15

-- UPDATE Arenas
-- 	SET Capacity = 50000
--    WHERE (COUNT(Concerts.ArenaID) > 2);
-- SELECT * FROM Arenas;

-- Question 16
		
DROP TABLE IF EXISTS Dancers;
CREATE TABLE Dancers
(
  DancerID       	INT(30) NOT NULL UNIQUE AUTO_INCREMENT,
  FirstName       	VARCHAR(30),
  LastName       	VARCHAR(30),
  Address       	VARCHAR(30),
  
  CONSTRAINT DancerID
    PRIMARY KEY(DancerID)

);
DESCRIBE Dancers;

-- Question 17
INSERT INTO Dancers
	SELECT 	PerformerID, FirstName, LastName, Address
	FROM	Performers
    WHERE PerformanceTypeName = 'dancer';
SELECT * FROM Dancers