create database fintech_fraud;
use fintech_fraud;
create table customers (
customer_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
city VARCHAR(50),
country VARCHAR(50),
signup_date date
);
create table transactions (
transactions_id INT PRIMARY KEY,
customer_id INT,
transaction_date DATETIME,
amount DECIMAL(10,2),
merchant VARCHAR(100),
transaction_type VARCHAR(30),
city VARCHAR(50),
status VARCHAR(20)
);
describe customers;
describe transactions;
INSERT INTO customers (customer_id, name, city, country, signup_date) VALUES
(101,'Aarav Mehta','Mumbai','India','2022-01-15'),
(102,'Ananya Sharma','Delhi','India','2021-09-10'),
(103,'Rohan Verma','Bengaluru','India','2023-03-12'),
(104,'Priya Singh','Pune','India','2020-11-25'),
(105,'Kunal Kapoor','Hyderabad','India','2022-06-18'),
(106,'Neha Gupta','Kolkata','India','2021-04-05'),
(107,'Aditya Jain','Jaipur','India','2023-01-20'),
(108,'Sneha Iyer','Chennai','India','2022-10-30'),
(109,'Farhan Ali','Lucknow','India','2020-08-14'),
(110,'Meera Nair','Trivandrum','India','2021-12-09'),
(111,'Rahul Khanna','Noida','India','2022-08-11'),
(112,'Pooja Malhotra','Gurugram','India','2021-02-19'),
(113,'Siddharth Roy','Kolkata','India','2020-05-27'),
(114,'Ishita Sen','Bhopal','India','2023-06-03'),
(115,'Mohit Bansal','Indore','India','2022-12-01'),
(116,'Aditi Rao','Visakhapatnam','India','2021-07-14'),
(117,'Nikhil Arora','Chandigarh','India','2020-10-22'),
(118,'Kavya Nair','Kochi','India','2023-01-08'),
(119,'Imran Sheikh','Ahmedabad','India','2021-09-30'),
(120,'Ritika Joshi','Dehradun','India','2022-04-16');

INSERT INTO transactions
(transactions_id, customer_id, transaction_date, amount, merchant, transaction_type, city, status)
VALUES
-- Customer 101
(1001,101,'2024-03-01 10:15:00',1200,'Amazon','Card','Mumbai','SUCCESS'),
(1002,101,'2024-03-01 10:17:00',1250,'Amazon','Card','Mumbai','SUCCESS'),
(1003,101,'2024-03-01 10:18:30',1300,'Flipkart','Card','Mumbai','SUCCESS'),

-- Customer 102 
(1004,102,'2024-03-05 14:22:00',500,'Swiggy','UPI','Delhi','SUCCESS'),
(1005,102,'2024-03-05 14:24:00',450,'Zomato','UPI','Delhi','SUCCESS'),

-- Customer 103 (high-value anomaly)
(1006,103,'2024-03-10 09:10:00',1500,'IRCTC','NetBanking','Bengaluru','SUCCESS'),
(1007,103,'2024-03-10 09:12:00',90000,'Apple Store','Card','Bengaluru','SUCCESS'),

-- Customer 104 (failed attempts)
(1008,104,'2024-03-15 21:30:00',300,'Uber','UPI','Pune','FAILED'),
(1009,104,'2024-03-15 21:31:00',300,'Uber','UPI','Pune','FAILED'),
(1010,104,'2024-03-15 21:32:00',300,'Uber','UPI','Pune','SUCCESS'),

-- Customer 105 
(1011,105,'2024-03-18 11:00:00',2500,'Ajio','Card','Hyderabad','SUCCESS'),
(1012,105,'2024-03-18 11:05:00',2600,'Myntra','Card','Hyderabad','SUCCESS'),

-- Customer 106 
(1013,106,'2024-03-20 16:40:00',1000,'BigBasket','UPI','Kolkata','SUCCESS'),
(1014,106,'2024-03-20 16:45:00',85000,'BestBuy','Card','Delhi','SUCCESS'),

-- Customer 107 
(1015,107,'2024-03-22 08:10:00',400,'OLA','UPI','Jaipur','SUCCESS'),
(1016,107,'2024-03-22 08:12:00',420,'OLA','UPI','Jaipur','SUCCESS'),
(1017,107,'2024-03-22 08:14:00',450,'OLA','UPI','Jaipur','SUCCESS'),

-- Customer 108 
(1018,108,'2024-03-25 19:20:00',600,'Netflix','Card','Chennai','SUCCESS'),
(1019,108,'2024-03-25 19:22:00',650,'Amazon','Card','Chennai','SUCCESS'),

-- Customer 109 
(1020,109,'2024-03-28 23:10:00',2000,'Flipkart','Card','Lucknow','FAILED'),
(1021,109,'2024-03-28 23:12:00',2000,'Flipkart','Card','Lucknow','FAILED'),
(1022,109,'2024-03-28 23:15:00',2000,'Flipkart','Card','Lucknow','FAILED'),
(1023,109,'2024-03-28 23:17:00',2000,'Flipkart','Card','Lucknow','SUCCESS'),

-- Customer 110 
(1024,110,'2024-03-30 07:45:00',1800,'MakeMyTrip','NetBanking','Trivandrum','SUCCESS'),
(1025,110,'2024-03-30 09:00:00',72000,'Expedia','Card','Mumbai','SUCCESS'),

-- Customer 111–120 
(1026,111,'2024-04-01 11:00:00',150,'Paytm','UPI','Noida','SUCCESS'),
(1027,112,'2024-04-03 19:25:00',120000,'Louis Vuitton','Card','Gurugram','SUCCESS'),
(1028,113,'2024-04-05 09:10:00',980,'Amazon','Card','Delhi','SUCCESS'),
(1029,114,'2024-04-06 22:05:00',5000,'Croma','Card','Bhopal','SUCCESS'),
(1030,115,'2024-04-08 13:15:00',2200,'Flipkart','Card','Indore','SUCCESS'),
(1031,116,'2024-04-11 10:00:00',95000,'Samsung Store','Card','Mumbai','SUCCESS'),
(1032,117,'2024-04-12 01:18:00',2500,'Uber','Card','Chandigarh','SUCCESS'),
(1033,118,'2024-04-14 18:21:00',499,'Netflix','Card','Kochi','SUCCESS'),
(1034,119,'2024-04-15 12:13:30',310,'Zomato','UPI','Ahmedabad','SUCCESS'),
(1035,120,'2024-04-18 07:10:00',68000,'Booking.com','Card','Bengaluru','SUCCESS');

select * from customers;
select * from transactions;

-- Calculate Average Spend per Customer
SELECT
    customer_id,
    AVG(amount) AS avg_amount
FROM transactions
WHERE status = 'SUCCESS'
GROUP BY customer_id;
SELECT
    customer_id,
    COUNT(*) AS tx_count
FROM transactions
WHERE status = 'SUCCESS'
GROUP BY customer_id;
SELECT
    transactions_id,
    customer_id,
    amount
FROM transactions
ORDER BY amount DESC;
CREATE VIEW high_value_fraud AS
SELECT
    t.transactions_id,
    t.customer_id,
    t.amount,
    (
        SELECT AVG(t2.amount)
        FROM transactions t2
        WHERE t2.customer_id = t.customer_id
          AND t2.status = 'SUCCESS'
          AND t2.transactions_id <> t.transactions_id
    ) AS historical_avg
FROM transactions t
WHERE t.status = 'SUCCESS'
  AND t.amount >
      2 * (
          SELECT AVG(t2.amount)
          FROM transactions t2
          WHERE t2.customer_id = t.customer_id
            AND t2.status = 'SUCCESS'
            AND t2.transactions_id <> t.transactions_id
      );
-- See Rapid Transactions
CREATE VIEW high_frequency_fraud AS
SELECT
    t1.customer_id,
    COUNT(*) AS rapid_tx_count
FROM transactions t1
JOIN transactions t2
  ON t1.customer_id = t2.customer_id
 AND t2.transaction_date < t1.transaction_date
WHERE TIMESTAMPDIFF(
        MINUTE,
        t2.transaction_date,
        t1.transaction_date
      ) <= 5
GROUP BY t1.customer_id
HAVING COUNT(*) >= 2;
-- GEO-LOCATION FRAUD QUERY
CREATE VIEW geo_location_fraud AS
SELECT DISTINCT
    t1.customer_id,
    t1.city AS current_city,
    t2.city AS previous_city,
    TIMESTAMPDIFF(
        MINUTE,
        t2.transaction_date,
        t1.transaction_date
    ) AS time_diff_minutes
FROM transactions t1
JOIN transactions t2
  ON t1.customer_id = t2.customer_id
 AND t2.transaction_date < t1.transaction_date
WHERE t1.city <> t2.city
  AND TIMESTAMPDIFF(
        MINUTE,
        t2.transaction_date,
        t1.transaction_date
      ) <= 60;
-- FAILED → SUCCESS PATTERN
CREATE VIEW failed_success_fraud AS
SELECT
    customer_id,
    COUNT(CASE WHEN status = 'FAILED' THEN 1 END) AS failed_count,
    COUNT(CASE WHEN status = 'SUCCESS' THEN 1 END) AS success_count
FROM transactions
GROUP BY customer_id
HAVING failed_count >= 2
   AND success_count >= 1;
create view customer_fraud_summary as   
   SELECT
    c.customer_id,
    c.name,

    (
        CASE WHEN hv.customer_id IS NOT NULL THEN 30 ELSE 0 END +
        CASE WHEN hf.customer_id IS NOT NULL THEN 25 ELSE 0 END +
        CASE WHEN geo.customer_id IS NOT NULL THEN 25 ELSE 0 END +
        CASE WHEN fs.customer_id IS NOT NULL THEN 20 ELSE 0 END
    ) AS fraud_risk_score,

    CASE
        WHEN (
            CASE WHEN hv.customer_id IS NOT NULL THEN 30 ELSE 0 END +
            CASE WHEN hf.customer_id IS NOT NULL THEN 25 ELSE 0 END +
            CASE WHEN geo.customer_id IS NOT NULL THEN 25 ELSE 0 END +
            CASE WHEN fs.customer_id IS NOT NULL THEN 20 ELSE 0 END
        ) >= 60 THEN 'HIGH RISK'

        WHEN (
            CASE WHEN hv.customer_id IS NOT NULL THEN 30 ELSE 0 END +
            CASE WHEN hf.customer_id IS NOT NULL THEN 25 ELSE 0 END +
            CASE WHEN geo.customer_id IS NOT NULL THEN 25 ELSE 0 END +
            CASE WHEN fs.customer_id IS NOT NULL THEN 20 ELSE 0 END
        ) >= 30 THEN 'MEDIUM RISK'

        ELSE 'LOW RISK'
    END AS risk_category

FROM customers c
LEFT JOIN high_value_fraud hv      ON c.customer_id = hv.customer_id
LEFT JOIN high_frequency_fraud hf  ON c.customer_id = hf.customer_id
LEFT JOIN geo_location_fraud geo   ON c.customer_id = geo.customer_id
LEFT JOIN failed_success_fraud fs  ON c.customer_id = fs.customer_id;

select * from customer_fraud_summary;


