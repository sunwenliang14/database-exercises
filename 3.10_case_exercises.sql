SELECT * FROM dept_emp;
SELECT emp_no, dept_no, to_date, to_date = '9999-01-01' AS is_current_employee
FROM dept_emp;


SELECT  first_name, last_name,
        CASE 
            WHEN LEFT(last_name, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
            WHEN LEFT(last_name, 1) IN ('i', 'j', 'k', 'l','m','n','o','p','q') THEN 'I-Q'
            ELSE 'R-Z'
            END AS alpha_group
FROM employees;


SELECT count(*),
       CASE
       WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
       WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
       WHEN YEAR(birth_date) BETWEEN 1970 AND 1979 THEN '1970s'
       WHEN YEAR(birth_date) BETWEEN 1980 AND 1989 THEN '1980s'
       ELSE '1990s'
       END AS diff_generations
FROM employees GROUP BY diff_generations;


SELECT DISTINCT
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group
FROM employees.departments;


SELECT AVG(salary) FROM salaries s
JOIN dept_emp de USING(emp_no) 
WHERE s.to_date > now() AND de.to_date > now() AND dept_no = 'd009';

SELECT AVG(salary) FROM salaries s
JOIN dept_emp de USING(emp_no) 
WHERE s.to_date > now() AND de.to_date > now() AND (dept_no = 'd002' OR dept_no = 'd003');

SELECT AVG(salary) FROM salaries s
JOIN dept_emp de USING(emp_no) 
WHERE s.to_date > now() AND de.to_date > now() AND (dept_no = 'd001' OR dept_no = 'd007');

SELECT AVG(salary) FROM salaries s
JOIN dept_emp de USING(emp_no) 
WHERE s.to_date > now() AND de.to_date > now() AND (dept_no = 'd004' OR dept_no = 'd006');

SELECT AVG(salary) FROM salaries s
JOIN dept_emp de USING(emp_no) 
WHERE s.to_date > now() AND de.to_date > now() AND (dept_no = 'd005' OR dept_no = 'd008');



CREATE TEMPORARY TABLE avg_salary_for_each_dept AS
SELECT DISTINCT
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group
FROM employees.departments;


ALTER TABLE avg_salary_for_each_dept ADD COLUMN avg_salary FLOAT;
SELECT * FROM avg_salary_for_each_dept;

UPDATE avg_salary_for_each_dept
SET avg_salary = '67285'
WHERE 
dept_group = 'Customer Service';

UPDATE avg_salary_for_each_dept
SET avg_salary = '71107'
WHERE 
dept_group = 'R&D';

UPDATE avg_salary_for_each_dept
SET avg_salary = '86369'
WHERE 
dept_group = 'Finance & HR';

UPDATE avg_salary_for_each_dept
SET avg_salary = '67329'
WHERE 
dept_group = 'Sales & Marketing';

UPDATE avg_salary_for_each_dept
SET avg_salary = '67709'
WHERE 
dept_group = 'Prod & QM';

SELECT * FROM avg_salary_for_each_dept;