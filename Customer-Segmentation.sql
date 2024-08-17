--Male vs Female:
--Getting count of female and male
--Total spending and average spending of each gender

SELECT gender,COUNT(gender) AS count,SUM(amount) AS total_spending,ROUND(AVG(amount),2) AS avg_spending
FROM shopping
GROUP BY gender

--Age Range Count:
--Grouping the ages into four groups and getting the count of them

WITH age_count AS (
SELECT CASE
	WHEN age BETWEEN 18 AND 29 THEN '18-29'
	WHEN age BETWEEN 30 AND 49 THEN '30-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
	WHEN age BETWEEN 60 AND 80 THEN '60-80' 
END AS age_range
FROM shopping
) 

SELECT age_range,COUNT(*) AS count
FROM age_count 
GROUP BY age_range
ORDER BY age_range

--Age Spent the Most:
--Identifying which age group spent the most

WITH age_count AS (
SELECT amount, CASE
	WHEN age BETWEEN 18 AND 29 THEN '18-29'
	WHEN age BETWEEN 30 AND 49 THEN '30-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
	WHEN age BETWEEN 60 AND 80 THEN '60-80' 
END AS age_range
FROM shopping
) 

SELECT age_range,SUM(amount) AS total
FROM age_count 
GROUP BY age_range
ORDER BY age_range

--Category Spending:
--Identifying which category of items is purchased the most

SELECT category,SUM(amount) AS total
FROM shopping
GROUP BY category

--Age Ranking of Category:
--Determining and ranking the item categories preferred by different age groups

WITH age_count AS (
SELECT amount,category, CASE
	WHEN age BETWEEN 18 AND 29 THEN '18-29'
	WHEN age BETWEEN 30 AND 49 THEN '30-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
	WHEN age BETWEEN 60 AND 80 THEN '60-80' 
END AS age_range
FROM shopping
),
category_spending AS( 
SELECT age_range,category,SUM(amount) AS total
FROM age_count 
GROUP BY age_range,category
ORDER BY age_range)

SELECT age_range,category,total,
RANK() OVER (PARTITION BY age_range ORDER BY total DESC)
FROM category_spending

--Review Rating Count:
--Getting the count of review rating from each customer

SELECT ROUND(review_rating,2) AS review_rating,COUNT(*) AS count FROM shopping
GROUP BY 1
ORDER BY 1

--Season Count:
--Counting the number of purchases made during each season

SELECT season,COUNT(season) AS count FROM shopping
GROUP BY season

--Location Total Amount:
--Seeing which state has the most total amount spent

SELECT location,SUM(amount) AS total_amount
FROM shopping
GROUP BY location
ORDER BY 2
