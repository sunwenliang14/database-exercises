USE employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no desc;

SELECT upper(CONCAT(first_name,' ', last_name)) AS full_name FROM employees WHERE last_name LIKE 'E%E' ;

SELECT datediff(now(), hire_date) AS dats_of_difference FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25';

SELECT min(salary), max(salary) FROM salaries;

SELECT (lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), '_', substr(birth_date, 6, 2), substr(birth_date, 3,2)))) AS username,first_name, last_name, birth_date FROM employees LIMIT 10;
