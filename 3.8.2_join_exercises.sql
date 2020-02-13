USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;


SELECT users.name AS user_name, roles.name AS role_name
FROM users 
JOIN roles ON users.role_id = roles.id;


SELECT users.name AS user_name, roles.name AS role_name
FROM users 
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users 
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT r.name, count(*)
FROM r
LEFT JOIN u ON u.role_id = r.id
GROUP BY r.name

USE employees;
/*SELECT dept_name, concat(first_name, '', last_name) AS Department_Manager from employees_with_departments as e
join dept_manager as d on d.emp_no = e.emp_no
WHERE d.to_date="9999-01-01";*/

-- 2
SELECT  d.dept_name, CONCAT(first_name, ' ', last_name) AS Department_Manager
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'ORDER BY d.dept_name;

-- 3
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name'
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND gender = 'F' ORDER BY d.dept_name; 

-- 4
SELECT title 'Title', count(*) 'Count' FROM titles
JOIN dept_emp AS de 
ON titles.emp_no = de.emp_no
JOIN departments 
ON departments.dept_no = de.dept_no 
WHERE dept_name = 'customer service' AND titles.to_date = "9999-01-01" AND de.to_date = "9999-01-01" GROUP BY title ;

-- 5
SELECT  dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name', salary 'Salary'
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries 
ON salaries.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01' ORDER BY d.dept_name;

-- 6
SELECT d.dept_no, d.dept_name, count(*) num_employees FROM departments d
JOIN dept_emp 
ON d.dept_no = dept_emp.dept_no
JOIN
employees e
ON dept_emp.emp_no = e.emp_no
WHERE dept_emp.to_date = '9999-01-01' GROUP BY dept_name  ORDER BY dept_no ;

-- 7
SELECT d.dept_name, AVG(salary) aver_s FROM departments d
JOIN dept_emp 
ON d.dept_no = dept_emp.dept_no
JOIN
salaries s
ON dept_emp.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND dept_emp.to_date  = '9999-01-01'
GROUP BY dept_name ORDER BY aver_s DESC LIMIT 1 ;

-- 8 
SELECT first_name, last_name FROM employees e
JOIN dept_emp 
ON e.emp_no = dept_emp.emp_no
JOIN departments d 
ON d.dept_no = dept_emp.dept_no
JOIN salaries s
ON s.emp_no = dept_emp.emp_no
WHERE d.dept_name = 'Marketing' ORDER BY salary DESC LIMIT 1;

-- 9
SELECT first_name, last_name, salary, dept_name FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no
JOIN departments d 
ON d.dept_no = dm.dept_no
JOIN salaries s
ON s.emp_no = dm.emp_no 
WHERE dm.to_date = '9999-01-01'  AND s.to_date = '9999-01-01' ORDER BY salary DESC LIMIT 1;

-- 10
SELECT CONCAT(first_name, ' ', last_name) AS 'Employee Name', depart_name,  FROM employees e
JOIN dept_emp
ON dept_emp.emp_no = e.emp_no
JOIN departments d
ON dept_emp.dept_no = d.dept_no
JOIN dept_manager dm 
ON d.dept_no = dm.dept_no

-- 11
USE employees; 
​
SELECT 	-- salaries.emp_no, 
		-- max_salary.dept_no, 
        emp.first_name, 
        emp.last_name, 
        dept.dept_name, 
        max_salary.max_salary
FROM salaries
-- join the max salary with the salaries from the salaries tables. The salaries table will provide the employee number. 
JOIN (
	-- get the max salary for each department
	SELECT MAX(all_salaries.salary) AS max_salary, all_salaries.dept_no 
	FROM	
    -- get all salaries for each current employee for each department
		(SELECT dept_emp.emp_no, dept_emp.dept_no, dept_emp.to_date, s.salary
		FROM dept_emp
		JOIN salaries s USING (emp_no)
          WHERE dept_emp.to_date > NOW() AND s.to_date > now()
          ) all_salaries
	GROUP BY all_salaries.dept_no
     ) max_salary ON salaries.salary = max_salary.max_salary
-- join employees table to provide the employee names
JOIN employees emp ON salaries.emp_no = emp.emp_no
-- join departments table to provide the department names
JOIN departments dept ON max_salary.dept_no = dept.dept_no
-- ensure we are only joining with only those salaries that are current, otherwise we will end up with employees whose old salary possibly matched the current max. 
WHERE salaries.to_date > NOW()
; 







