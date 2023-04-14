-- question based on new1 databse

-- write an sql query to fetch first name from workker using alias name <worker-name>
select first_name as Worker_name from Worker;

-- to fetch first_name in upper case
select UPPER(first_name) from Worker;

-- TO FETCH UNIQUE VALUES FROM DEPARTMENT FROM WORKER TABLE
SELECT distinct department  from Worker ;

-- to print first 3 character of first name from worker table
select substring(first_name, 1, 3) from Worker; 

-- to find the position of 'u' in first name anuj
select INSTR(first_name, 'U') from worker where first_name = 'ANUJ' ;

-- sql query to print first nane from worker table after removing whitespace from right side
select rtrim(first_name) from Worker ;

-- left side white spoace
select ltrim(first_name) from Worker ;

-- unique value from department from worker table and prints its length
select distinct department , LENGTH(department) from Worker;

-- to print first name from worker tablwe after replacing 'a' with 'A'
select REPLACE(first_name, 'a', 'A') from Worker ;

-- to print first and last name into a single coljums
select CONCAT(first_name, ' ', last_name) AS complete_name from Worker;

-- print sql all worker table ascending oder by first name 
select * from Worker ORDER BY first_name;

-- ORDER BY FIRST NAME ASCENDING DEPARTMENT DESCENDING
SELECT * FROM WORKER ORDER BY first_name, department DESC;

-- details where firsty namwe is ANUJ and geetika 

SELECT * FROM Worker where first_name = 'ANUJ' OR 'Geetika';

-- DETAILS OF WORKER EXCLUDING FIRST NAME ANUJ
SELECT * FROM Worker where first_name NOT  IN ('ANUJ');

-- 15 print details of worker witrh deapartment as Adminj
select * from Worker where DEPARTMENT LIKE 'Admin%';

-- 16 whose first name start with a
select * from Worker where first_name LIKE 'A%';

-- 17 LAST name endds wioth aq
select * from worker whEre  LAST_NAME like '%a';

 -- 18 first name ends with h and contains 6 alphabets
 SELECT * from Worker where first_name like '_____h';
 
 -- salary lies between 1lac and 5 l;ac
 
 select * from Worker where salary between 10000 AND 50000;
 
 -- workers who have joinec in 2014
 select * from Worker where YEAR(joining_date) = 2014 anD month(joining_date) = 02;
 
 -- to fetch peoples wiorkiung in department admin
 select department , count(*) from  Worker where Department = 'Admin';
 
 -- fetch full name with salaries > = 50000 and <= 100000;
 select concat(first_name, ' ', last_name) from Worker where salary between 50000 and 100000;
 
 
 -- to fetch workers in each departmentr in  descending order
 select DEPARTMENT, count(worker_id) from worker group by DEPARTMENT order by count(worker_id) desc; 
 
 -- 24  tom prinmt detsails of employee whop are also manager
 select * from Worker as W inner join title as t on w.worker_id = t.worker_ref_id where t.worker_title = 'MANAGER';
 
 -- TO FETCH NUMBER MORE THAN 1 OF same  titles in the org  of different types;
 SELECT worker_title, count(*) from title group by worker_title having count(*) > 1;
 
 -- to show only odd rows from a table
  select * from Worker where MOD (WORKER_ID , 2) != 0;
  
  -- to show evem 
   select * from Worker where MOD (WORKER_ID , 2) = 0;
   
   -- to clone a new table from another tabnle
   create table clone LIKE Worker;
insert into clone select * from worker; 


select * from clone;


-- 29 intersection record of two table
select  worker .* from worker inner join clone using (worker_id)

-- to show records from one 

-- 30 to sho wrecords from one table that anothwewr doesn have
-- minus set opoerstaion
select * from Worker left join clone using(worker_id) where clone.worker_id is null;

-- sql query to showm current date and time
-- dual tables
select curdate();
select now();

-- top n records of table in descendimng\
select * from worker order by salary desc LIMIT 5;


-- 3 nth highest n =6
select * from worker order by salary desc LIMIT 5, 1;

-- without limit  5thy highes
select salary from Worker w1
where 4 = (
SELECT COUNT(DISTINCT(w2.salary))
from worker w2
where w2.salary >= w1.salary
);


-- list of employe with sdame salary
select * from Worker w1, worker w2 where w1.salary = w2.salary and w1.worker_id != w2.worker_id;

-- second highest salary from table using subquery
select max(salary) from worker where salary not in  (select max(salary) from worker);

-- 37 to show one row twice in result from table
select * from worker
union ALL
select * from worker;

-- 38 WORKER ID WHO DOES NOT GET BONUS
select worker_id from worker where worker_id not in (select worker_ref_id from bonus);

-- 39 first 50 % of record
Select * from worker where worker_id <= (select count(worker_id)/2 from worker);

-- 40, to fetch the department that have less than 4 people
select department, count(department) as depCount from worker group by department having depCount <4;

-- to show all departmant along with the number of people there
select department, count(department) as depCount from worker group by department;

-- to show last record from table
SELECT * from worker where worker_id  = (select max(worker_id) from worker);

-- to fetch first row  of a table
SELECT * from worker where worker_id  = (select min(worker_id) from worker);

-- 44 to fetch last 3 records 
(select * from worker  order by worker_id desc limit 3) order by worker_id;

-- 45 query for highest salary in each departmnet
select w.department, w.first_name, w.salary from 
(select max(salary) as maxsel, department from worker group by department) temp
inner join worker w on temp.department = w.department and temp.maxsel = w.salary;


-- 46 to fetch 3  max salary using co-releated subquery
select distinct salary from worker w1 
where 3 >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc; 
-- by limit
select distinct salary from worker order by salary desc limit 3;
--  47 sql query to fetch three min salaries from table using coreleated query
select distinct salary from worker w1 
where 3 >= (select count(distinct salary) from worker w2 where w1.salary >= w2.salary) order by w1.salary desc; 
-- to fetch nth max salary
select distinct salary from worker w1 
where 3 >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc; 

-- 49 to fetch department along with total salaries paid for the,m
select department, sum(salary) as depsel from worker group by department order by depsel desc;


-- 50 write a  sql query to fetch names of worker who earns highest salary
select first_name, salary from worker where salary = (select max(salary) from worker);



-- ADDITIONAL 51 TO REMOVE REVERSE PAIRS  FROKM A TABLE (A, B)

CREATE  DATABASE pair;
use pair;
create table pairs(
A int,
B INT
);

INSERT INTO pairs values (1,2), (2, 4), (2, 1), (3,2), (4,2), (5,6), (6,5), (7, 8);
Select * from pairs;

-- fropm joins
SELECT lt.* from pairs lt left join pairs rt on lt.A = rt.B AND lt.B = rt.A
where rt.A = NULL OR lt.A < rt.A;

-- coreleated sun query
select * from pairs p1 where not exists (select * from pairs p2 where p1.B = p2.A ANd p1.A = p2.B AND p1.A > p2.A);
-- --------------------------------------------------  THE END ---------------------------------------------------------------------------------------------------------

