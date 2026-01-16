CREATE TABLE zomato (
    name VARCHAR(255),
    online_order VARCHAR(10),
    book_table VARCHAR(10),
    rating FLOAT,
    votes INT,
    cost_for_two INT,
    restaurant_type VARCHAR(100)
);
select count(*) from zomato

-- Online Order Impact
SELECT online_order, ROUND(AVG(rate),2) AS avg_rating
FROM zomato
GROUP BY online_order;


ALTER TABLE zomato
CHANGE `approx_cost(for two people)` cost_for_two INT;

-- Best Price Range
SELECT
CASE
    WHEN cost_for_two < 300 THEN 'Low'
    WHEN cost_for_two BETWEEN 300 AND 600 THEN 'Medium'
    ELSE 'High'
END AS price_category,
AVG(rate) AS avg_rating
FROM zomato
GROUP BY price_category;

-- Top Performing Restaurants
SELECT name, rate, votes
FROM zomato
ORDER BY rate DESC, votes DESC
LIMIT 10;


-- Engagement Score
SELECT
name,
rate,
votes,
ROUND(rate * (votes / (SELECT MAX(votes) FROM zomato)), 2) AS rating_reliability
FROM zomato
ORDER BY rating_reliability DESC;


-- Price Category Performance
SELECT
    price_category,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rate), 2) AS avg_rating
FROM (
    SELECT *,
        CASE
            WHEN cost_for_two < 300 THEN 'Low'
            WHEN cost_for_two BETWEEN 300 AND 600 THEN 'Medium'
            ELSE 'High'
        END AS price_category
    FROM zomato
) t
GROUP BY price_category;


