-- Henry Post, hpost@hawk.iit.edu, Assignment 3, ITMD421

DROP DATABASE IF EXISTS zoo;
CREATE DATABASE IF NOT EXISTS zoo;

Use zoo;

-- Drop all the tables to clean up
DROP TABLE  IF EXISTS Animal;

-- ACategory: Animal category 'common', 'rare', 'exotic'.  May be NULL
-- TimeToFeed: Time it takes to feed the animal (hours)
CREATE TABLE Animal
(
  AID       INT(3),
  AName      VARCHAR (30) NOT NULL,
  ACategory VARCHAR (18),
  TimeToFeed INT(4),  
  
  CONSTRAINT Animal_PK
    PRIMARY KEY(AID)
);
INSERT INTO Animal VALUES(1, 'Galapagos Penguin', 'exotic', 1);
INSERT INTO Animal VALUES(2, 'Emperor Penguin', 'rare', 1);
INSERT INTO Animal VALUES(3, 'Sri Lankan sloth bear', 'exotic', 3);
INSERT INTO Animal VALUES(4, 'Grizzly bear', 'common', 3);
INSERT INTO Animal VALUES(5, 'Giant Panda bear', 'exotic', 2);
INSERT INTO Animal VALUES(6, 'Florida black bear', 'rare', 2);
INSERT INTO Animal VALUES(7, 'Siberian tiger', 'rare', 4);
INSERT INTO Animal VALUES(8, 'Bengal tiger', 'common', 3);
INSERT INTO Animal VALUES(9, 'South China tiger', 'exotic', 3);
INSERT INTO Animal VALUES(10, 'Alpaca', 'common', 1);
INSERT INTO Animal VALUES(11, 'Llama', NULL, 4);
INSERT INTO Animal VALUES(12, 'Llama2', 'commonn', 2);


/*

Since none of the managers in the zoo know SQL, it is up to you to write the queries to answer the following list of questions.
1.	Find all the animals (their names) that take less than 3 hours to feed.
2.	Find all the rare animals.
3.	Find the animal names and categories for animals related to a bear (hint: use the LIKE operator)
4.	Find the rarity rating of all animals that require between 1 and 3 hours to be fed
5.	Find the names of the animals that are related to the tiger and are not common
6.	Find the names of the animals that are not related to the tiger



*/

-- 1.	Find all the animals (their names) that take less than 3 hours to feed. 
SELECT AName
FROM Animal
WHERE (TimeToFeed < 3);


-- 2.	Find all the rare animals. 
SELECT *
FROM Animal
WHERE ACategory = 'rare';


-- 3.	Find the animal names and categories for animals related to a bear (hint: use the LIKE operator)
SELECT AName, ACategory
FROM Animal
WHERE AName LIKE '%bear%';


-- 4.	Find the rarity rating of all animals that require between 1 and 3 hours to be fed
SELECT ACategory
FROM Animal
WHERE (TimeToFeed >= 1 AND TimeToFeed <= 3);


-- 5.	Find the names of the animals that are related to the tiger and are not common
SELECT AName
FROM Animal
WHERE (AName LIKE '%tiger%') AND (ACategory != 'common');


-- 6.	Find the names of the animals that are not related to the tiger
SELECT AName
FROM Animal
WHERE (AName NOT LIKE '%tiger%');


SELECT * FROM ANIMAL WHERE (Acategory LIKE 'common');
