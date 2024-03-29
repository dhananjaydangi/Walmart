-- CREATING DATABASE
CREATE DATABASE walmart;


-- USE DATABASE
USE walmart;


-- CREATING TABLE
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
    );
    
    
    -- TIME OF DAY
	SELECT time , 
	(CASE
       WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
       WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
       ELSE "Evening"
	END) AS time_of_day FROM sales;
    
    ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
    
    UPDATE sales SET time_of_day = 
	(CASE
        WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END);
    
    
    -- DAY NAME
    SELECT date , DAYNAME(date) AS day_name FROM sales;
    
    ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);
    
    UPDATE sales SET day_name = DAYNAME(date);
    
    
    -- MONTH NAME
    SELECT date , MONTHNAME(date) AS month_name FROM sales;
    
    ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);
    
    UPDATE sales SET month_name = MONTHNAME(date);
    
    
    -- UNIQUE CITIES , BRANCH 
    SELECT DISTINCT(city) FROM sales;
    
    SELECT DISTINCT(branch) FROM sales;
    
    SELECT DISTINCT(city) , branch FROM sales;
    
    
    -- NUM OF UNIQUE PRODUCT LINE
    SELECT DISTINCT(product_line) FROM sales;
    
    SELECT COUNT(DISTINCT(product_line)) FROM sales;
    
    
    -- MOST COMMON PAYMENT METHOD
    ALTER TABLE sales RENAME COLUMN payment to payment_method;
    
    SELECT MAX(payment_method) FROM sales;
    
    SELECT payment_method , COUNT(payment_method) AS num_of_payment FROM sales GROUP BY payment_method ORDER BY num_of_payment DESC;
    
    
    -- MOST SELLING PRODUCT LINE
    SELECT product_line , COUNT(product_line) AS num_of_Sales FROM sales GROUP BY product_line ORDER BY num_of_Sales DESC;
    
    
    -- TOTAL REVENUE BY MONTH
    SELECT month_name AS month , SUM(total) AS revenue FROM sales GROUP BY month_name ORDER BY revenue DESC;
    
    
    -- LARGEST COGS BY MONTH
    SELECT month_name AS month , SUM(cogs) AS cogs FROM sales GROUP BY month_name ORDER BY cogs DESC;
    
    
    -- PRODUCT LINE WITH LARGEST REVENUE
    SELECT product_line , SUM(total) AS revenue FROM sales GROUP BY product_line ORDER BY revenue DESC;
    
    
    -- CITY & BRANCH WITH MAX REVENUE
    SELECT city , branch , SUM(total) AS revenue FROM sales GROUP BY city , branch ORDER BY revenue DESC;
    
    
    -- PRODUCT LINE WITH LARGEST VALUE ADDED TAX
    SELECT product_line , AVG(tax_pct) AS avg_tax FROM sales GROUP BY product_line ORDER BY avg_tax;
    
    
    -- BRANCHES SEELING PRODUCTS MORE THAN AVG
    SELECT branch , SUM(quantity) AS quantity_sold FROM sales GROUP BY branch HAVING SUM(quantity) > AVG(quantity) ORDER BY quantity_sold DESC;
    
    
    -- MOST COMMON PRODUCT LINE BY GENDER
    SELECT product_line , gender , COUNT(gender) AS count_gender FROM sales GROUP BY product_line , gender ORDER BY count_gender;
    
    
    -- AVG RATING OF EACH PRODUCT
    SELECT product_line , ROUND(AVG(rating),2) AS avg_rating FROM sales GROUP BY product_line ORDER BY avg_rating DESC;
    
    
    -- SALES BY TIME PER WEEK
    SELECT time_of_day , day_name , COUNT(*) AS total_sales FROM sales GROUP BY time_of_day , day_name ORDER BY day_name;


    -- REVENUE BY COUSTOMER TYPE
    SELECT customer_type , SUM(total)  AS revenue FROM sales GROUP BY customer_type ORDER BY revenue DESC;
    
    
    -- CITY WITH LARGEST avg tax_pct
    SELECT city , ROUND(AVG(tax_pct) , 2) AS tax FROM sales GROUP BY city ORDER BY tax DESC;
    
    
    -- UNIQUE CUSTOMER TYPE IN DATA SET
    SELECT DISTINCT(customer_type) FROM sales;
    
    
    -- UNIQUE PAYMENT METHODS IN DATA SET
    SELECT DISTINCT(payment_method) FROM sales;
    
    
    -- MOST COMMON CUSTOMER TYPE
    SELECT customer_type , COUNT(customer_type) AS TOTAL FROM sales GROUP BY customer_type ORDER BY TOTAL DESC;
    
    
    -- SALES BY CUSTOMER TYPE
    SELECT customer_type , COUNT(*) AS total_sales FROM sales GROUP BY customer_type ORDER BY total_sales DESC;
    
    
    -- MOST COMMON CUSTOMER GENDER
    SELECT gender , COUNT(*) AS total FROM sales GROUP BY gender ORDER BY total DESC;
    
      
	-- GENDER DISTRIBUTION PER BRANCH
    SELECT branch , gender , COUNT(gender) AS num FROM sales GROUP BY branch , gender ORDER BY branch;
    
    
    -- AVG RATING AS PER TIME OF THE DAY
    SELECT time_of_day , AVG(rating) AS avg_rating FROM sales GROUP BY time_of_day ORDER BY avg_rating DESC;
    
    
    -- AVG RATING AS PER TIME OF THE DAY IN DISTINCT BRANCH
     SELECT branch , time_of_day , ROUND(AVG(rating) , 2 )AS avg_rating FROM sales GROUP BY branch , time_of_day HAVING(AVG(rating) > 7) ORDER BY branch;
     
     
     -- SALES AS PER THE DAY IN DISTINCT BRANCH
     SELECT branch , day_name , SUM(total) AS total FROM sales GROUP BY branch , day_name ORDER BY branch , total DESC ;
     

    
    