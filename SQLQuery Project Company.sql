CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name  VARCHAR(40),
birth_day DATE,
sex  VARCHAR(1),
salary INT,
super_id INT FOREIGN KEY,
branch_id INT FOREIGN KEY
);

CREATE TABLE branch (
branch_id INT PRIMARY KEY,
branch_name  VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
client_id INT PRIMARY KEY,
client_name  VARCHAR(40),
branch_id INT,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
 );

CREATE TABLE works_with (
emp_id INT,
client_id INT,
total_sales INT,
PRIMARY KEY(emp_id, client_id),
FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
FOREIGN KEY(client_id) references client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
branch_id INT,
supplier_name VARCHAR(40),
supplier_type VARCHAR(40),
PRIMARY KEY(branch_id, supplier_name),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

---Corporate
INSERT INTO employee VALUES(100, 'david', 'wallace', '1967-11-17', 'M', 250000, null, null);

INSERT INTO branch VALUES(1, 'corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'jan', 'levison', '1961-05-11', 'F', 110000, 100, 1);

---Scranton
INSERT INTO employee VALUES(102, 'michael', 'scott', '1964-03-15', 'M', 750000, 100, 2);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'angel', 'marthin', '1971-06-25', 'F', 630000, 102, 2);
INSERT INTO employee VALUES(104, 'kelly', 'kapoor', '1980-02-05', 'F', 550000, 102, 2);
INSERT INTO employee VALUES(105, 'stanley', 'hudson', '1958-09-15','M', 690000, 102, 2);

---Stamford
INSERT INTO employee VALUES(106, 'josh', 'porter', '1969-09-25', 'M', 780000, 100, 3);

INSERT INTO branch VALUES(3, 'stamford', 106, '1998-04-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'andy', 'mbernard', '1977-06-22', 'M', 650000, 106, 3);
INSERT INTO employee VALUES(108, 'jim', 'Halprt', '1980-02-05', 'M', 710000, 106, 3);


---Branch_supplier
INSERT INTO branch_supplier VALUES(2, 'hammer mill', 'paper');
INSERT INTO branch_supplier VALUES(2, 'uni-ball', 'writing utensils');
INSERT INTO branch_supplier VALUES(3, 'patriot paper', 'paper');
INSERT INTO branch_supplier VALUES(2, 'j.t. forms & labels', 'custom form');
INSERT INTO branch_supplier VALUES(3, 'uni-ball', 'writing utensils');
INSERT INTO branch_supplier VALUES(3, 'hammer mill', 'paper');
INSERT INTO branch_supplier VALUES(3, 'stamford labels', 'custom form');

---client
INSERT INTO client VALUES(400, 'dunmore highschool', 2);
INSERT INTO client VALUES(401, 'lackawana country', 2);
INSERT INTO client VALUES(402, 'fedEX', 3);
INSERT INTO client VALUES(403, 'john daly law lcc', 3);
INSERT INTO client VALUES(404, 'scranton whitepages', 2);
INSERT INTO client VALUES(405, 'times newspaper', 3);
INSERT INTO client VALUES(406, 'fedEX', 2);

---works_with
INSERT INTO works_with VALUES(100, 400, 550000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 225000);
INSERT INTO works_with VALUES(107, 403, 265000);
INSERT INTO works_with VALUES(108, 403, 5000);
INSERT INTO works_with VALUES(105, 404, 330000);
INSERT INTO works_with VALUES(107, 405, 260000);
INSERT INTO works_with VALUES(102, 406, 150000);
INSERT INTO works_with VALUES(105, 406, 130000);

---find all employees
SELECT *
FROM employee;

---- find all employees ordered by salary
SELECT *
FROM employee
ORDER BY salary DESC;

----find all employee ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

---select the first five employees
SELECT *
FROM employee
LIMIT 5;

---FIND THE LASTNAME AND SURNAME OF ALL EMPLOYEES
SELECT first_name AS forename, last_name AS surname
FROM employee;

--find the number of employee
SELECT COUNT(emp_id)
FROM employee;

---find the number of female born in 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

--- find the average of all employees salaries
SELECT AVG(salary)
FROM employee;

--- find the average of all MALE employees salaries
SELECT AVG(salary)
FROM employee
WHERE sex = 'M'

---find how many male and females are in the company
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

---find the total sales of each saleman
SELECT SUM(total_sale), emp_id
FROM works_with
GROUP BY emp_id;

---Find any client who are in LCC
SELECT * FROM client
WHERE client_name LIKE '%LCC' -- USED A WILD CARD WHICH WILL GET ANY NAME ENDING WITH LCC

--- FIND ANY BRANCH SUPPLIER WHO ARE IN THE LABEL BUSINESS
SELECT * FROM branch_supplier
WHERE supplier_name LIKE '%label%'


--- find any employee born in october
--- FIND ANY BRANCH SUPPLIER WHO ARE IN THE LABEL BUSINESS
SELECT * FROM employee
WHERE birth_day LIKE '%_ _ _-10%'

---Union in SQL
--find a list of employee and branch
SELECT first_name FROM employee
UNION
SELECT branch_name FROM branch;

---find all branchs and their manger---Union in SQL
--find a list of employee and branch
SELECT employee.emp_id, employee.first_name, branch.branch_name
 FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id





