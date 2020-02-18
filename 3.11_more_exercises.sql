USE employees;

/* How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
SELECT emp_no, dept_no,dept_name, salary AS manager_salary FROM dept_manager dm
JOIN salaries s USING(emp_no)
JOIN departments d USING (dept_no)
WHERE dm.to_date > now() AND s.to_date > now() ;

SELECT dept_no,dept_name, AVG(salary) FROM salaries s
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
WHERE de.to_date > now() AND s.to_date > now() GROUP BY dept_name ORDER BY dept_no;*/

SELECT  d.dept_no, d.dept_name, salary AS manager_salary, group_avg_salary.avg_salary FROM dept_manager dm
JOIN salaries s USING(emp_no)
JOIN departments d USING (dept_no)
JOIN (
      SELECT dept_no,dept_name, AVG(salary) AS avg_salary FROM salaries s
      JOIN dept_emp de USING (emp_no)
      JOIN departments d USING (dept_no)
      WHERE de.to_date > now() AND s.to_date > now() GROUP BY dept_name ORDER BY dept_no
      ) AS group_avg_salary USING (dept_no)
WHERE dm.to_date > now() AND s.to_date > now();
-- Apparently, managers' salaries from Production and Customer Service are paid less than their department's avergae salary


USE world;

-- What languages are spoken in Santa Monica?
SELECT LANGUAGE, percentage FROM countrylanguage WHERE countrycode IN (SELECT countrycode FROM city WHERE NAME = 'Santa Monica') ORDER BY percentage;

-- How many different countries are in each region?
SELECT region, count(*) AS num_countries FROM country GROUP BY region ORDER BY num_countries;


-- What is the population for each region?
SELECT region, sum(population) FROM country GROUP BY region ORDER BY sum(population) DESC;


-- What is the population for each continent?
SELECT continent, sum(population) FROM country GROUP BY continent ORDER BY sum(population) DESC


-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country WHERE LifeExpectancy IS NOT NULL;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT continent, AVG(LifeExpectancy) LifeExpectancy FROM country GROUP BY continent ORDER BY AVG(LifeExpectancy);
SELECT  region, AVG(LifeExpectancy) LifeExpectancy FROM country GROUP BY region ORDER BY AVG(LifeExpectancy);

-- Find all the countries whose local name is different from the official name
SELECT NAME FROM country WHERE NAME != LocalName;

-- How many countries have a life expectancy less than x? Bulgaria
SELECT NAME FROM country WHERE LifeExpectancy < 70.9;

-- What state is city x located in?
SELECT countrycode, country.name FROM city 
JOIN country 
ON country.code = city.countrycode
WHERE city.NAME = 'oran';

-- What region of the world is city x located in?
SELECT city.name, country.region FROM country
JOIN city
ON country.code = city.countrycode
WHERE city.NAME = 'leiden';

-- What country (use the human readable name) city x located in?
SELECT city.name city_name, country.name country_name FROM country
JOIN city
ON country.code = city.countrycode
WHERE city.NAME = 'breda';

-- What is the life expectancy in city x?
SELECT city.name city_name, country.lifeexpectancy  Life_Expectancy FROM country
JOIN city
ON country.code = city.countrycode
WHERE city.NAME = 'dubai';

USE sakila;

SELECT lower(first_name), lower(last_name) FROM actor;

SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

SELECT first_name, last_name FROM actor WHERE last_name LIKE '%gen%';

SELECT first_name, last_name FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;

SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, count(*) count FROM actor GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, count FROM ((SELECT last_name, count(*) AS count FROM actor GROUP BY last_name) AS newtable) WHERE count >= 2;

-- Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address FROM staff
JOIN address USING (address_id);

-- Use JOIN to display the total amount rung up by each staff member in August of 2005
SELECT first_name, last_name, sum(amount) total_amount FROM payment 
JOIN staff USING (staff_id)
GROUP BY staff_id;

-- List each film and the number of actors who are listed for that film
SELECT title, count(actor_id) FROM film
JOIN film_actor USING (film_id) GROUP BY title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, count(film_id) FROM inventory 
JOIN film USING(film_id)
WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Hunchback Impossible') GROUP BY film_id;

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title FROM film WHERE (title LIKE 'k%' OR title LIKE 'q%') AND language_id = 1;

-- Use subqueries to display all actors who appear in the film Alone Trip
SELECT film_id, title, actor_id, first_name, last_name FROM film 
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE title = 'alone trip';

SELECT concat(first_name, ' ', last_name) AS full_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor JOIN film USING (film_id) WHERE title = 'alone trip');


-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers
SELECT first_name, last_name, email, address_id, city_id, country_id, country FROM customer
JOIN address USING (address_id)
JOIN city USING(city_id)
JOIN country USING (country_id)
WHERE country = 'Canada';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT title movie_title FROM film WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE category_id = 8));

-- Write a query to display how much business, in dollars, each store brought in.
SELECT  store_id, staff_id, sum(amount) FROM payment
JOIN staff USING (staff_id) GROUP BY staff_id;

-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country FROM store 
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

-- List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT DISTINCT last_name FROM actor;
SELECT DISTINCT postal_code FROM address;
SELECT DISTINCT rating FROM film;

SELECT title, description, rating, length FROM film WHERE length >= 3 * 60;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= 05/27/2005; 
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005
SELECT  payment_id, amount, payment_date FROM payment  WHERE payment_date = '2005-05-27';
SELECT * FROM customer WHERE last_name LIKE 's%' AND first_name LIKE '%n';
SELECT * FROM customer WHERE active = '0' OR last_name LIKE 'm%';
SELECT * FROM category WHERE category_id > 4 AND (NAME LIKE 'c%' OR NAME LIKE 's%' OR NAME LIKE 't%');
-- Select all columns minus the password column from the staff table for rows that contain a password.
SELECT * FROM staff WHERE PASSWORD IS NULL;
SELECT * FROM staff WHERE PASSWORD IS NOT NULL;

SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');

SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

SELECT * FROM film WHERE length BETWEEN '100' AND '120';

SELECT * FROM film WHERE description LIKE 'A Thoughtful%';

SELECT * FROM film WHERE description  LIKE '%boat';

SELECT * FROM film WHERE description LIKE '%database%' AND length > 180;

SELECT * FROM payment LIMIT 20;

-- SELECT the payment DATE AND amount COLUMNS FROM the payment TABLE FOR ROWS WHERE the payment amount IS greater THAN 5, AND only SELECT ROWS whose zero-based INDEX IN the result SET IS BETWEEN 1000-2000
SELECT payment_date, amount FROM payment WHERE amount > '5' LIMIT 1001 OFFSET 999;

SELECT * FROM customer LIMIT 100 OFFSET 101;


SELECT * FROM film ORDER BY length;


SELECT DISTINCT rating FROM film ORDER BY rating DESC;

SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;

SELECT title, description, special_features, length, rental_duration FROM film WHERE length < 120 AND rental_duration BETWEEN 5 AND 7 ORDER BY length DESC LIMIT 10;

