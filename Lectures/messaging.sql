SET SQL_SAFE_UPDATES = 0;


/* =========================
Create the Messaging database. 
Database Name: messaging
========================= */
DROP DATABASE IF EXISTS messaging;
CREATE DATABASE IF NOT EXISTS messaging;

/* Use the new Messaging database that was created. */
USE messaging;

/* =========================
Create the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id INT(8) NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;







/* =========================
Create the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id INT(8) NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
    contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

/* =========================
Create the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id INT(8) NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
    receiver_id INT(8) NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime DATETIME NOT NULL,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;

/* =========================
Populate the Person table. 
========================= */
INSERT INTO person (first_name, last_name)
VALUES
("Michael", "Phelps"),
("Katie", "Ledecky"),
("Usain", "Bolt"),
("Allyson", "Felix"),
("Kevin", "Durant"),
("Diana", "Taurasi");


/* =========================
Populate the Contact List table. 
========================= */
INSERT INTO contact_list (person_id, contact_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(2, 4),
(3, 1),
(3, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 6);

/* =========================
Populate the Message table. 
========================= */
INSERT INTO message (sender_id, receiver_id, message, send_datetime)
VALUES
(1, 2, "Congrats on winning the 800m Freestyle!", "2016-12-25 09:00:00"),
(2, 1, "Congrats on winning 23 gold medals!", "2016-12-25 09:01:00"),
(3, 1, "You're the greatest swimmer ever", "2016-12-25 09:02:00"),
(1, 3, "Thanks!  You're the greatest sprinter ever", "2016-12-25 09:04:00"),
(1, 4, "Good luck on your race", "2016-12-25 09:05:00");

/* ========================= Verify Results ========================= */

/* Show all of the tables in the database */
SHOW tables;

ALTER TABLE person ADD favorite_color varchar(10);
INSERT INTO person(first_name, last_name, favorite_color) VALUES("Henry","Post","purple");


DELETE FROM person WHERE (first_name = 'Diana' AND last_name = 'Taurasi');
ALTER TABLE contact_list ADD favorite varchar(20);

INSERT INTO person(first_name, last_name, favorite_color) VALUES
("Grenry","Grost","Grurple"),
("Jake","McRake","blue"),
("????","!!!!","seven");



/* =========================
Show the details for each of the tables created. 
DESCRIBE and SHOW COLUMNS FROM will do the same thing.
i.e. DESCRIBE table_name;
     SHOW COLUMNS FROM table_name;
========================= */
select * from person;
select * from contact_list;
select * from message;



SELECT 
    sender_id,
	first_name AS sender_first_name, 
    last_name AS sender_last_name,
    receiver_id,
    p.first_name AS reciever_first_name
    
FROM message AS m

INNER JOIN person AS p ON m.sender_id = p.person_id;

SELECT 

*
    
FROM 

message AS m

INNER JOIN person as p on m.sender_id = p.person_id



