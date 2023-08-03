											-- Database Creation-

-- Writing the Query to create a Database
DROP DATABASE IF EXISTS vehdb;
CREATE DATABASE vehdb;

-- Query to call Database
USE vehdb;


-- [3] Creating the tables:
-- Syntax to create table-
-- CREATE TABLE-

-- To drop the table if it already exists-
DROP DATABASE IF EXISTS vehdb;

-- To create temporary table- 
CREATE TABLE temp_t(
	shipper_id INTEGER,
shipper_name VARCHAR(50),
shipper_contact_details VARCHAR(30),
product_id INTEGER,
vehicle_maker VARCHAR(60),
vehicle_model VARCHAR(60),
vehicle_color VARCHAR(60),
vehicle_model_year INTEGER,
vehicle_price DECIMAL(14,2),
quantity INTEGER,
discount DECIMAL(4,2),
customer_id VARCHAR(25),
customer_name VARCHAR(25),
gender VARCHAR(15),
job_title VARCHAR(50),
phone_number VARCHAR(20),
email_address VARCHAR(50),
city VARCHAR(25),
country VARCHAR(40),
state VARCHAR(40),
customer_address VARCHAR(50),
order_date DATE,
order_id VARCHAR(25),
ship_date DATE,
ship_mode VARCHAR(25),
shipping VARCHAR(20),
postal_code INTEGER,
credit_card_type VARCHAR(40),
credit_card_number BIGINT,
customer_feedback VARCHAR(20),
quarter_number INTEGER,
PRIMARY KEY(shipper_id, product_id, customer_id, order_id)
	);                                             

-- To create vehicles main table- 
CREATE TABLE Vehdb_main_t(
	shipper_id INTEGER,
shipper_name VARCHAR(50),
shipper_contact_details VARCHAR(30),
product_id INTEGER,
vehicle_maker VARCHAR(60),
vehicle_model VARCHAR(60),
vehicle_color VARCHAR(60),
vehicle_model_year INTEGER,
vehicle_price DECIMAL(14,2),
quantity INTEGER,
discount DECIMAL(4,2),
customer_id VARCHAR(25),
customer_name VARCHAR(25),
gender VARCHAR(15),
job_title VARCHAR(50),
phone_number VARCHAR(20),
email_address VARCHAR(50),
city VARCHAR(25),
country VARCHAR(40),
state VARCHAR(40),
customer_address VARCHAR(50),
order_date DATE,
order_id VARCHAR(25),
ship_date DATE,
ship_mode VARCHAR(25),
shipping VARCHAR(20),
postal_code INTEGER,
credit_card_type VARCHAR(40),
credit_card_number BIGINT,
customer_feedback VARCHAR(20),
quarter_number INTEGER,
PRIMARY KEY(shipper_id, product_id, customer_id, order_id)
	);
    
-- To create the orders table- 
CREATE TABLE vehdb_ord_t(
ORDER_ID VARCHAR(25),
CUSTOMER_ID VARCHAR(25),
SHIPPER_ID INTEGER,
PRODUCT_ID INTEGER,
QUANTITY INTEGER,
VEHICLE_PRICE DECIMAL(14,2),
ORDER_DATE DATE,
SHIP_DATE DATE,
DISCOUNT DECIMAL(4,2),
SHIP_MODE VARCHAR(25),
SHIPPING VARCHAR(20),
CUSTOMER_FEEDBACK VARCHAR(20),
QUARTER_NUMBER INTEGER,

PRIMARY KEY(order_id)
);

-- To create the customers table- 
CREATE TABLE vehdb_cust_t(
	customer_id VARCHAR(25),
    customer_name VARCHAR(25),
	gender VARCHAR(15),
	job_title VARCHAR(50),
	phone_number VARCHAR(20),
	email_address VARCHAR(50),
	city VARCHAR(25),
	country VARCHAR(40),
	state VARCHAR(40),
	customer_address VARCHAR(50),
    postal_code INTEGER,
	credit_card_type VARCHAR(40),
	credit_card_number BIGINT,

PRIMARY KEY(customer_id)
);

-- To create the customers table- 
CREATE TABLE vehdb_product_t(
PRODUCT_ID INTEGER,
VEHICLE_MAKER VARCHAR(60),
VEHICLE_MODEL VARCHAR(60),
VEHICLE_COLOR VARCHAR(60),
VEHICLE_MODEL_YEAR INTEGER,
VEHICLE_PRICE DECIMAL(14,2),

PRIMARY KEY(product_id)
);

-- To create the customers table-
CREATE TABLE vehdb_shipper_t(
SHIPPER_ID INTEGER,
SHIPPER_NAME VARCHAR(50),
SHIPPER_CONTACT_DETAILS VARCHAR(30),


PRIMARY KEY(shipper_id)

);

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:
-- Syntax to create a stored procedure-
USE vehdb;

-- To drop the stored procedure if already exists- 


-- Creating the stored procedure for vehicles_p-
DELIMITER $$
CREATE PROCEDURE vehdb_main_p()
BEGIN
INSERT INTO vehdb_main_t (
	shipper_id ,
	shipper_name,
	shipper_contact_details,
	product_id,
	vehicle_maker,
	vehicle_model,
	vehicle_color,
	vehicle_model_year,
	vehicle_price,
	quantity,
	discount,
	customer_id,
	customer_name,
	gender,
	job_title,
	phone_number,
	email_address,
	city,
	country,
	state,
	customer_address,
	order_date,
	order_id,
	ship_date ,
	ship_mode,
	shipping,
	postal_code,
	credit_card_type,
	credit_card_number,
	customer_feedback,
	quarter_number
    )
    SELECT * FROM temp_t;
    END;
    
    CALL vehdb_main_p;

-- Creating the stored procedure for orders_p-
DELIMITER $$
CREATE PROCEDURE vehdb_ord_p(quarter_number INTEGER)
BEGIN
	INSERT INTO vehdb_ord_t (
		order_id,
		customer_id,
		shipper_id,
		product_id,
		quantity,
		vehicle_price,
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number
) 
	SELECT DISTINCT
		order_id,
		customer_id,
		shipper_id,
		product_id,
		quantity,
		vehicle_price,
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number
	FROM vehdb_main_t WHERE order_id NOT IN (select distinct order_id FROM vehdb_ord_t);
END;

CALL vehdb_ord_p(1);
CALL vehdb_ord_p(2);
CALL vehdb_ord_p(3);
CALL vehdb_ord_p(4);

-- Creating the stored procedure for customer_p-
DELIMITER $$
CREATE PROCEDURE vehdb_cust_p()
BEGIN
INSERT INTO vehdb_cust_t (
customer_id,
	customer_name,
	gender,
	job_title,
	phone_number,
	email_address,
	city,
	country,
	state,
    customer_address,
	postal_code,
	credit_card_type,
	credit_card_number
) 
SELECT DISTINCT
customer_id,
	customer_name,
	gender,
	job_title,
	phone_number,
	email_address,
	city,
	country,
	state,
	customer_address,
	postal_code,
	credit_card_type,
	credit_card_number
FROM vehdb_main_t WHERE customer_id NOT IN (select distinct customer_id FROM vehdb_cust_t);
END;

CALL vehdb_cust_p();

-- Creating the stored procedure for product_p-
DELIMITER $$
CREATE PROCEDURE vehdb_product_p()
BEGIN
	INSERT INTO vehdb_product_t (
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
) 
	SELECT DISTINCT
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
	FROM vehdb_main_t WHERE product_id NOT IN (select distinct product_id FROM vehdb_product_t);
END;

CALL vehdb_product_p();

-- Creating the stored procedure for shipper_p--
DELIMITER $$
CREATE PROCEDURE vehdb_shipper_p()
BEGIN
	INSERT INTO vehdb_shipper_t (
		shipper_id,
		shipper_name,
        shipper_contact_details
)
	SELECT DISTINCT
		shipper_id,
		shipper_name,
		shipper_contact_details
	FROM vehdb_main_t WHERE shipper_id NOT IN (select distinct shipper_id FROM vehdb_shipper_t);
END;

CALL vehdb_shipper_p();

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
TRUNCATE temp_t;

LOAD DATA INFILE"C://ProgramData//MySQL//MySQL Server 8.0//Uploads//new_wheels_proj (2)//Data//new_wheels_sales_qtr_1.csv"
INTO TABLE temp_t
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- call vehicles_p();
-- call customer_p();
-- call product_p();
-- call shipper_p();
-- call order_p();

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:
-- Syntax to create view for the product customer view-
CREATE VIEW vehdb_prod_cust_v AS
SELECT C.customer_id,
	C.customer_name,
	C.gender,
    C.job_title,
    C.phone_number,
    C.email_address,
    C.city,
    C.country,
    C.state,
    C.customer_address,
    C.postal_code,
    C.credit_card_type,
    C.credit_card_number,
    P.product_id,
    P.vehicle_maker,
    P.vehicle_model,
    P.vehicle_color,
    P.vehicle_model_year,
    P.vehicle_price
    FROM vehdb_ord_t as O
INNER JOIN vehdb_cust_t as C
ON O.customer_id = C.customer_id
INNER JOIN vehdb_product_t as P
ON O.product_id = P.product_id

-- Syntax to create view for the order customer view-

CREATE VIEW vehdb_ord_cust_v AS
SELECT O.order_id,
	O.customer_id,
    O.shipper_id,
    O.product_id,
    O.quantity,
    O.vehicle_price,
    O.order_date,
    O.ship_date,
    O.discount,
    O.shipping,
    O.customer_feedback,
    O.quarter_number,
    C.customer_name,
	C.gender,
    C.job_title,
    C.phone_number,
    C.email_address,
    C.city,
    C.country,
    C.state,
    C.customer_address,
    C.postal_code,
    C.credit_card_type,
    C.credit_card_number
FROM vehdb_ord_t as O
INNER JOIN vehdb_cust_t as C
ON O.customer_id = C.customer_id


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:
-- Syntax to create the function calc_revenue_f-

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (vehicle_price DECIMAL(10,2), quantity int, discount DECIMAL(4,2)) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
	DECLARE revenue DECIMAL;
   
    SET revenue= vehicle_price*quantity*discount;
    Return (revenue);
END;

-- Syntax to create the function days_to_ship_f-

DELIMITER $$
CREATE FUNCTION days_to_ship_f (ship_date DATE, order_date DATE) 
RETURNS INTEGER
DETERMINISTIC
BEGIN 
DECLARE days INTEGER;
SET days=DATEDIFF(ship_date, order_date);
RETURN (days);


END;

/*-----------------------------------------------------------------------------------------------------------------------------------


                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
-- Distribution of customers across states-
     
SELECT COUNT(customer_id) AS customer_count,
	state
FROM vehdb_ord_cust_v
GROUP BY state;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Solution-
WITH average_rating as 
(
SELECT
		customer_id,
        quarter_number,
        CASE 
			WHEN customer_feedback= 'Very Bad' THEN 1
			WHEN customer_feedback= 'Bad' THEN 2
			WHEN customer_feedback= 'Okay' THEN 3
			WHEN customer_feedback= 'Good' THEN 4
			WHEN customer_feedback= 'Very Good' THEN 5
        END AS rating
FROM vehdb_ord_cust_v
)
SELECT AVG(rating) AS Avg_rating, 
		quarter_number

FROM average_rating 
GROUP BY quarter_number
ORDER BY quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question*/
      
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.
SELECT SUM(quantity) AS Customer_total, Vehicle_maker
		FROM vehdb_ord_cust_v AS o
        INNER JOIN vehdb_prod_cust_v AS p
        ON o.product_id=p.product_id
GROUP BY vehicle_maker
ORDER BY Customer_total DESC
LIMIT 5 ;
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

SELECT COUNT(o.customer_id) AS Cust_id,
  vehicle_maker,
  o.state,
  RANK() OVER(PARTITION BY o.state
  ORDER BY vehicle_maker ASC )Pref_veh_mk_Rank
FROM vehdb_ord_cust_v o
  INNER JOIN vehdb_prod_cust_v AS pr
ON o.product_id = o.product_id
GROUP BY o.state;
-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?
SELECT COUNT(order_id) AS Number_of_orders,
  quarter_number
FROM vehdb_ord_cust_v
GROUP BY quarter_number;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 
WITH QoQ AS
(
SELECT
quarter_number,
SUM(calc_revenue_f(vehicle_price, quantity, discount))AS Revenue
FROM vehdb_ord_cust_v

GROUP BY 1
)
SELECT
quarter_number,
    revenue,
    LAG(revenue) OVER (ORDER BY quarter_number) AS previous_quarter_revenue,
    ((revenue - LAG(revenue) OVER (ORDER BY quarter_number))/LAG(revenue) OVER(ORDER BY quarter_number) * 100) AS "quarter_over_quarter_revenue(%)"
FROM
QOQ;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

SELECT  COUNT(order_id) Total_orders,
   SUM(calc_revenue_f(vehicle_price, quantity, discount)) AS Revenue,
        Quarter_number
FROM vehdb_ord_cust_v
GROUP BY  Quarter_number
ORDER BY Quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?
SELECT AVG(discount) AS Avg_Discount,
  credit_card_type
FROM vehdb_ord_cust_v
GROUP BY credit_card_type;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
  SELECT quarter_number,
  AVG(days_to_ship_f(ship_date, order_date)) AS Days
       FROM vehdb_ord_cust_v
GROUP BY quarter_number
ORDER BY quarter_number;

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------
