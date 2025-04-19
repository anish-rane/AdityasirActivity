 CREATE TABLE DEPARTMENTS (
 DEPARTMENT_ID INT PRIMARY KEY,
 DEPARTMENT_NAME VARCHAR(20) NOT NULL UNIQUE);

CREATE TABLE EMPLOYEES (
 EMPLOYEE_ID INT PRIMARY KEY,
 FIRST_NAME VARCHAR(20) NOT NULL,
 LAST_NAME VARCHAR(20) NOT NULL,
 EMAIL VARCHAR(50) NOT NULL UNIQUE,
 HIRE_DATE DATE NOT NULL,
 SALARY INT,
 DEPARTMENT_ID INT NOT NULL,
 FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID));

  CREATE TABLE PROJECTS (
  PROJECT_ID INT PRIMARY KEY,
  PROJECT_NAME VARCHAR(50) NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE,
  DEPARTMENT_ID INT NOT NULL,
  FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID));

insert into DEPARTMENTS(DEPARTMENT_ID,DEPARTMENT_NAME)
 values
 (1,'IT'),
 (2,'HR'),
 (3,'Sales'),
 (4,'Finance'),
 (5,'Marketing');

 INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY, DEPARTMENT_ID)
 VALUES
 (101, 'Ravi', 'Sharma', 'ravi.sharma@specialforce.com', '2017-05-15', 55000, 1),
 (102, 'Neha', 'Kapoor', 'neha.kapoor@specialforce.com', '2019-03-23', 48000, 2),
 (103, 'Jyoti', 'Verma', 'jyoti.verma@specialforce.com', '2020-11-02', 60000, 1),
 (104, 'Anil', 'Patil', 'anil.patil@specialforce.com', '2018-09-18', 70000, 3),
 (105, 'Pooja', 'Singh', 'pooja.singh@specialforce.com', '2021-06-10', 40000, 4),
 (106, 'Sanjay', 'Iyer', 'sanjay.iyer@specialforce.com', '2018-01-22', 75000, 3),
 (107, 'Jatin', 'Reddy', 'jatin.reddy@specialforce.com', '2021-12-12', 85000, 2),
 (108, 'Shreya', 'Mehta', 'shreya.mehta@specialforce.com', '2022-04-19', 30000, 5),
 (109, 'Rajesh', 'Gupta', 'rajesh.gupta@specialforce.com', '2020-08-11', 90000, 1),
 (110, 'Kavita', 'Nair', 'kavita.nair@specialforce.com', '2021-02-07', 50000, 2);


INSERT INTO PROJECTS (PROJECT_ID, PROJECT_NAME, START_DATE, END_DATE, DEPARTMENT_ID)
 VALUES
 (201,'Project Phoenix','2021-01-15','2022-07-30',1),
 (202,'Client Onboarding','2020-06-20',NULL,3),
 (203,'Financial Overhaul','2019-03-10','2021-12-15',4),
 (204,'Marketing Revamp','2022-03-01',NULL,5),
 (205,'Internal System Audit','2023-02-15',NULL,2);

select first_name,last_name,department_name from EMPLOYEES,DEPARTMENTS
 where DEPARTMENTS.department_id=EMPLOYEES.department_id;

select first_name,last_name,salary from EMPLOYEES
 where employee_id=(select employee_id from DEPARTMENTS
 where department_name='IT')
 and salary>50000;

 select first_name,last_name,email from EMPLOYEES
 where first_name like 'J%' and
 email like '%specialforce.com';

select distinct department_name from DEPARTMENTS;

select department_name,sum(salary) from EMPLOYEES,DEPARTMENTS
 where EMPLOYEES.department_id=DEPARTMENTS.department_id
 group by department_name;

 select department_name as 'Department Name',avg(salary) as 'Average Salary' from EMPLOYEES,DEPARTMENTS
 where EMPLOYEES.department_id=DEPARTMENTS.department_id
 and DEPARTMENTS.department_name='Finance'
 group by department_name;

select min(salary) as 'Minimum Salary' ,max(salary) as 'Maximum Salary' from EMPLOYEES
 where department_id=(
 select department_id from DEPARTMENTS
 where department_name='Sales');

 select DEPARTMENTS.department_name as 'Department Name',count(EMPLOYEES.department_id) as 'Count of Employees' from EMPLOYEES,DEPARTMENTS
 where DEPARTMENTS.department_id=EMPLOYEES.department_id
 group by DEPARTMENTS.department_name;

select first_name,last_name from EMPLOYEES
 where hire_date between '2018-01-01' and'2020-12-31'
 order by  hire_date;

select first_name,last_name from EMPLOYEES
 where email=null;

 select concat(first_name,' ',last_name) as 'Employee names' from EMPLOYEES
 where department_id in(
 select department_id from DEPARTMENTS
 where department_name in ('Hr','Finance','It'));

select first_name,last_name,salary from EMPLOYEES
 where salary between 30000 and 70000
 order by salary desc;

 start transaction;
update employees
 set salary=salary*1.05
 where department_id=(
 select department_id from departments
 where department_name='HR');
 commit;
start transaction;
update employees
 set salary = salary*1.03
 where department_id=(
 select department_id from departments
 where department_name='Sales');
commit;


select concat(Employees.first_name," ",Employees.last_name)as 'Employee Name', departments.department_name from Employees,departments
 where departments.department_id=Employees.department_id;

 select concat(Employees.first_name," ",Employees.last_name)as 'Employee Name', projects.project_name from Employees,projects
 where projects.department_id=Employees.department_id
 and projects.start_date>01-01-2023;

select concat(Employees.first_name," ",Employees.last_name)as 'Employee Name', departments.department_name from Employees,departments
 where departments.department_id=Employees.department_id
 order by departments.department_id;

 select concat(Employees.first_name," ",Employees.last_name)as 'Employee Name',Employees.salary, departments.department_name from Employees,departments
 where Employees.salary=(
 select max(salary) from employees
 where departments.department_id=Employees.department_id)
 order by Employees.department_id;

select max(salary) as '2nd largest salary' from Employees
 where salary<(
 select max(salary) from Employees);

 select distinct salary as '2nd largest salary' from Employees
 order by salary desc
 limit 1 offset 1;

 select max(salary) as '3nd largest salary' from Employees
 where salary<(
select max(salary) from Employees
where salary<(
select max(salary) from Employees));