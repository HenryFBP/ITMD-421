-- Henry Post, Final Project, ITMD421

USE testdb;

-- 1.	Create the Person table.  Person(person_id,first_name,last_name) 
DROP TABLE IF EXISTS Person;
CREATE TABLE IF NOT EXISTS Person(
	person_id		INTEGER		NOT NULL	UNIQUE		AUTO_INCREMENT,
    first_name		VARCHAR(64) NOT NULL,
    last_name		VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (person_id)
    
);
DESCRIBE Person;

-- 2.	Create the Building table. Building (building_id,building_name)
DROP TABLE IF EXISTS Building;
CREATE TABLE IF NOT EXISTS Building(

	building_id		INTEGER		NOT NULL	UNIQUE		AUTO_INCREMENT,
    building_name	VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (building_id)
    
);
DESCRIBE Building;

-- 3.	Create the Room table. Room(room_id, room_number, building_ssid, capacity)
DROP TABLE IF EXISTS Room;
CREATE TABLE IF NOT EXISTS Room(

	room_id			INTEGER		NOT NULL	UNIQUE		AUTO_INCREMENT,
    room_number		INTEGER		NOT NULL,
    building_id		INTEGER		NOT NULL,
    capacity		INTEGER		NOT NULL,
    
    PRIMARY KEY (room_id),
    FOREIGN KEY (building_id) REFERENCES Building(building_id)
);	
DESCRIBE Room;

-- 4.	Create the Meeting table. Meeting (meeting_id,room_id,meeting_start,meeting_end)
DROP TABLE IF EXISTS Meeting;
CREATE TABLE IF NOT EXISTS Meeting(

	meeting_id		INTEGER		NOT NULL	UNIQUE		AUTO_INCREMENT,
    room_id			INTEGER		NOT NULL,
    meeting_start	DATE		NOT NULL,
    meeting_end		DATE		NOT NULL,
    
    PRIMARY KEY (meeting_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
DESCRIBE Meeting;

-- 5.	Create the Person-Meeting intersection table. Person_meeting(person_id,meeting_id)
DROP TABLE IF EXISTS Person_meeting;
CREATE TABLE IF NOT EXISTS Person_meeting(

	person_id		INTEGER		NOT NULL,
    meeting_id		INTEGER		NOT NULL,
    
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (meeting_id) REFERENCES Meeting(meeting_id)
);
DESCRIBE Person_meeting;

-- 6.	Insert the below data in the Person table
INSERT INTO Person (first_name, last_name) VALUES ('Tom','Hanks'), ('Anne','Hathaway'), ('Tom','Cruise'), ('Meryl','Streep'), ('Chris','Pratt'), ('Halle','Berry'), ('Robert','De Niro'),
												('Julia','Roberts'), ('Denzel','Washington'),('Melissa','McCarthy');
SELECT * FROM Person;

-- 7.	Insert the below data in the Building table
INSERT INTO Building (building_name) VALUES ('Headquarters'), ('Main Street Building');
SELECT * FROM Building;

-- 8.	Insert the below data in the Room table
INSERT INTO Room (room_number, building_id, capacity) VALUES (100, 1, 5), (200, 1, 4), (300, 1, 10), (10, 2, 4), (20, 2, 4);
SELECT * FROM Room;

-- 9.	Insert the below data in meeting table

INSERT INTO Meeting (room_id, meeting_start, meeting_end) VALUES (1, '2016-12-25 09:00:00', '2016-12-25 10:00:00'),(1, '2016-12-25 10:00:00', '2016-12-25 12:00:00'),
(1, '2016-12-25 11:00:00', '2016-12-25 12:00:00'),(2, '2016-12-25 09:00:00', '2016-12-25 10:00:00'),(4, '2016-12-25 09:00:00', '2016-12-25 10:00:00'),
(5, '2016-12-25 14:00:00', '2016-12-25 16:00:00');
SELECT * FROM Meeting;

-- 10.	Insert the below data in person_meeting table
INSERT INTO Person_meeting (person_id, meeting_id) VALUES (1, 1),(10, 1),(1, 2),(2, 2),(3, 2),(4, 2),(5, 2),(6, 2),(7, 2),(8, 2),(9, 3),(10, 3),(1, 4),(2, 4),(8, 5),(9, 5),(1, 6),(2, 6),(3, 6);
SELECT * FROM Person_meeting;

-- 11.	Find all the meetings that Tom Hanks has to attend
SELECT * FROM
	(SELECT p.person_id, p.first_name, p.last_name, pm.meeting_id
	FROM Person_meeting pm
	INNER JOIN Person p
	ON pm.person_id = p.person_id) AS result
WHERE first_name = 'Tom' AND last_name = 'Hanks';

-- 12.	Find all the people that are attending meeting ID 2
SELECT * FROM
	(SELECT p.person_id, p.first_name, p.last_name, pm.meeting_id
	FROM Person_meeting pm
	INNER JOIN Person p
	ON pm.person_id = p.person_id) AS result
WHERE meeting_id = 2;

-- 13.	Find all the people who have meetings in the Main Street building
SELECT
	RES.first_name, RES.last_name, RES.building_name
FROM
	(
	SELECT
		RES.person_id, RES.first_name, RES.last_name, RES.meeting_id, RES.room_id, RES.room_number, b.building_name FROM
		(
		SELECT RES.person_id, RES.first_name, RES.last_name, RES.meeting_id, RES.room_id, room_number, building_id FROM 
			(
			SELECT RES.person_id, RES.first_name, RES.last_name, RES.meeting_id, room_id FROM 
				(
				SELECT p.person_id, p.first_name, p.last_name, pm.meeting_id 
				FROM Person_meeting pm
				INNER JOIN Person p
				ON pm.person_id = p.person_id -- get people's meeting IDs
				)
				AS RES
			INNER JOIN meeting m
			ON res.meeting_id = m.meeting_id -- get those meeting ID room IDs
			)
			AS RES
		INNER JOIN Room r
		ON r.room_id = RES.room_id -- get the room ID building IDs
		)
		AS RES
	INNER JOIN Building b
	ON b.building_id = RES.building_id -- get the building ID names
    )
    AS RES
WHERE building_name = 'Main Street Building'; -- get buildings that are main street


-- 14.	Find the number of attendees for every meeting
SELECT * FROM (
	SELECT
		*,
		COUNT(*) as number_people
	FROM
		Person_meeting pm
	GROUP BY
		meeting_id
	) AS pm
JOIN
	meeting m
ON
	pm.meeting_id = m.meeting_id;


-- 15.	Find All of the People that Have Meetings Only Before Dec. 25, 2016 at Noon Using INNER JOINs

SELECT
	*
FROM
(
	SELECT
		person_id, first_name, last_name, RES.meeting_id, meeting_start
	FROM
		(
		SELECT
			p.person_id, p.first_name, p.last_name, pm.meeting_id 
		FROM
			Person_meeting pm
		INNER JOIN Person p
		ON pm.person_id = p.person_id -- get people's meeting IDs
		) AS RES
	INNER JOIN
		meeting m
	ON RES.meeting_id = m.meeting_id
) AS RES
WHERE
	RES.meeting_start <= DATE('2016-12-25 12:00:00');
        