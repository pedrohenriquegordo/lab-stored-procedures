use sakila;

#1
SELECT CONCAT(first_name,' ', last_name) AS name, email
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON film.film_id = inventory.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = "Action"
GROUP BY first_name, last_name, email;

#2
DELIMITER //
CREATE PROCEDURE GetCustomersByCategory(IN category_name VARCHAR(255))
BEGIN
	SELECT CONCAT(first_name,' ', last_name) AS name, email
	FROM customer
	JOIN rental ON customer.customer_id = rental.customer_id
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON film.film_id = inventory.film_id
	JOIN film_category ON film_category.film_id = film.film_id
	JOIN category ON category.category_id = film_category.category_id
	WHERE category.name = category_name
	GROUP BY first_name, last_name, email;
END
//
DELIMITER ;

CALL GetCustomersByCategory('Action');

#3
SELECT A.name, COUNT(*) AS count
FROM category A
JOIN film_category B ON A.category_id = B.category_id
GROUP BY B.category_id;


#4
DELIMITER $$
CREATE PROCEDURE sp_GetMovieCount (IN minCount INT)
BEGIN
	SELECT A.name, COUNT(*) AS count
	FROM category A
	JOIN film_category B ON A.category_id = B.category_id
	GROUP BY B.category_id
    HAVING COUNT(*) > minCount;
END
$$
DELIMITER ;

CALL sp_GetMovieCount(60);

