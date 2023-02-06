-- _______________________________________________DAY_01_________________________________________________________ 
use hr;  -- using schema

select * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES;

-- TCL COMMAND BASIC 



SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES
WHERE EMPLOYEE_ID=100;

-- UPDATE SALARY OF EMPLOYEE_ID=100
UPDATE EMPLOYEES
SET SALARY=26000*0.5
WHERE EMPLOYEE_ID=100;

COMMIT; -- FOR SAVING UPDATED INFO.
-- NOW CHECK SALRY IS UPDATED OR NOT
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES
WHERE EMPLOYEE_ID=100;
set autocommit=0;
start transaction;
rollback;


SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY FROM EMPLOYEES
WHERE SALARY>5000 AND JOB_ID="IT_PROG";

-- select the query where job id is 'IT-PROG' OR empplyes's salary is graeter than 5000 that's MANAGER ID is 100.
SELECT EMPLOYEE_ID, FIRST_NAME,MANAGER_ID, JOB_ID, SALARY FROM EMPLOYEES
WHERE (JOB_ID="IT_PROG" OR SALARY>5000) AND MANAGER_ID=100;

-- IN OPERATOR
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE JOB_ID IN('IT_PROG', 'SA_MAN', 'SA_REP');

-- BETWEEN OPERATOR
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE SALARY between 14000 AND 15000;

-- WILDCARD SEARCH
-- LIKE OPERATOR
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%P';
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';
-- NOT LIKE OPERATOR
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE 'S%';
-- or we can write it like this also
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE NOT FIRST_NAME  LIKE 'S%';
use hr;
-- UNDERSCORE OPEARTOR
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'J__ES'; -- WE USE 2 UNDERSOCRE HERE

-- ORDER BY
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, MANAGER_ID FROM EMPLOYEES
ORDER BY SALARY DESC;

-- SORTING OF TWO COLUMN TOGETHER
SELECT * FROM EMPLOYEES
ORDER BY SALARY, DEPARTMENT_ID DESC;

-- group by
select job_id, sum(salary) from employees
group by job_id;

-- EXTRACTING NULL VALUES
SELECT * FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

SELECT * FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;


--        -----------------------------------DAY _04---------------------------------------------------
use hr;
SELECT * FROM EMPLOYEES;

--  ifnull(col_name, value)
SELECT EMPLOYEE_ID EMP_ID, FIRST_NAME, JOB_ID, COMMISSION_PCT, IFNULL(COMMISSION_PCT, 0) AS UPDATED_COMMISSION FROM 
EMPLOYEES;

-- COALSCE WHICH FILLS NULL VALUES BY COL VALUES WHICH ARE NOT NULL AND TAKES MULTIPLE ARGUMENTS
select * FROM LOCATIONS;

SELECT * FROM LOCATIONS
WHERE STATE_PROVINCE IS NULL  OR CITY IS NULL;

-- CHECK FOR NULL VALUES
SELECT * FROM LOCATIONS    
WHERE STATE_PROVINCE IS NULL;

-- FILL THIS NULL VALUES

SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COALESCE(STATE_PROVINCE, CITY,
 POSTAL_CODE, STREET_ADDRESS) UPDATED_DATA FROM LOCATIONS;

-- ___________________________________________DAY_04________________________________________________________________

-- CRETE A NEW TABLE NAMED "TRAININIG" IN HR SCHEMA
CREATE TABLE TRAINING(
EMP_ID INT UNSIGNED,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
JOB_ID VARCHAR(20),
SALARY DECIMAL(10,2),
HIRED DATE);

select * FROM TRAINING;

-- ALTER ( TO ADD NEW COLUMN IN EXISTING COL)
ALTER TABLE TRAINING ADD COLUMN PHONE_NUM VARCHAR(12);
-- ADD MIDDLE NAME COLUMN  AFTER FIRST NAME COLUMN
ALTER TABLE TRAINING ADD COLUMN MIDDLE_NAME VARCHAR(15) AFTER FIRST_NAME;
select * FROM TRAINING;

-- DROP COLUMNS
ALTER TABLE TRAINING DROP  MIDDLE_NAME, DROP PHONE_NUM;
select * FROM TRAINING;

-- RENAME COL NAME
ALTER TABLE TRAINING RENAME COLUMN LAST_NAME TO SURNAME;
select * FROM TRAINING;

-- MODIFYING DATA TYPES
ALTER TABLE TRAINING MODIFY COLUMN SALARY INT(12);
DESC TRAINING;

-- DELETE THE TABLE NAMED TRAINING FROM THE DATABASE
DROP TABLE TRAINING;

-- COPY OR CREATE A TABLE NAMED " TRAINING" AGAIN FROM  A EXISTING TABLE "EMPLOYEES" FROM HR SCHEMA
CREATE TABLE TRAINING AS (SELECT * FROM EMPLOYEES);
SELECT * FROM TRAINING;

-- TRUNCATE (DELETE ALL ROWS BUT TABLE STILL EXISTS)
TRUNCATE TRAINING;
SELECT * FROM TRAINING;

-- RENAMING THE TABLE NAME
RENAME TABLE TRAINING TO TRAINING_NEW;


drop table training_new;
-- ______________________________________________DAY_05___________________________________________________________
 
 -- DML STATMENTS
 -- TCL STATMENTS
use hr;

SET AUTOCOMMIT=0; -- AUTOCOMMIT OR AUTOSAVE WILL NOT OCCUR NOW
CREATE TABLE TR_DML AS (SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY FROM TRAINING_NEW);
SELECT * FROM TR_DML;

-- INSERT COMMAND
use hr;
INSERT INTO TR_DML VALUES(101, 'SHRAWAN', 'KUMAWAT', 'DS', 100000);
COMMIT; -- SAVE THE YOUR ACTIONS
-- INSERT MULTIPLE ROWS
INSERT INTO TR_DML VALUES
(102, 'SANDEEP', 'KUMAWAT', 'CO', 400000),
(103, 'ANKIT', 'SAIN', 'IAS', 500000),
(104, 'LAXMAN', 'KUMWAT', 'SALES', 80000);
COMMIT;
SELECT * FROM TR_DML;

-- INSERTION INTO ONLY SPECIFIED COL

INSERT INTO TR_DML (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY) VALUES
(105, 'RAM', 'KUMAR', 'CIVIL', 100000),
(106, 'MEENA', 'DEVI', 'TAILOR', 20000);
SELECT * FROM TR_DML;

-- DELETE ROW
SET AUTOCOMMIT=0;
START transaction;

DELETE FROM TR_DML
WHERE EMPLOYEE_ID=103;
ROLLBACK;


-- UPDATE COMMAND
SELECT * FROM EMPLOYEES;

UPDATE EMPLOYEES
SET salary=50000
WHERE EMPLOYEE_ID=102;
-- NOW U CAN USE COMMIT AND ROLLBACK 
ROLLBACK;
update EMPLOYEES
SET salary=30000
WHERE EMPLOYEE_ID=101;
ROLLBACK;
SELECT * FROM EMPLOYEES;

-- DELETE COMMAND
DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID=100;

SET FOREIGN_KEY_CHECKS=0;
SELECT * FROM EMPLOYEES;
ROLLBACK;

DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID=101;
COMMIT;

-- AGAIN INSERT DELETED ROW , BECOZ WE DONE COMMIT SO THEY HAVE BEEN DELETED PERAMANAETLY
USE HR;
INSERT INTO EMPLOYEES VALUES (100, 'SHRAWAN', 'KUMAR', 'SHRAKUMAR', '256.123.5648', '1991-01-15', 'DS', 50000, NULL, 100, 90);
COMMIT;
INSERT INTO EMPLOYEES VALUES (101, 'SANDEEP', 'KUMAR', 'SANDKUMAR', '254.123.5648', '1981-01-15', 'DS', 40000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (102, 'LAXMAN', 'KUMAR', 'LAXMKUMAR', '254.143.5648', '1996-01-11', 'SA', 30000, NULL, 100, 90);
COMMIT;
SELECT * FROM EMPLOYEES;

-- SAVEPOINT (TCL COMMANDS)
DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID=100;
savepoint A;

DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID=101;
SAVEPOINT B;
ROLLBACK TO A;
SELECT * FROM EMPLOYEES;

ROLLBACK; -- TO GET EVERYTHING GET BACK
use hr;
-- IF ELSE(CASE WHEN AND THEN EXPRESSION)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY,
CASE JOB_ID WHEN 'IT_PROG' THEN  SALARY*0.5+SALARY
            WHEN 'SA_MAN' THEN  SALARY*0.1+SALARY
			WHEN 'SA_REP' THEN  SALARY*0.2+SALARY
            ELSE SALARY
            END  UPDATED_SALARY
            FROM EMPLOYEES;
            
-- OTHER EXAMPLE
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY,
CASE JOB_ID WHEN 'DS' THEN SALARY*2
			ELSE SALARY
            END NEW_SALARY
            FROM EMPLOYEES;
            
-- THERE IS NO CHANGED IN ORIGINAL DATA BECOZ ITS A SELECT QUERY WHICH IS NOT AUTOSAVED
-- LET'S SEE THE ORIGINAL DATA
SELECT * FROM EMPLOYEES;

-- SEARCHED CASE EXPRESSION 
USE HR;
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY,
CASE  WHEN JOB_ID ='IT_PROG' THEN  SALARY*0.5+SALARY
            WHEN JOB_ID ='SA_MAN' THEN  SALARY*0.1+SALARY
			WHEN JOB_ID ='SA_REP' THEN  SALARY*0.2+SALARY
            WHEN EMPLOYEE_ID=100 THEN SALARY-1000
            ELSE SALARY
            END  UPDATED_SALARY
            FROM EMPLOYEES;
            
-- UPDATION OF SALRY IN ACTUAL DATBASE
UPDATE EMPLOYEES
SET SALARY=(CASE JOB_ID WHEN 'IT_PROG' THEN  SALARY*0.5+SALARY
            WHEN 'SA_MAN' THEN  SALARY*0.1+SALARY
            WHEN 'DS' THEN  2*SALARY
			WHEN 'SA_REP' THEN  SALARY*0.2+SALARY
            ELSE SALARY
            END );
SELECT * FROM EMPLOYEES;



-- ____________________________________________________DAY_06_____________________________________________________
-- CONSTRAINTS(NOT NULL, UNIQUE, DEFAULT, CHECK, PRIMARY KEY, FOREINGN KEY)
use hr;

-- NOT NULL

CREATE TABLE M_N(
EMP_ID INT UNSIGNED NOT NULL,
FIRST_NAME VARCHAR(50),
SALARY INT UNSIGNED);

SELECT * FROM m_n;

INSERT INTO M_N VALUES(100, 'SHRAWAN',50000);
INSERT INTO M_N(FIRST_NAME, SALARY) VALUES('LAXMAN', 40000);
-- ERROR : 'EMP_ID' DOES NOT HAVE A DEFAILT values

-- DEFAULT
CREATE TABLE M_N1(
EMP_ID INT UNSIGNED NOT NULL DEFAULT 0,
FIRST_NAME VARCHAR(50),
SALARY INT UNSIGNED);

SELECT * FROM m_n1;



INSERT INTO M_N1 VALUES(100, 'SHRAWAN',50000);
INSERT INTO M_N1(FIRST_NAME, SALARY) VALUES('LAXMAN', 40000);
SELECT * FROM M_N1;
drop TABLE M_N1;

-- AUTO_INCREMENT
CREATE TABLE M_N1(
EMP_ID INT UNSIGNED primary KEY AUTO_INCREMENT,
FIRST_NAME VARCHAR(50),
SALARY INT UNSIGNED);

ALTER TABLE M_N1 AUTO_INCREMENT=100;
INSERT INTO M_N1(FIRST_NAME, SALARY) VALUES('LAXMAN', 40000),
                                            ('SHRAWAN', 20000),
                                            ('SANDEEP', 150000),
                                            ('ANKIT', 120251);
SELECT * FROM m_n1;
DROP TABLE M_N1;

-- UNIQUE
CREATE TABLE M_N1(
EMP_ID INT UNSIGNED NOT NULL UNIQUE,
FIRST_NAME VARCHAR(50),
SALARY INT UNSIGNED);
INSERT INTO M_N1 VALUES(100, 'SHRAWAN',50000),
						(100,'LAXMAN', 40000),
                                            (100,'SHRAWAN', 20000),
                                            (100,'SANDEEP', 150000),
                                            (100,'ANKIT', 120251);
	-- GET ERROR BCOZ EMP_ID MUST BE UNIQUE.
-- DROP UNIQUE CONSTRAINT FROM EMP_ID
ALTER TABLE M_N1 DROP constraint EMP_ID;
-- NOW WE CAN INSERT ABOVE ROWS.
SELECT * FROM m_n1;


-- applying constarint on multiple columns
-- CREATING A NEW TABLE(T6) 
CREATE TABLE T6(
EMP_ID INT UNSIGNED NOT NULL UNIQUE,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30),
UNIQUE(FIRST_NAME, LAST_NAME));
INSERT INTO T6 VALUES(105, 'SHRAWAN', 'KUMAWAT'),
						(101,'LAXMAN', 'VERMA'),
                                            (102,'SHRBT', 'PARIK'),
                                            (103,'SANDEEP', 'SHARMA'),
                                            (104,'ANKIT', 'SAIN');
SELECT * FROM T6;
DROP TABLE T6;
INSERT INTO T6 VALUES(101, 'PARDHAAN', 'KUMAWAT');

-- CHECKING CONSTRAINT INFO.
select COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME='T6';

-- ADD CONSTRINT TO AN EXIXTING TABLE
USE HR;
CREATE TABLE T7(
EMP_ID INT UNSIGNED NOT NULL,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30));

-- NOW ADD CONSTRAINT
ALTER TABLE T7 ADD UNIQUE(EMP_ID, FIRST_NAME, LAST_NAME);
select COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME='T7';
DROP TABLE T7;

-- PRIMARY KEY
USE HR;
CREATE TABLE T8(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30));
select COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME='T8';

-- MAKING PRIMARY KEY USING MULTIPLE COL
CREATE TABLE T9(
EMP_ID INT UNSIGNED ,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30),
PAN_NO VARCHAR(10),
PRIMARY KEY(EMP_ID, Pan_no));
select COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME='T9';

-- add primary key after table creation
-- drop primary key

-- drop the all extra tables we created to learn 
drop table m_n;
drop table TR_DML;
drop table TRAINING_NEW;
drop table m_n1;
drop table t6;
drop table t8;
drop table t9;
drop table tr_dml;
drop table training_new;

-- now we have our original tables in our hr database

-- Foreign key
-- CREATE TABLE E1

CREATE TABLE E1(
EMP_ID INT UNSIGNED  primary key,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30),
SALARY DECIMAL(8,2),
DEPT_ID INT UNSIGNED,
foreign key(DEPT_ID) REFERENCES D1(DEPT_ID));

--  CREATE TABLE D1
-- DROP TABLE D1;
CREATE TABLE D1(
DEPT_ID INT unsigned primary KEY,
DEPT_NAME VARCHAR(20));

-- HERE, TABLE D1 IS PARENT TABLE AND E1 is CHILD TABLE
select COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME='e1';

-- insertion in child table
-- so first we have to insert in parent table
INSERT INTO D1 VALUES(60, 'DS');
INSERT INTO E1 VALUES(100, 'SHRAWAN', 'KUMAR', 100000, 60);

SELECT * FROM E1;
SELECT * FROM D1;
DROP TABLE E1;
DROP TABLE D1;

-- UPDATE AND DELETION
-- ON DELETE CASCADE
-- ON DELETE SET NULL
-- ON UPDATE CASCADE

-- CREATE TABLE E1
CREATE TABLE E1(
EMP_ID INT UNSIGNED  primary key,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(30),
SALARY DECIMAL(8,2),
DEPT_ID INT UNSIGNED,
foreign key(DEPT_ID) REFERENCES D1(DEPT_ID) ON DELETE cascade ON UPDATE cascade);

--  CREATE TABLE D1
CREATE TABLE D1(
DEPT_ID INT unsigned primary KEY,
DEPT_NAME VARCHAR(20));

INSERT INTO D1 VALUES(60, 'DS');
INSERT INTO E1 VALUES(100, 'SHRAWAN', 'KUMAR', 100000, 60);

-- UPDATE
UPDATE D1
SET DEPT_ID=90
WHERE DEPT_ID=60;

SELECT * FROM E1;
SELECT * FROM D1;

-- DELETE
DELETE FROM D1
WHERE DEPT_ID=90;

-- INSERTION INTO CHILD TABLE WITHOUT INSERTING IN PARENT TABLE
INSERT INTO E1 VALUES(101, 'SHRAWAN', 'KUMAR', 100000, NULL);
INSERT INTO E1(EMP_ID, FIRST_NAME, LAST_NAME, SALARY) VALUES(102, 'SHRAWAN', 'KUMAR', 100000);
SELECT * FROM E1;
SELECT * FROM d1;

-- -----------------------------------------DAY_07------------------------------------------------------------------
-- check constraint, joins(inner, outer, full, self, left, right)

-- create a new database called 'Assignment'
create database assigment;
USE ASSIGNMENT;

-- now create tables in this database
CREATE TABLE B1(
DEPT_ID INT UNSIGNED PRIMARY KEY,
DEPT_NAME VARCHAR(30));

CREATE TABLE A1(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(30),
LAST_NAME VARCHAR(30),
DEPT_ID INT UNSIGNED,
constraint A1_FK foreign key(DEPT_ID) references B1(DEPT_ID) ON delete SET NULL ON UPDATE cascade);

INSERT INTO A1 VALUES(100, 'SHRAWAN', 'KUMAWAT', NULL); -- WE CAN INSERT PUTTING DEPT_ID NULL WHICH IS OUR 
                                                        -- FOREIGN KEY
SELECT * FROM A1;
INSERT INTO A1 VALUES(101, 'SHRAWAN', 'KUMAWAT', 60);     -- CAN NOT INSERT

SET FOREIGN_KEY_CHECKS=0; -- DISABLING FOEREIGN KEY  CONSTRAINT  
INSERT INTO A1 VALUES(102, 'SHRAWAN', 'KUMAWAT', 80);  
INSERT INTO A1 VALUES(103, 'SHRAWAN', 'KUMAWAT', 100);                                   
SELECT * FROM A1;
SELECT * FROM B1;
SET FOREIGN_KEY_CHECKS=1;
INSERT INTO A1 VALUES(104, 'SHRAWAN', 'KUMAWAT', 120);   -- CAN'T INSERT NOW


-- CHECK CONSTRINTS
CREATE TABLE A2(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(30),
LAST_NAME VARCHAR(30),
AGE INT UNSIGNED CHECK (AGE>18),
GENDER VARCHAR(15),
DEPT_ID INT UNSIGNED,
CHECK(GENDER IN( 'MALE', 'FEMALE', 'UNKNOWN'))
);

INSERT INTO A2 VALUES(100, 'RAJUI', 'AGARAWAL', 19, 'TRANSGENDER', 60);  -- CAN NOT INSERT 
INSERT INTO A2 VALUES(100, 'RAJUI', 'AGARAWAL', 19, 'MALE', 60); -- INSERTED


ALTER TABLE A2 ADD CONSTRAINT CHECK (DEPT_ID<10000);
INSERT INTO A2 VALUES(101, 'RAJUI', 'AGARAWAL', 29, 'MALE', 62332); -- NOT INESERTED
INSERT INTO A2 VALUES(101, 'RAJUI', 'AGARAWAL', 29, 'MALE', 9999);
select * FROM A2;

-- JOINS
-- INNER JOIN

USE HR;

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, department_name FROM EMPLOYEES
INNER JOIN
DEPARTMENTS -- TABLE 2
USING(DEPARTMENT_ID);

-- when we execute above query we find that result only consists column from employyes table only. but we want 
-- to show the columns from both tables then
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, department_name, location_id
 FROM EMPLOYEES
INNER JOIN
DEPARTMENTS -- TABLE 2
USING(DEPARTMENT_ID);

-- we can also write above query like this
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, departments.department_name,
departments.location_id
 FROM EMPLOYEES
INNER JOIN
DEPARTMENTS -- TABLE 2
USING(DEPARTMENT_ID);


-- METHOD -2 USING "ON" OPEARTOR

SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, EMPLOYEES.HIRE_DATE, EMPLOYEES.JOB_ID,
EMPLOYEES.DEPARTMENT_ID FROM EMPLOYEES
INNER JOIN
DEPARTMENTS -- TABLE 2
ON EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID;

-- we can write like this also
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID,
EMPLOYEES.DEPARTMENT_ID FROM EMPLOYEES
INNER JOIN
DEPARTMENTS -- TABLE 2
ON EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID;



-- LEFT OUTER JOIN/ LEFT JOIN

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES -- LEFT TABLE
LEFT join
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
USING(DEPARTMENT_ID);

-- RIGHT OUTER JOIN

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
 FROM EMPLOYEES -- LEFT TABLE
RIGHT OUTER JOIN
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
USING(DEPARTMENT_ID);

-- FULL JOIN
use hr;
select * from employees;
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
 FROM EMPLOYEES -- LEFT TABLE
FULL JOIN
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
USING(DEPARTMENT_ID);
-- IT WILL GIVE THE RESULT LIKE INNER JOIN

-- FOR ALL RECORDS 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
 FROM EMPLOYEES -- LEFT TABLE
LEFT JOIN
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
USING(DEPARTMENT_ID)
UNION      -- TAKING UNION OF LEFT AND RIGHT JOIN
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
 FROM EMPLOYEES -- LEFT TABLE
RIGHT JOIN
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
USING(DEPARTMENT_ID);

-- PERFORM JOINS USING 'ON' CLAUSE
SELECT  * FROM DEPARTMENTS;
ALTER TABLE DEPARTMENTS RENAME COLUMN DEPARTMENT_ID TO DEPT_ID;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
 FROM EMPLOYEES -- LEFT TABLE
INNER JOIN
DEPARTMENTS -- TABLE 2 OR RIGHT TABLE
ON (EMPLOYEES.DEPARTMENt_ID=DEPARTMENTS.DEPT_ID);

-- SELF JOIN
SELECT CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) EMPLOYEE_NAME,
       CONCAT(M.FIRST_NAME, ' ', M.LAST_NAME) MANAGER_NAME FROM EMPLOYEES E
       JOIN
       EMPLOYEES M
       ON(M.MANAGER_ID=E.EMPLOYEE_ID);
       
       -- LOGIACLLY WRONG BECOZ A SINGLE PERSON IS REPORTING TO DIFF. MANAGER
       
       SELECT CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) EMPLOYEE_NAME,
       CONCAT(M.FIRST_NAME, ' ', M.LAST_NAME) MANAGER_NAME FROM EMPLOYEES E
       JOIN
       EMPLOYEES M
       ON(M.EMPLOYEE_ID=E.MANAGER_ID);
       
       
       -- ------------------------------------------DAY_08---------------------------------------------------------
-- CROSS JOIN, AGGREGATE FUNCTION, STORED PROCEDURE

-- CROSS JOIN
USE HR;
SELECT * FROM EMPLOYEES;
SELECT * FROM  DEPARTMENTS;

SELECT * FROM EMPLOYEES
CROSS JOIN
DEPARTMENTS;

-- or this query also will give the result same as cross join
select * from employees, departments;

-- AGGREGAT FUNCTION
SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;
-- OR
SELECT SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES;
-- ROUND OFF
SELECT SUM(SALARY), ROUND(AVG(SALARY), 2), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;
-- OR
SELECT SUM(SALARY) AS TOTAL_SALARY, AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;

-- AGGREGATION FUNCTION ON JOB_ID AND FIND NO. OF EMPLYEES IN EACH JOB_ID
SELECT JOB_ID, SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID;

-- FIND JOB_ID WHICH HAS ONLY AVG SALARY GRATER THAN 10000
SELECT JOB_ID, SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID
WHERE AVG(SALARY)>10000;
-- WILL GIVE ERROR

SELECT JOB_ID, SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY)>20000;


-- Stored procedure

-- CREATING PROCEDURE
SHOW PROCEDURE STATUS;

DELIMITER //
CREATE PROCEDURE PROC7()
BEGIN
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME FROM EMPLOYEES
INNER JOIN
DEPARTMENTS
USING(DEPARTMENT_ID);
END //
DELIMITER ;
--  CALL THE PROCEDURE
CALL PROC7();

SHOW procedure status;

-- CREATE ANOTHER PROCEDURE
DELIMITER //
CREATE PROCEDURE PROC8()
BEGIN
select * FROM EMPLOYEES
WHERE SALARY>10000;
END //
DELIMITER ;

CALL PROC8();





-- DROPING THE PROCEDURE
DROP procedure PROC7;
DROP PROCEDURE PROC8;
DROP PROCEDURE PROC9;

-- PROCEDURE WITH IN PARAMETER 
DELIMITER //
CREATE PROCEDURE PROC8(IN VAR1 INT)
BEGIN
select * FROM EMPLOYEES
WHERE SALARY>VAR1;
END //
DELIMITER ;

CALL PROC8(15000);
DROP PROCEDURE PROC8;

-- WITH MULTIPLE ARGUMENTS

DELIMITER //
CREATE PROCEDURE PROC8(IN VAR1 VARCHAR(20), IN VAR2 INT)
BEGIN
select * FROM EMPLOYEES
WHERE JOB_ID=VAR1 AND SALARY>VAR2;
END //
DELIMITER ;

CALL PROC8('IT_PROG', 10000);

DROP PROCEDURE PROC8;
-- User DEFINED VARIABLE
DELIMITER //
CREATE PROCEDURE PROC8(OUT CALC INT)
BEGIN
select AVG(SALARY) INTO CALC FROM EMPLOYEES;
END //
DELIMITER ;

CALL PROC8(@RES);
SELECT @RES;

-- CREATE USER DEFINED FUNCTION
SET @SAL1=10000;
SET @SAL2=15000;
select * FROM EMPLOYEES
WHERE SALARY between @SAL1 AND @SAL2;

-- use case of USER DEFINED VARIABLE @res
select * FROM EMPLOYEES
WHERE SALARY>@res;

-- PROCEDURE WITH IN OUT PARAMETER
DELIMITER //
CREATE PROCEDURE PROC9(IN VAR1 INT, OUT VAR2 DECIMAL(10,3))
BEGIN
SELECT SALARY INTO VAR2 FROM EMPLOYEES
WHERE EMPLOYEE_ID=VAR1;
END//
DELIMITER ;

CALL PROC9(103, @VAR2);
SELECT @VAR2;

-- ----------------------------------------------DAY_09--------------------------------------------------------
-- INDEXES

create table EV_NEW(
EMP_ID INT unsigned primary KEY,
FIRST_NAME VARCHAR(15),
LAST_NAME VARCHAR(10),
SALARY DECIMAL(10,2));

-- SHOW INDEX
SHOW INDEX FROM EV_NEW;

-- CREATE INDEX
create INDEX NAME_SERACH ON EV_NEW(FIRST_NAME, LAST_NAME);
SHOW INDEX FROM EV_NEW;

-- DROP INDEX
ALTER TABLE EV_NEW DROP INDEX NAME_SERACH;
SHOW INDEX FROM EV_NEW;

-- unique index
create unique index name_search on ev_new(first_name, last_name);
SHOW INDEX FROM EV_NEW;

-- Views
-- CREATE VIEWS

CREATE VIEW EMPLOYEES_DATA AS 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID FROM EMPLOYEES;

SELECT * FROM EMPLOYEES_DATA;

CREATE VIEW EMPLOYEES_DATA1 AS 
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES;

-- DROP VIEWS
DROP VIEW EMPLOYEES_DATA1;

-- ADD ONE MORE COL (SALARY COL) TO EXISTING VIEW EMPLOYEES_DATA
ALTER VIEW EMPLOYEES_DATA AS
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, sALARY FROM EMPLOYEES;

-- SHOWS ALL VIEWS WHICH EXISTS IN HR DATABASE IN EMPLOYEES TABLE
select VIEW_CATALOG, VIEW_SCHEMA, VIEW_NAME FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE TABLE_SCHEMA='HR' AND TABLE_NAME='EMPLOYEES';

-- --------------------------------------------Day_10---------------------------------------------------------
--  data PARTIONING
-- CREATE A NEW COMPANY DATABASE NAMED 'COMPANY'
CREATE DATABASE COMPANY;

USE COMPANY;
-- RANGE PARTITION
-- CRATE A TABLE NAMED 'PEPOLE' IN THIS COMPANY DATABASE
CREATE TABLE PEPOLE (
ID INT NOT NULL,
NAME VARCHAR(20),
SURNAME VARCHAR(20),
AGE INT NOT NULL,
CITY VARCHAR(20),
STATE VARCHAR(30))
-- PARTITION BY AGE
partition by range(AGE)(
partition PART0 VALUES LESS THAN (20),
partition PART1 VALUES LESS THAN (30),
partition PART2 VALUES LESS THAN (40),
partition PART3 VALUES LESS THAN (50),
partition PART4 VALUES LESS THAN (60),
partition PART5 VALUES LESS THAN maxvalue);

-- NOW INSERT THE DATA IN 'PEPOLE' TABLE
INSERT INTO PEPOLE VALUES
(101, 'ARIF', 'MOKHTAR', 19, 'BANGLORE', 'KARNATAKA'),
(102, 'RAMWATAR', 'PRAJAPATI', 23, 'MUMBAI', 'MAHARASTARA'),
(103, 'SANDEEP', 'KUMAR', 33, 'JHUNJHUNU', 'RAJASTHAN'),
(104, 'LAXMAN', 'KUMAR', 45, 'SURAT', 'GUJRAT'),
(105, 'ANKIT', 'KUMAR', 65, 'DELHI', 'DELHI'),
(106, 'REKHA', 'SHARMA', 9, 'SIKAR', 'RAJ'),
(107, 'DEEPAKIA', 'JAUH', 53, 'CHOMU', 'RAJASTHAN');

SELECT * FROM PEPOLE;

-- SHOW ANY PARTION NOW
select * FROM PEPOLE partition(PART1);

-- LIST PARTITIONING

CREATE TABLE CUSTOMER(
NAME VARCHAR(20),
CITY VARCHAR(20))
partition by LIST COLUMNS(CITY)(
PARTITION P1 VALUES IN('DELHI', 'MUMBAI', 'KOLKATA'),
partition P2 VALUES IN ('BENGLURU', 'CHENNAI', 'HYDERABAD'));

-- INSERT VALUES TO THE TABLE
INSERT INTO CUSTOMER VALUES
('ARIF', 'DELHI'),
('X', 'MUMBAI'),
('Y', 'KOLKATA'),
('Z', 'CHENNAI'),
('A', 'BENGLURU');

SELECT * FROM CUSTOMER;
SELECT * FROM CUSTOMER partition(P1);

-- ADD ANOTHER PARTION P3
ALTER TABLE CUSTOMER ADD partition( partition P3 VALUES IN('GUJRAT', 'KASHMIR', 'RAJASTHAN', 'UP'));

-- NOW INSERT THE CITY WHICH WE DDED PARTIONED  FOR THAT
INSERT INTO CUSTOMER VALUES
('B', 'RAJASTHAN'),
('C', 'UP'),
('D', 'KASHMIR');

SELECT * FROM CUSTOMER partition(P3);SELECT * FROM CUSTOMER partition(P3);

INSERT INTO CUSTOMER VALUES('V', 'GUJRAT');

-- drop partition p3
ALTER TABLE CUSTOMER DROP PARTITION P3;

-- ONLY REMOVES THE ROWS FROM PARTITION NOT THE PARTITION FROM THE DATABASE
ALTER TABLE CUSTOMER TRUNCATE PARTITION P3;


-- CREATE PARTITION IN EXISTING table WHICH DID NOT PARTITIONING BEFORE

-- FIRST CREATE TABLE
CREATE TABLE CUSTOMER_NEW(
ID INT NOT NULL,
NAME VARCHAR(20),
SURNAME VARCHAR(20),
AGE INT NOT NULL,
CITY VARCHAR(20),
STATE VARCHAR(30));

-- INSERT THE DATA NOW
INSERT INTO CUSTOMER_NEW VALUES
(101, 'ARIF', 'MOKHTAR', 19, 'BANGLORE', 'KARNATAKA'),
(102, 'RAMWATAR', 'PRAJAPATI', 23, 'MUMBAI', 'MAHARASTARA'),
(103, 'SANDEEP', 'KUMAR', 33, 'JHUNJHUNU', 'RAJASTHAN'),
(104, 'LAXMAN', 'KUMAR', 45, 'SURAT', 'GUJRAT'),
(105, 'ANKIT', 'KUMAR', 65, 'DELHI', 'DELHI'),
(106, 'REKHA', 'SHARMA', 9, 'SIKAR', 'RAJ'),
(107, 'DEEPAKIA', 'JAUH', 53, 'CHOMU', 'RAJASTHAN');

-- NOW CRAETE THE PARTITIONING 
ALTER TABLE CUSTOMER_NEW partition by RANGE(AGE)
(PARTITION PART0 values less than(20),
partition PART1 values less than MAXVALUE);

SELECT * FROM CUSTOMER_NEW partition(PART1);


-- Hash PARTITIONING

-- CRATE TABLE
CREATE TABLE EMPLOYEES_HASH(
EMP_ID INT NOT NULL,
FIRST_NAME VARCHAR(20),
STORE_ID INT NOT NULL);

ALTER TABLE EMPLOYEES_HASH partition by HASH(STORE_ID)
partitions 5;

INSERT INTO EMPLOYEES_HASH VALUES
(101, 'SHRAWAN', 20),
(102, 'SANDEEP', 40),
(103, 'ANKIT', 60),
(104, 'LAXMAN', 80),
(105, 'APIN', 60),
(106, 'SUMIT', 80),
(107, 'AMIT', 20),
(108, 'PAPA', 30);

SELECT * FROM EMPLOYEES_HASH partition(P2);

-- if  we want to keep only 3 partitioning out of 5
alter table employee_hash coalesce partition 2; -- it will remove 2 partition.alter


-- DATE FORMAT
SELECT date_format(CURRENT_DATE(), '%D_%M_%Y');

 -- --------------------------------------------SESSION-11-------------------------------------------------------
 -- TRIGGERS-BEFORE AND AFTER INSERT AND UPDATE
 
 -- let's crate a new database called "triggers"
	create database triggers;
    
    use triggers;
    
 -- CREATE A CUSTOMERS table
 CREATE TABLE CUSTOMERS(
 cust_ind int,
 age int,
 first_name varchar(20));
 
 select * from customers;

 
 -- let's create trigger
 delimiter //
 create trigger verify_age
 before insert 
 on customers for each row
 begin 
 if new.age<0 then set new.age=0;
 elseif new.age is null then set new.age=0;
 end if;
 end  //
 delimiter ;

 
 show triggers;
 
 -- insert value in customers table
 insert into customers values(100, 23, 'Arif');
 select * from customers;
 
 
 
 insert into customers values
 (101, -23, 'Ankit'),
 (102, NULL, 'MOHIT');
 
 use triggers;
 
 -- AFTER INSERT TRIGGER
 
 create table person(
 id int primary key auto_increment,
 name varchar(20) not null,
 email varchar(40),
 birthdate date);
 
 -- let's create another table named " person_detail"
 create table person_detail(
 id int auto_increment,
 personId int,
 message text not null,
 primary key(id, personId));
 
 -- now create after insert trigger
 delimiter //
 create trigger after_pepole_insert_data
 after insert on person for each row
 begin
 if new.birthdate is null then
 insert into person_detail(personId, message) values
 (new.id, concat('Hey', new.name, 'Plzzz provide your Birth Date'));
 end if;
 end // 
 delimiter ;
 
 -- now insert data into person table
 insert into person(name, email, birthdate) values
 ('Shrawan', 'sk@gmail.com', '2000-06-06'),
 ('Ankit', 'al@gmail.com', NULL);
 
 select * from person;
 
 select * from person_detail;
 
 -- DROP TRIGGER
 drop trigger after_pepole_insert_data;
 
 -- before update triger / after update
 
 create table employees(
 emp_id int primary key,
 emp_name varchar(30),
 age int, 
 salary decimal(8,2));
 
 -- create another table named "Tracking" as a log table
 create table tracking(
 id int primary key auto_increment,
 emp_id int unsigned,
 old_salary decimal(10,2),
 message varchar(1000));
 
 
 -- insert values in employees table
 insert into employees values
 (100, 'Shrawan', 23, 56000),
 (101, 'Ankit', 24, 50000),
 (102, 'Sandeep', 30, 9000),
 (103, 'Laxman', 23, 10000);
 
 select * from employees;
 
 -- create before trigger
 delimiter //
 create trigger before_update
 before update on employees for each row
 begin
 if new.salary<10000 then set new.salary=60000;
 elseif new.salary=10000 then set new.salary=70000;
 end if;
 end //
 delimiter ;
 
 show triggers;
 
 -- now, let's update the employees table
 update employees 
 set salary=5000
 where emp_id in(102, 103);
 
 select * from employees;
 
drop trigger before_update;
 
 
 -- After Update trigger
 -- first create a log or track table (we already created up)
 -- then craete after update trigger
 
 delimiter //
 create trigger after_update 
 after update on employees for each row
 begin
 if new.salary!=old.salary then insert into tracking(emp_id, old_salary, message) values
 (old.emp_id, old.salary, 'Salary has been updated');
 end if;
 end //
 delimiter ;
 show triggers;
 
 
 -- now, update the salary
 update employees
 set salary=150000
 where emp_id=101;
 
 select * from employees;
 
 select *from tracking;
 
------------------------------------	SESSION-11 SUB-QUIERIES--------------------------------------------------
-- continue with trigger
-- before delete \ after delete

-- craete a table named 'salary'
 create table salary(
 emp_id int primary key,
 valid_from date not null,
 amount decimal(8,2) not null);
 
 insert into salary values
 (100, '2001-02-06', 56000),
(101, '2002-02-06', 56200),
 (102, '2003-02-06', 56056);
 
 -- create another table to store the recorded which is deleted from Salary table
 create table salary_del(
 id int auto_increment primary key,
 emp_id int,
 valid_from  date not null,
 amount decimal(8,2) not null,
 deletedDate timestamp default now());
 
 -- create a before delete trigger
 delimiter $$
 create trigger salary_delete 
 before delete on salary for each row
 begin
 insert into salary_del(emp_id, valid_from, amount) values
 (old.emp_id, old.valid_from, old.amount);
 end $$
 delimiter ;
 
 -- now delete a row
 delete from salary 
 where emp_id=102;
 
 select * from salary;
 
 select * from salary_del;
 
 -- SUB QUERIES
 
 -- Q1) write a query for select the all employess where their salary is equals to the salary of employees which emp_id
 -- is 104
 use hr;
 select * from employees;
 
 select * from employees where
 salary=(
 select salary from employees
 where employee_id=104);
 
 -- Q.2) find all the employees where salary is equal to minimum salary in any of department
select * from employees
where salary in( 
 select min(salary) from employees
 group by department_id);
 
 -- Q.3) find the employees who is earning more than second highest salary
  use hr;
  
  select * from employees where salary = 
  (select max(salary) from employees where        
   salary < ( select max(salary) from employees));
   
   -- check for above answer
   select salary from employees
   order by  salary desc;
   use hr;
   
   select employee_id, first_name, last_name, job_id, department_id, location_id, country_id from employees 
   join
   (select department_id, location_id, country_id from departments 
   join
   locations using(location_id)
   where country_id='US') as m
   using(department_id);   
   
   select count(*) from locations
   where country_id='US';
   
   
   -- Answer of question _08
   use hr;
   select employee_id, concat(first_name, ' ', last_name), salary CTC, salary-(select avg(salary) from employees)
   Avg_comaprison,
   case when salary>=(select avg(salary) from employees) then 'Above Benchmark'
   else 'Below Benchmark'
   end salary_status
   from employees;
   
   
   -- answer 12) 
   use hr;
   select * from departments d where exists (select department_id from employees e where e.department_id=
   d.department_id);
   select * from departments;
   select * from employees;
 
 -- USER DEFINED FUNCTIONS
 -- create a function to calculate the cube of a number
 
 use hr;
 delimiter //
 create function calc(num1 int)
 returns int
 deterministic
 begin
 declare cub_var int;
 set cub_var = num1*num1*num1;
return cub_var;
 end //
 delimiter ;
 
  -- call the UDF
 select calc(5);
 select calc(100);
 
 -- calculate the age of a person
 delimiter //
 create function age_cal(person_dob date)
 returns int -- because it will return age i.e. integer
 deterministic
 begin
 declare today_date date;
 select current_date() into today_date;
 return year(today_date) - year(person_dob);
 end //
 delimiter ;
 select current_date();
 select age_cal("2000-06-06");
 
 -- we can solve like this
  delimiter //
 create function age_ca(person_dob date)
 returns int -- because it will return age i.e. integer
 deterministic
 begin
 -- declare today_date date;
 -- select current_date() into today_date;
 return year(current_date()) - year(person_dob);
 end //
 delimiter ;
 select current_date();
 select age_ca("2000-06-06");
 
 select user();
 
 -- WINDOW FUNCTION
 -- Q.1) put the max salary in each row employees table.
 select *, max(salary) over() from employees;
 
 -- Q.2.) put the ma salary based on the job_id
 select *, max(salary) over(partition by job_id) from employees;
 
 use hr;
 
 -- Q.3.) only fetch records with max salary have max salary >13000 based on job_id
 select * from (select *, max(salary) over(partition by job_id) as D from employees)
 as A
 where A.D>13000;
 
-- Q.4) Row number
-- use of row_number() window function
select *, row_number() over() from employees; 

-- it show both rank and max salary
select *, row_number() over(), max(salary) over() from employees; 

-- Rank() window function
select *, rank() over(partition by job_id order by salary desc) as 'Rank' from employees;

-- --------- THE END------------------THANKS A LOT--------------------LETS DEEP DIVE------------------------
 


 
