CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;
SELECT * FROM employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
SELECT * FROM employees_with_departments;
UPDATE employees_with_departments
SET full_name = concat(first_name, ' ', last_name);
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
SELECT * FROM employees_with_departments;


CREATE TEMPORARY TABLE new_payment AS SELECT amount FROM sakila.payment;
SELECT * FROM new_payment;
UPDATE new_payment 
SET amount = 100 * amount;
DESCRIBE new_payment;
ALTER TABLE new_payment 
MODIFY COLUMN amount FLOAT;
ALTER TABLE new_payment 
MODIFY COLUMN amount INT;
SELECT * FROM new_payment;



-- 3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

CREATE TABLE mean SELECT  dept_name, AVG(salary) AS avg_s FROM employees.salaries s 
JOIN employees.dept_emp de USING (emp_no)
JOIN employees.departments d USING (dept_no)
WHERE s.to_date > now() AND de.to_date > now() GROUP BY dept_name;
SELECT dept_name, salary_z_score FROM mean;


ALTER TABLE mean ADD COLUMN salary_z_score  FLOAT ;
UPDATE mean 
SET salary_z_score = (avg_s - (SELECT AVG(salary)  FROM employees.salaries WHERE to_date > now())
) 
/ 
(SELECT stddev(salary) FROM employees.salaries WHERE to_date > now());
SELECT * FROM mean;