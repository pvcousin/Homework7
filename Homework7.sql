USE sakila;

#1a
SELECT first_name, last_name 
FROM actor;

#1b
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name" FROM actor;

#2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'Joe';

#2b
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

#2c
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

#2d
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

#3a
ALTER TABLE actor
ADD COLUMN description BLOB(50) AFTER last_name;

SELECT * FROM actor;

#3b
ALTER TABLE actor DROP description;

SELECT * FROM actor;

#4a
SELECT last_name, count(last_name) AS "Count"
FROM actor
GROUP BY last_name;

#4b
SELECT last_name, count(last_name) AS "Count"
FROM actor
GROUP BY last_name
HAVING Count > 1;

#4c
SET SQL_SAFE_UPDATES = 0;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

SELECT first_name, last_name
FROM actor
WHERE first_name = "HARPO";

#4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

SELECT first_name, last_name
FROM actor
WHERE first_name = "GROUCHO";

SET SQL_SAFE_UPDATES = 1;

#5a
desc address;

#6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id = address.address_id;

#6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Staff Sales'
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '%2005-08%'
GROUP BY staff.staff_id;

#6c
SELECT title, COUNT(film_actor.film_id)
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title;

#6d
SELECT COUNT(*)
FROM inventory
WHERE film_id in
(
 SELECT film_id
 FROM film
 WHERE title = 'Hunchback Impossible'
 );
 
#6e
SELECT customer.first_name, customer.last_name, SUM(amount)
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

#7a - And buddy that was good enough for me. Good enough for me and Bobbi McGee.
SELECT title
FROM film
WHERE language_id in
(
 SELECT language_id
 FROM language
 WHERE language.name = 'English'
 )
 AND title LIKE 'k%' or title LIKE 'q%';
 
#7b
SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor_id in
(
 SELECT actor_id
 FROM film_actor
 WHERE film_id in
 (
  SELECT film_id
  FROM film
  WHERE title = 'Alone Trip'
  ));
  
#7c
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address on customer.address_id = address.address_id
JOIN city on address.city_id = city.city_id
JOIN country on city.country_id = country.country_id
WHERE country.country = 'Canada';

#7d
SELECT title 
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

#7e
SELECT film.title, count(rental.rental_id) AS times_rented
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY times_rented DESC;

#7f
SELECT store.store_id, sum(payment.amount)
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

#7g
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

#7h
SELECT category.name, sum(payment.amount) AS gross_revenue
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

#8a
CREATE VIEW top_genre_rev AS
	SELECT category.name, sum(payment.amount) AS gross_revenue
	FROM category
	JOIN film_category ON category.category_id = film_category.category_id
	JOIN inventory ON film_category.film_id = inventory.film_id
	JOIN rental ON inventory.inventory_id = rental.inventory_id
	JOIN payment ON rental.rental_id = payment.rental_id
	GROUP BY category.name
	ORDER BY gross_revenue DESC
	LIMIT 5;

#8b
SELECT *
FROM top_genre_rev;

#8c
DROP VIEW top_genre_rev;






