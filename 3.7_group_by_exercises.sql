USE titles;
-- 2
SELECT DISTINCT title FROM titles;
-- 3
SELECT last_name FROM employees WHERE last_name LIKE 'e%e' GROUP BY last_name;
-- 4
SELECT concat(first_name,' ', last_name) AS 'full_name' FROM employees WHERE last_name LIKE 'e%e' GROUP BY full_name;
-- 5
SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
-- 6
SELECT last_name, count(*) count FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name ORDER BY last_name;
-- 7
SELECT count(*), gender FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya')  GROUP BY gender;
-- 8
SELECT count(*), (lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), '_', substr(birth_date, 6, 2), substr(birth_date, 3,2)))) AS username FROM employees GROUP BY username;
