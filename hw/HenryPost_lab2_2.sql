-- Henry Post, hpost@hawk.iit.edu, HW 4, Lab 2, ITMD421

SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS lab2;
CREATE DATABASE IF NOT EXISTS lab2;

USE lab2;

-- Consider the below relational schema
-- Customer (name, email, phone, totalPurchase) 
-- Video (vID, name, year, cost, genre) 
-- Actor (aID, name, dob) 
-- Price (priceCode, cost) 
-- Rents (email-FK, vID-FK, priceCode-FK, rentalFee, lateFee, date, dueDate, returnDate) 
-- Performs (vID-FK, aID-FK)
-- Here is the schema for these tables, with primary key underlined

-- write the CREATE TABLE statements to create the physical database structure
-- to hold the data for the Movie Rental Database.

-- Save your work as Yourname_lab2_2.sql


DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
  name       		VARCHAR(30) NOT NULL,
  email       		VARCHAR(30) NOT NULL UNIQUE,
  phone       		VARCHAR(30) NOT NULL,
  totalPurchase   	INT,
  
  CONSTRAINT email
    PRIMARY KEY(email)

);
DESCRIBE Customer;

DROP TABLE IF EXISTS Video;
CREATE TABLE Video
(

	vID       	INT NOT NULL UNIQUE AUTO_INCREMENT,
	name       	VARCHAR(30) NOT NULL,
	year       	YEAR NOT NULL,
	cost   		INT NOT NULL,
	genre   	VARCHAR(30) NOT NULL,
  
  CONSTRAINT vID
    PRIMARY KEY(vID)

);
DESCRIBE Video;

DROP TABLE IF EXISTS Actor;
CREATE TABLE Actor
(

	aID       	INT NOT NULL UNIQUE AUTO_INCREMENT,
	name       	VARCHAR(30) NOT NULL,
  
  CONSTRAINT aID
    PRIMARY KEY(aID)

);
DESCRIBE Actor;

DROP TABLE IF EXISTS Price;
CREATE TABLE Price
(

	priceCode	INT NOT NULL UNIQUE AUTO_INCREMENT,
	name		VARCHAR(30) NOT NULL,
  
  CONSTRAINT priceCode
    PRIMARY KEY(priceCode)

);
DESCRIBE Price;

DROP TABLE IF EXISTS Rents;
CREATE TABLE Rents
(
	email		VARCHAR(30) NOT NULL UNIQUE,
	vID			INT NOT NULL UNIQUE,
	priceCode	INT NOT NULL UNIQUE,
	rentalFee	INT NOT NULL,
	lateFee		INT NOT NULL,
    date 		DATE NOT NULL,
    dueDate		DATE NOT NULL,
    returnDate 	DATE,
  
  CONSTRAINT email
	FOREIGN KEY (email)
    REFERENCES Customer(email),
    
  CONSTRAINT vID
	FOREIGN KEY (vID)
    REFERENCES Video(vID),

	FOREIGN KEY (priceCode)
    REFERENCES Price(priceCode)
);
DESCRIBE Rents;
