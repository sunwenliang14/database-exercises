SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;


SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date IN (SELECT hire_date FROM employees WHERE emp_no = 101010);

-- Find all the titles held by all employees with the first name Aamod
SELECT emp_no, title FROM titles 
WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod');

-- How many people in the employees table are no longer working for the company
SELECT * FROM employees 
WHERE emp_no NOT IN (SELECT emp_no FROM dept_emp WHERE to_date > now());

-- Find all the current department managers that are female
SELECT first_name, last_name FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE dept_manager.to_date > curdate()) AND gender = 'F';

-- Find all the employees that currently have a higher than average salary
SELECT first_name, last_name, salary FROM employees e
JOIN salaries s
ON s.emp_no = e.emp_no
WHERE e.emp_no IN
	(
	SELECT emp_no 
	FROM salaries 
	WHERE salary > (
					SELECT AVG(salary) FROM salaries
					)
	AND to_date > now()
	)
	AND to_date > now()
;

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


SELECT count(*) FROM salaries 
WHERE salary BETWEEN ((SELECT max(salary) FROM salaries) - (SELECT stddev(salary) FROM salaries)) AND (SELECT max(salary) FROM salaries) 
 AND to_date > now();
 
SELECT (SELECT count(*) FROM salaries 
WHERE salary BETWEEN ((SELECT max(salary) FROM salaries) - (SELECT stddev(salary) FROM salaries)) AND (SELECT max(salary) FROM salaries) 
 AND to_date > now()
) AS coounts, (SELECT count(*) FROM salaries 
WHERE salary BETWEEN ((SELECT max(salary) FROM salaries) - (SELECT stddev(salary) FROM salaries)) AND (SELECT max(salary) FROM salaries) 
 AND to_date > now()) / (SELECT count(*) FROM salaries WHERE to_date > now()) AS percentage_in_all_salary;


-- Find all the department names that currently have female managers

SELECT dept_name FROM departments
       WHERE dept_no IN 
           (
            SELECT dept_no FROM dept_manager WHERE emp_no IN
               (
                SELECT emp_no FROM employees WHERE gender = 'F'
                                                               ) AND to_date > now()
                                                                                    );
                                                                                    
-- Find the first and last name of the employee with the highest salary

SELECT first_name, last_name FROM employees WHERE emp_no = (SELECT emp_no FROM salaries WHERE salary = (SELECT (max(salary) FROM salaries)));      





