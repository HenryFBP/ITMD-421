-- Henry Post, hpost@hawk.iit.edu, Midterm, ITMD421

DROP DATABASE IF EXISTS midterm;
CREATE DATABASE IF NOT EXISTS midterm;

Use midterm;

DROP TABLE  IF EXISTS ColorLocation;
CREATE TABLE ColorLocation
(
  Name       	VARCHAR(30),
  Age      	 	INT(4),
  Location 		VARCHAR(18),
  FavColor 		VARCHAR(18),
  
  CONSTRAINT Name
    PRIMARY KEY(Name)
);
INSERT INTO ColorLocation VALUES('Henry',13,'Chicago','Purple');
INSERT INTO ColorLocation VALUES('Brady',19,'Las Vegas','Red');
INSERT INTO ColorLocation VALUES('Kamal',23,'Montana','Blue');
INSERT INTO ColorLocation VALUES('Leo',17,'Oregon','White');
INSERT INTO ColorLocation VALUES('Kaleb',24,'Nebraska','Orange');

SELECT * FROM ColorLocation WHERE (NAME LIKE "%e%") OR (NAME LIKE "%e");