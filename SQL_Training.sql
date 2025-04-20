Create database sql_training;
use sql_training;

create table countries(
country_id int,
country_code char(2),
country_name varchar(20)
);

insert into countries (country_id, country_code, country_name) values (01, 'US', 'United States');
insert into countries (country_id, country_code, country_name) values (02, 'IN', 'India');
insert into countries (country_name, country_id) values ('Canada', '03');
insert into countries (country_id, country_code, country_name) values (04, NULL, 'United Kingdom');
insert into countries (country_id, country_code, country_name) values (03, 'ME', 'United Arab Emirates');

-- for safe and unsafe mode before and after deletion

SET SQL_SAFE_UPDATES = 0; 
SET SQL_SAFE_UPDATES = 1;  

delete from countries
where country_code = 04 and country_name = 'United Kingdom';

Update countries set country_code = 'CA' where country_id = 03

select * from countries where country_id = 03;

delete from countries where country_id = 03;

truncate table countries;

select * from countries;

drop table countries;

alter table countries modify column country_code char(3);

update countries set country_code = 'USA' where country_id = 01;

alter table countries
add Latitude decimal(7,5),
add Longitude decimal(7,5);

Update countries set country_code = 'CAN';
Update countries set country_code = 'CAN'where country_id = 03;
Update countries set country_code = 'USA' where country_id = 01;
update countries set country_code = 'IND' where country_id = 02;
update countries set country_code = 'UAE' where country_id = 03;
update countries set country_code = 'UK' where country_name = 'United Kingdom';

select * from countries;

create table dept(
deptno int primary key,  -- not null, unique
dname varchar(20),
loc varchar(10)
);

insert into dept values(40, 'Accounting', 'New York');
insert into dept values(20, 'Research', 'Dallas');
insert into dept values (30, 'Sales', 'Chicago');
insert into dept values (10, 'Operations', 'Boston');

select * from dept;

create table emp(
empno int primary key, -- combination of unique and not null
ename varchar(20) not null,   -- cannot leave blank
job varchar(10) default 'CLERK',   -- if not job is entered SQL will put CLERK
mgr int,
hiredate Date,
sal decimal(7,2) check(sal>0),    -- check if salary is negative
comm decimal(7,2),
deptno int,
constraint FK_DEPTNO foreign key (deptno) references dept (deptno)  -- set foreign key constraint on the dept
);
select * from emp;

insert into emp values (7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800, NULL, 20);
insert into emp values (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
insert into emp values (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
insert into emp values (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);
insert into emp values (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
insert into emp values (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
insert into emp values (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
insert into emp values (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20);
insert into emp values (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
insert into emp values (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
insert into emp values (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
insert into emp values (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL,20);
insert into emp values (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
insert into emp (empno, ename, mgr, hiredate, sal, comm, deptno) values (7876, 'ADAMS', 7788, '1987-05-23', 1100, NULL,20);
select * from emp;

CREATE TABLE job_grades(
grade char(1),
lowest_sal int,
highest_sal int
);

insert into job_grades values
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 4999);

-- System Defined Functions:
select upper('prahalad');
select lower('PRAHALAD');
select upper(ename) from emp;
select upper (job) from emp;

select left(ename, 3) from emp;
select right(job, 3) from emp;
select left(hiredate, 4) from emp;
select right(empno,2) from emp;

-- Salary Hike to Employee:
select ename, sal*1.2 from emp;

-- To See Year of Today's Date:
select Year(curdate())
select curdate()

select 1*1;
select 1+1;

select length('PrahaladSingh');

select right('PrahaladSingh',5);
select left('PrahaladSingh',8);

select substring('PrahaladSingh', 8,5);
select substring('PrahaladSingh', 4, length('PrahaladSingh'));

select floor(1.80);
select ceiling(3.1);

select round(3.556, 2);
select round(3.512, 2);

select locate(' ', 'PRAHALAD SINGH');

select year(curdate());
select month(curdate());
select DAYNAME(CURDATE());
SELECT curdate();
SELECT left(CURDATE(), 4);
select left(curdate(),10);

SELECT 
  YEAR(CURDATE()) AS year,
  DAYNAME(CURDATE()) AS day_name;

SELECT CAST(CURDATE() AS CHAR);
SELECT CONVERT(CURDATE(), CHAR);

select left('Prahalad Singh', locate(' ', 'Prahalad Singh')) as FirstName;
select substring('Prahalad Singh', locate(' ', 'Prahalad Singh')) as LastName;

DECLARE ename VARCHAR(20);
SET ename = 'Prahalad Singh';

select left(@ename, locate(' ', @ename)) as FirstName;
select substring(@ename, locate(' ', @ename)) as LastName;

-- Querying Database Tables:
-----SELECT statement------
--- It instruct the database to retrieve information from table as per user's requirement.
SELECT <column-list> FROM <table-name>
WHERE <condition>
GROUP BY <column-name(s)
HAVING <condition>
ORDER BY <expression>

SELECT * FROM emp;

-- Conditional Retrieval of Rows
-- WHERE clause -- No of rows to be retrieved are restricted as per condition -- WHERE clause is case sensative

-- List the name of employees whose salary is greater than 1000

SELECT ename, sal FROM emp
WHERE sal >1000;

-- List the details of the employees who have joined before end of September 81

SELECT ename, sal, hiredate FROM emp
WHERE hiredate <= '1981-09-30';

-- Exploring SELECT Specisl Character
-- IN   :- For checking values in set.
-- List the name of the employees whose employee numbers are 7369,7521,7839,7788

SELECT ename FROM emp
WHERE empno IN (7369,7521,7839,7788);

-- BETWEEN  :- For checking values within range.
-- List the name of the employees whose salary is between 1000 and 2000

SELECT ename FROM emp
WHERE sal BETWEEN 1000 AND 2000;

-- LIKE :-  Matching pattern from column - used with wild cards such as %
-- List the name of the employees whose name start with S 

SELECT ename FROM emp
where ename LIKE 'S%';

-- List Employee Names whose name ends with S

SELECT ename from emp
WHERE ename LIKE '%S';

-- List Employee Names whose names contains S 

SELECT ename from emp
WHERE ename LIKE '%S%';

-- Using Expressions with Columns
-- Arithmetic Computations can be done on numeric columns
-- Alias Name can be given to Pseudo Columns

-- List Employee Name, Salary, Allowances (40% of sal), PF (10% of sal) and Net Salary

SELECT ename,sal, 
sal*0.4 as Allowances,
sal*0.1 as PF,
sal+ (sal*0.4)-(sal*0.1) as Net_Salary
FROM emp;

-- List Name of Employees who are more than 2 years old in organization

SELECT ename, sal FROM emp
WHERE year(curdate()) - year(hiredate)>2;

-- List different jobs available in organization (Use DISTINCT)

SELECT distinct job FROM EMP;

-- Working with NULL Values. NULL Values are not zeros. They are unknown or inapplicable values. 
-- They can not be used with relational /logical/arithmetic operators. Special operator IS used to locate NULL values

--List Employee names who are not liable for commission.

SELECT ename from emp
where comm IS NULL or comm = 0;

-- List Employee Name with Designations who does not report to anyone

SELECT ename, job from emp
WHERE mgr IS NULL;

-- Ordering the Result of a Query (Data Sort)
-- ORDER BY Clause is used with SELECT statement; one or more columns can specified in ORDER BY Clause.
-- Ordering can be done in Ascending or Descending Order. Ascending is the default order.alter.
-- ORDER BY  must always be the last clause of SELECT Statement.
-- List empno, ename, salary in the ascending order of salary.

SELECT empno, ename, sal FROM emp
ORDER BY sal;

-- List Employee Names and Hiredate in the order who have joined currently.
-- List Employee Names in the order to Jobs and Salary.
-- List Employee Names in the order to ascending Jobs and descending Salary.

SELECT ename, hiredate FROM emp
ORDER BY hiredate desc;

SELECT ename, job, sal FROM emp
ORDER BY job, sal;

SELECT ename, job, sal FROM emp
ORDER BY job ASC, sal DESC;

-- Aggregating Data Using Group Activity

-- Group Categories
-- A single Group representing all the rows -- Default Group
-- Multiple Groups based on specific column(s)
-- COUNT(), SUM(), AVG(), MAX(), MIN() are used for aggregating data.

SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT AVG(sal) FROM emp;
SELECT SUM(sal) FROM emp;
SELECT COUNT(sal) FROM emp;

-- Determine the total no of employees in the organization

SELECT COUNT(empno) from emp;

-- How many jobs are available in the organization?

SELECT COUNT(DISTINCT job) FROM emp;

-- Determine total payable salary of salesman category

SELECT SUM(sal) FROM emp
WHERE job = 'SALESMAN';

--List the average salary and no of employees working in department 20.

SELECT AVG(sal), COUNT(empno) FROM emp
WHERE deptno = 20;

-- Customized Grouping
-- Customized group activity can be performed by applying GROUP BY clause with SELECT statement.
-- This is achieved by segregating the rows into smaller groups.
-- Grouping can be done according to the desired column(s).
-- Find out total payable salary for each department.

SELECT job, SUM(sal) FROM emp
GROUP BY job;

SELECT deptno, SUM(sal) FROM emp
GROUP BY deptno;

-- List the Department Numbers and No of Employees in each Department.

SELECT deptno, COUNT(empno) FROM emp
GROUP BY deptno;

-- List average monthly salary for each job within each department.

SELECT deptno, job, AVG(sal) from emp
GROUP BY deptno, job
ORDER BY 2;

SELECT deptno, AVG(sal), COUNT(empno) from emp
GROUP BY deptno;

-- Conditional Retrieval of Groups
-- Conditional retrieval of groups can be achieved by applying HAVING Sub - Clause followed by GROUP BY Clause.
-- The condition specified in HAVING will determine which groups to be retrieved from the total groups.

-- List average salary for all departments employing more than 5 people.

SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno
HAVING count(8)>5;

-- To Display Empno, Ename, and Dname

SELECT empno, ename, emp.deptno, dname
FROM emp Left join dept ON emp.deptno = dept.deptno;

SELECT empno,
       ename,
       emp.deptno,
       dname
FROM emp LEFT JOIN dept ON emp.deptno = dept.deptno;

-- Using Table Aliases

SELECT E.empno,
       E.ename,
       E.deptno,
       D.dname,
       E.sal
FROM emp as E LEFT JOIN dept as D ON E.deptno = D.deptno;

-- Joining More Than Two Tables OR Multiple Table Joins

SELECT E.empno,
       E.ename,
       E.deptno,
       E.sal,
       D.dname,
       JG.grade
FROM emp AS E LEFT JOIN dept AS D ON E.deptno = D.deptno
			  LEFT JOIN job_grades AS JG on E.sal BETWEEN jg.lowest_sal AND highest_sal;

-- To Find Out Who Works for Whom
-- Here fact is that WHO and WHOM both are present within the same table. So the comparative factors in JOIN condition are 
-- emp.mgr and emp.empno
-- To avoid the ambiguity, we need to create alias twice for table emp
-- Ultimately, the comparision are taking place within the same table i.e every row of emp will be compared with every row of emp itself.
-- This can be achieved by creating the two aliases of same table. This is nothing but SELF rJOIN.

SELECT E1.ename AS Employee, 
E2.ename AS Manager
FROM emp AS E1 INNER JOIN emp AS E2 ON E1.mgr = E2.empno;

-- WINDOW FUNCTIONS RANK(), DENSE_RANK(), ROW_NUMBER()
-- Write a query to show empno, ename, sal, and rank of the emp based on their salary.

SELECT empno, 
       ename, 
       sal, 
       RANK() OVER (ORDER BY sal DESC) AS Rank_of_Salary,
       DENSE_RANK() OVER (ORDER BY sal DESC) AS Dense_Rank_of_Salary,
       ROW_NUMBER() OVER (ORDER BY sal DESC) AS RowNumber_Rank_of_Salary
       FROM emp;

--Sub-queries: Placing Quesries Inside One Another
-- Suppose, we wanted to extract all of MOTIKA's Orders from ORDER Table but we don't know the SNUM

SELECT snum FROM Salespeople
WHERE sname = 'Motika';

SELECT * FROM Orders
WHERE snum = 
(SELECT snum FROM Salespeople 
WHERE sname = 'Motika');

SELECT * FROM emp;