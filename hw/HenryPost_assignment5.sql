-- Henry Post, hpost@hawk.iit.edu, HW 5, ITMD421

SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS hw5;
CREATE DATABASE IF NOT EXISTS hw5;

USE hw5;

-- You are given the below database
-- employee(employee-name, street, city) 
-- works(employee-name, company-name, salary) 
-- company(company-name, city) 
-- manages(employee-name, manager-name)


DROP TABLE IF EXISTS employee;
CREATE TABLE employee
(
	employee_name       VARCHAR(30) NOT NULL UNIQUE,
	street       		VARCHAR(30) NOT NULL,
	city       			VARCHAR(30) NOT NULL,
  
	PRIMARY KEY(employee_name)

);
DESCRIBE employee;


DROP TABLE IF EXISTS works;
CREATE TABLE works
(
	employee_name       VARCHAR(30) NOT NULL UNIQUE,
	company_name       	VARCHAR(30) NOT NULL,
	salary       		INTEGER,
    
	PRIMARY KEY(employee_name)

);
DESCRIBE works;


DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	company_name		VARCHAR(30) NOT NULL UNIQUE,
	city       			VARCHAR(30) NOT NULL,
  
	PRIMARY KEY(company_name)

);
DESCRIBE company;


DROP TABLE IF EXISTS manages;
CREATE TABLE manages
(
	manager_name  		VARCHAR(30) NOT NULL,
	employee_name       VARCHAR(30) NOT NULL,
  
	PRIMARY KEY(employee_name, manager_name)

);
DESCRIBE manages;



INSERT INTO employee VALUES('Henry',		'123 Street',	'Kitty City');
INSERT INTO employee VALUES('Max',			'456 Street',	'Kitty City');
INSERT INTO employee VALUES('Grenry',		'666 Street',	'Shitty City');
INSERT INTO employee VALUES('Grax',			'999 Street',	'Shitty City');
INSERT INTO employee VALUES('Glurg',		'??? Street',	'Alien City');
INSERT INTO employee VALUES('Gleeb',		'!!! Street',	'Alien City');
INSERT INTO employee VALUES('Overlord',		'!!! Street',	'Alien City');
INSERT INTO employee VALUES('God',			'Jesus Street',	'God City');
INSERT INTO employee VALUES('Smallman',		'Tiny Street',	'Teeny City');
INSERT INTO employee VALUES('Smallwoman',	'Tiny Street',	'Teeny City');

INSERT INTO manages VALUES('God',		'Overlord');
INSERT INTO manages VALUES('Overlord',	'Henry');
INSERT INTO manages VALUES('Overlord',	'Max');
INSERT INTO manages VALUES('Overlord',	'Grenry');
INSERT INTO manages VALUES('Overlord',	'Grax');
INSERT INTO manages VALUES('Overlord',	'Glurg');
INSERT INTO manages VALUES('Overlord',	'Smallman');
INSERT INTO manages VALUES('Overlord',	'Smallwoman');


INSERT INTO works VALUES('Henry',		'First Bank Corporation',	10001);
INSERT INTO works VALUES('Max',			'First Bank Corporation',	10002);
INSERT INTO works VALUES('Grenry',		'First Bank Corporation',	9996);
INSERT INTO works VALUES('Grax',		'Second Bank Corporation',	10000);
INSERT INTO works VALUES('Glurg',		'Second Bank Corporation',	-2000);
INSERT INTO works VALUES('Gleeb',		'Mystery Bank Corporation',	-20000);
INSERT INTO works VALUES('Smallman',	'Small Bank Corporation',	4999);
INSERT INTO works VALUES('Smallwoman',	'Small Bank Corporation',	4999);


INSERT INTO company VALUES('First Bank Corporation',	'Shitty City');
INSERT INTO company VALUES('Second Bank Corporation',	'Kitty City');
INSERT INTO company VALUES('Mystery Bank Corporation',	'Alien City');
INSERT INTO company VALUES('Small Bank Corporation',	'Teeny City');

-- Give an expression in SQL for each of the following queries:

-- 1.	Find the names, street address, and cities of residence for all employees who 
-- 		work for 'First Bank Corporation' and earn more than $10,000.

SELECT e.employee_name, e.street, e.city FROM employee e 

JOIN works w
	ON e.employee_name = w.employee_name -- get the company name and salary in same table
WHERE 
	(company_name LIKE 'First Bank Corporation')
		AND
    (salary > 10000);


-- 2.	Find the names of all employees in the database who
-- 		live in the same cities as the companies for which they work.


SELECT * FROM employee e 
	JOIN works w
		ON e.employee_name = w.employee_name 	-- get the company name and salary in same table
	JOIN company c
		ON c.company_name = w.company_name 		-- get company city and person's city in same table
WHERE c.city = e.city;


-- 3.	Find the names of all employees in the database who
-- 		live in the same cities and on the same streets as do their managers

SELECT 	e.employee_name 		AS employee_name, 
		manEmp.employee_name 	AS manager_name
        
FROM employee e 

JOIN manages m
	ON e.employee_name = m.employee_name 		-- get manager and subordinate in same table
JOIN employee manEmp
	ON m.manager_name = manEmp.employee_name		-- get manager home address
WHERE e.city = manEmp.city;

-- 4.	Find the names of all employees in the database who 
-- 		do not work for 'First Bank Corporation'. Assume that all people work for exactly one company

SELECT e.employee_name FROM employee e 

JOIN works w
	ON e.employee_name = w.employee_name 	-- get the company name and person
JOIN company c
	ON c.company_name = w.company_name 		-- get company name and person's company's name in same table
WHERE c.company_name != 'First Bank Corporation';


-- 5.	Find the names of all employees in the database who 
-- 		earn more than every employee of 'Small Bank Corporation'.
-- 		Assume that all people work for at most one company.

SELECT * FROM employee e 

JOIN works w
	ON e.employee_name = w.employee_name -- get the company name and salary in same table
WHERE 
    (salary > 10000);

-- I can add up all salaries and group by salary > 10000, but I don't know how to combine these two statements...
    
SELECT SUM(salary) FROM employee e  -- this adds up all "small bank corp" people's cash
JOIN works w
	ON e.employee_name = w.employee_name
WHERE w.company_name = 'Small Bank Corporation';



-- 6.	Assume that the companies may be located in several cities.
-- 		Find all companies located in every city in which 'Small Bank Corporation' is located.

-- Wasn't sure how to do these last two.

-- 7.	Find the names of all employees who earn more than 
-- 		the average salary of all employees of their company.
-- 		Assume that all people work for at most one company.










