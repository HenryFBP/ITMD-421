DROP DATABASE IF EXISTS testdb;
CREATE DATABASE testdb;
USE testdb;


DROP TABLE IF EXISTS department1;

CREATE TABLE department1(

	ID int NOT NULL,
    Age int,
		CHECK(Age >= 10 AND Age <= 70),
	Address char(10)
    

)

SELECT * FROM department1

/*hi*/