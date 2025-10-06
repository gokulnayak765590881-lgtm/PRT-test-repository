USE CASESTUDY_1

----------------------------------------------------------------------------
----------------------START CASE STUDY-2 ASSIGNMENT-------------------------
----------------------------------------------------------------------------
--I've already a table named after Location
CREATE TABLE LOCATIONS (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATIONS(Location_ID, City)
VALUES (122,'New York'),
       (123,'Dallas'),
       (124,'Chicago'),
       (167,'Boston');

SELECT * FROM LOCATIONS

  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATIONS(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);
SELECT * FROM DEPARTMENT

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20));

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')
SELECT * FROM JOB

CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

SELECT * FROM EMPLOYEE

------------------START THE TASK---------------------------------------
------------------SIMPLE QUERY-----------------------------------------
-----------------------------------------------------------------------
--TASK:-01) List all the employee details.
SELECT * FROM EMPLOYEE;

--------------------------------------------
--Task:-02) List all the department details.
SELECT * FROM DEPARTMENT;

---------------------------------------------
--Task:-03) List all job details
SELECT * FROM JOB;

---------------------------------------------
--Task:-04) List all the locations.
SELECT * FROM LOCATIONS

---------------------------------------------
--Task:-05) List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT First_Name,
       Last_Name,
       Salary,
       Comm
FROM EMPLOYEE;

----------------------------------------------
--Task:-06) List out the Employee ID, Last Name, Department ID for all employees and alias
----------Employee ID as "ID of the Employee", Last Name as "Name of the
----------Employee", Department ID as "Dep_id".
SELECT Employee_Id AS Id_of_the_Employee,
       Last_Name AS Name_of_the_Employee,
       Department_Id as Dep_id
FROM EMPLOYEE;

-------------------------------------------------
--Task:-7) List out the annual salary of the employees with their names only.
SELECT 
    (First_Name+' ' +Last_Name) AS Full_Name,
    (Salary * 12) AS AnnualSalary
FROM Employee;

--------------------------------------------------
-------------------WHERE--------------------------
--------------------------------------------------
--Task:-1) List the details about "Smith".
SELECT * FROM EMPLOYEE
WHERE Last_Name = 'Smith';

--------------------------------------------------
--Task:-2) List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID = 20;

---------------------------------------------------
--Task:-3) List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM EMPLOYEE
WHERE Salary BETWEEN 2000 and 3000;

---------------------------------------------------
--Task:-4) List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID BETWEEN 10 and 20;

---------------------------------------------------
--Task:-5) Find out the employees who are not working in department 10 or 30
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID not between 10 and 20;

---------------------------------------------------
--Task:-6) List out the employees whose name starts with 'L'.
SELECT * FROM EMPLOYEE
WHERE First_Name like ('L%');

----------------------------------------------------
--Task:-7) List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME like ('L%E');

----------------------------------------------------
--Task:-8) List out the employees whose name length is 4 and start with 'J'.
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME like ('J%')
AND LEN(First_Name) = 4;

----------------------------------------------------
--Task:-9) List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID = 30 and salary > 2500;

----------------------------------------------------
--Task:-10) List out the employees who are not receiving commission.
SELECT *
FROM Employee
WHERE Comm IS NULL OR Comm = 0;

----------------------------------------------------
----------ORDER BY Clause---------------------------
----------------------------------------------------
--Task:-1) List out the Employee ID and Last Name in ascending order based on theEmployee ID.
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEE
ORDER BY EMPLOYEE_ID ASC;

----------------------------------------------------
--Task:-2) List out the Employee ID and Name in descending order based on salary
SELECT EMPLOYEE_ID,
       (FIRST_NAME + ' ' +LAST_NAME) AS Full_Name
FROM EMPLOYEE
ORDER BY Salary DESC;

-----------------------------------------------------
--Task:-3) List out the employee details according to their Last Name in ascending-order.
SELECT * FROM EMPLOYEE
ORDER BY LAST_NAME ASC;

-----------------------------------------------------
--Task:-4) List out the employee details according to their Last Name in ascending
---------------order and then Department ID in descending order.
SELECT * FROM EMPLOYEE
ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;

----------------------------------------------------
-------------GROUP BY and HAVING Clause-------------
----------------------------------------------------

--Task:-1) List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT DEPARTMENT_ID, MAX(Salary) AS Max_sal,
                      MIN(Salary) AS Min_Sal,
                      AVG(Salary) AS Avg_Sal
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

----------------------------------------------------
--TAsk:-2) List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT JOB_ID, MAX(Salary) AS Max_Sal,
               MIN(Salary) AS Min_Sal,
               AVG(Salary) AS Avg_Sal
FROM EMPLOYEE
GROUP BY JOB_ID;

-----------------------------------------------------
--Task:-3) List out the number of employees who joined each month in ascending order.
SELECT Hire_Date, COUNT(*) AS Num_of_Employees
FROM EMPLOYEE
GROUP BY HIRE_DATE
ORDER by HIRE_DATE;  SELECT * FROM EMPLOYEE
------------------------------
SELECT 
    MONTH(HIRE_DATE) AS Joining_Month,
    COUNT(*) AS Number_of_Employees
FROM Employee
GROUP BY MONTH(HIRE_DATE)
ORDER BY Joining_Month ASC;

--------------------------------------------------------
--Task:-4) List out the number of employees for each month and year in ascending order based on the year and month.
SELECT 
    YEAR(HIRE_DATE) AS Joining_Year,
    MONTH(HIRE_DATE) AS Joining_Month,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE), MONTH(HIRE_DATE)
ORDER BY YEAR(HIRE_DATE) ASC, MONTH(HIRE_DATE) ASC;

---------------------------------------------------------
--Task:-5) List out the Department ID having at least four employees.
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;

----------------------------------------------------------
--Task:-6) How many employees joined in February month.

SELECT MONTH(Hire_Date) AS MonthJoined,
COUNT(*) AS Month_of_Joining_in_February
FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = 2
GROUP BY MONTH(Hire_date);
------
SELECT COUNT(*) AS Joined_in_Feb
FROM EMPLOYEE
WHERE MONTH(Hire_Date)=2;
----------------------------------------------------------
--Task:-7) How many employees joined in May or June month.
SELECT MONTH(Hire_Date) AS MonthJoined,
       COUNT(*) AS EmployeeCount
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (5, 6)
GROUP BY MONTH(Hire_Date)---Using Group By
ORDER BY MonthJoined;
-------
SELECT COUNT(*) AS Joined_in_may_and_June
FROM EMPLOYEE
WHERE MONTH(Hire_Date) in (5,6); ---Using WHERE

----------------------------------------------------------
--Task:-8) How many employees joined in 1985?
SELECT YEAR(Hire_Date) AS YEAR_JOINED,
COUNT(*) AS Joined_in_1985
FROM EMPLOYEE
WHERE YEAR(HIRE_DATE) = 1985
GROUP BY YEAR(HIRE_DATE);

----------------------------------------------------------
--Task:-9) How many employees joined each month in 1985?
SELECT YEAR(HIRE_DATE) AS Year_Hired,
       MONTH(HIRE_DATE) AS Month_Hired,
       COUNT(*) AS JOINED_IN_May_1985_Month_Wise
FROM EMPLOYEE
WHERE YEAR(HIRE_DATE) = 1985
GROUP BY MONTH(HIRE_DATE), YEAR(Hire_Date);

----------------------------------------------------------
--Task:-10) How many employees were joined in April 1985?
SELECT MONTH(HIRE_DATE) AS Month_Joined,
       YEAR(HIRE_DATE) AS Year_Joined,
       COUNT(*) AS Joined_in_Apr_1985
FROM EMPLOYEE
WHERE MONTH(HIRE_DATE)=4 AND YEAR(HIRE_DATE)=1985
GROUP BY MONTH(HIRE_DATE), YEAR(HIRE_DATE);

----------------------------------------------------------
--Task:-11) Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Employees_Joined
FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = 4 
  AND YEAR(HIRE_DATE) = 1985
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 3;

-----------------------------------------------------------
---------------------JOINS---------------------------------
-----------------------------------------------------------
--Task:-1) List out employees with their department names.
SELECT 
    E.EMPLOYEE_ID,
    E.FIRST_NAME,
    E.LAST_NAME,
    D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D 
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-----------------------------------------------------------
--Task:-2) Display employees with their designations.
SELECT E.Employee_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       E.JOB_ID,
       J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID=J.JOB_ID;

------------------------------------------------------------
--Task:-3) Display the employees with their department names and city.
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.NAME,
       L.City
FROM DEPARTMENT D
JOIN EMPLOYEE E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

------------------------------------------------------------
--Task:-4. How many employees are working in different departments? Display with department names.
SELECT D.Name, COUNT(E.EMPLOYEE_ID) AS Work_in_diff_Dept
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.NAME;

------------------------------------------------------------
--Task:-5) How many employees are working in the sales department?
SELECT D.Name, COUNT(E.EMPLOYEE_ID) AS Working_in_Sales_Dept
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales'
GROUP BY D.Name;

-------------------------------------------------------------
--Task:-6) Which is the department having greater than or equal to 3 employees and display the 
----------department names in ascending order.
SELECT D.Name, COUNT(E.EMPLOYEE_ID) AS Total_Employees
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.Name
HAVING COUNT(E.EMPLOYEE_ID) >= 3
ORDER BY D.Name ASC;

------------------------------------------------------------
--Task:-7) How many employees are working in 'Dallas'?
SELECT L.City, COUNT(E.Employee_ID) AS Empl_Work_In_Dallas
FROM  LOCATIONS L
JOIN DEPARTMENT D
ON D.Location_Id = L.Location_Id
JOIN EMPLOYEE E
ON D.Department_Id = E.DEPARTMENT_ID
WHERE City = 'Dallas'
GROUP BY L.City;

-----------------------------------------------------------
--Task:-8) Display all employees in sales or operation departments.
SELECT E.EMPLOYEE_ID,
       (E.FIRST_NAME + ' ' + E.Last_Name) AS Full_Name,
       D.Name AS Department_Name,
       D.Department_id
FROM EMPLOYEE E
JOIN DEPARTMENT D 
  ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

-------------------------------------------------------------
----------------CONDITIONAL STATEMENT------------------------
-------------------------------------------------------------
--Task:-1) Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT EMPLOYEE_ID,
       (FIRST_NAME+' '+LAST_NAME) AS Full_Name, --- Taken as one column instead of two column
       SALARY,
            CASE
                WHEN Salary >=10000 THEN 'Grade A'
                WHEN Salary BETWEEN 5000 and 9999 THEN 'Grade B'
                WHEN Salary BETWEEn 2000 and 4999 THEN 'Grade C'
                ELSE 'Grade D'
             END AS 'Salary Grade'
    FROM EMPLOYEE;

----------------------------------------------------------------
--Task:-2) List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT 
    CASE
        WHEN SALARY >= 10000 THEN 'Grade A'
        WHEN SALARY BETWEEN 5000 AND 9999 THEN 'Grade B'
        WHEN SALARY BETWEEN 2000 AND 4999 THEN 'Grade C'
        ELSE 'Grade D'
    END AS Salary_Grade,
    COUNT(*) AS Num_Employees
FROM EMPLOYEE
GROUP BY 
    CASE
        WHEN SALARY >= 10000 THEN 'Grade A'
        WHEN SALARY BETWEEN 5000 AND 9999 THEN 'Grade B'
        WHEN SALARY BETWEEN 2000 AND 4999 THEN 'Grade C'
        ELSE 'Grade D'
    END;

-------------------------------------------------------------------
--Task:-3) Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE
        WHEN Salary >= 10000 THEN 'Grade A'
        WHEN Salary BETWEEN 5000 AND 9999 THEN 'Grade B'
        WHEN Salary BETWEEN 2000 AND 4999 THEN 'Grade C'
        ELSE 'Grade D'
    END AS Salary_Grade,
    COUNT(*) AS No_of_Employees
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY 
    CASE
        WHEN Salary >= 10000 THEN 'Grade A'
        WHEN Salary BETWEEN 5000 AND 9999 THEN 'Grade B'
        WHEN Salary BETWEEN 2000 AND 4999 THEN 'Grade C'
        ELSE 'Grade D'
    END;

--------------------------------------------------------------------
------------------------Subqueries----------------------------------
--------------------------------------------------------------------
--Task:-1. Display the employees list who got the maximum salary.
SELECT EMPLOYEE_ID,
       (FIRST_NAME+' '+LAST_NAME) AS Full_Name
FROM EMPLOYEE
WHERE SALARY=(SELECT MAX(Salary) FROM EMPLOYEE

--------------------------------------------------------------------
--Task:-2) Display the employees who are working in the sales department.
SELECT EMPLOYEE_ID,---Using SUB-QUERY And WHERE
       (FIRST_NAME + ' ' + LAST_NAME) AS Full_Name,
       DEPARTMENT_ID
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (
    SELECT DEPARTMENT_ID 
    FROM DEPARTMENT 
    WHERE NAME = 'Sales');
-----------
SELECT E.EMPLOYEE_ID,--Using JOIN And WHERE
       (E.FIRST_NAME+' '+E.LAST_NAME) AS Full_Name,
       D.DEPARTMENT_ID
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE Name='Sales';

--------------------------------------------------------------------
--Task:-3) Display the employees who are working as 'Clerk'.
SELECT EMPLOYEE_ID,
       (FIRST_NAME+' '+LAST_NAME) AS Full_Name
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID FROM JOB WHERE DESIGNATION = 'Clerk');

--------------------------------------------------------------------
--Task:-4) Display the list of employees who are living in 'Boston'.
SELECT E.EMPLOYEE_ID,
       (E.FIRST_NAME+' '+LAST_NAME) AS Full_Name
FROM EMPLOYEE E
 JOIN Department D on E.DEPARTMENT_ID = D.Department_Id
 JOIN Locations L ON D.Location_Id = L.Location_ID
WHERE L.City = (
SELECT City FROM Locations
WHERE City = 'Boston');
-------
SELECT E.EMPLOYEE_ID,
       (E.FIRST_NAME+' '+LAST_NAME) AS Full_Name
FROM EMPLOYEE E
 JOIN Department D on E.DEPARTMENT_ID = D.Department_Id
 JOIN Locations L ON D.Location_Id = L.Location_ID
WHERE L.City = 'Boston'; -- Using Only WHERE
----------------------------------------------------------------------
--Task:-5) Find out the number of employees working in the sales department.
SELECT COUNT(*) AS Employee_in_Sales
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name='Sales')

------------------------------------------------------------------------
--Task:-6) Update the salaries of employees who are working as clerks on the basis of 10%.
BEGIN TRANSACTION;
UPDATE EMPLOYEE 
SET SALARY = SALARY + (SALARY * 0.10)
WHERE JOB_ID IN (
    SELECT JOB_ID
    FROM JOB 
    WHERE DESIGNATION = 'Clerk'
);

--------------------------------------------------------------------------
--7) Display the second highest salary drawing employee details.
SELECT *
FROM EMPLOYEE
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    WHERE SALARY < (
        SELECT MAX(SALARY)
        FROM EMPLOYEE));

--------------------------------------------------------------------------
--Task:-8) List out the employees who earn more than every employee in department 30.
SELECT SALARY
FROM EMPLOYEE
WHERE SALARY > (
    SELECT MAX(SALARY) Max_Sal
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = 30);
---------------------------------------------------------------------------
--Task:-9) Find out which department has no employees.
SELECT *
FROM DEPARTMENT
WHERE DEPARTMENT_ID NOT IN (
    SELECT DISTINCT DEPARTMENT_ID
    FROM EMPLOYEE);

----------------------------------------------------------------------------
--Task:-10) Find out the employees who earn greater than the average salary for their department.
SELECT EMPLOYEE_ID,
       (FIRST_NAME + ' ' + LAST_NAME) AS Full_Name,
       DEPARTMENT_ID,
       SALARY
FROM EMPLOYEE E
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
);

--------------------END----------------------------------

