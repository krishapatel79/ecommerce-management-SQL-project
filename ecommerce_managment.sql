CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- 2. Categories Table
CREATE TABLE Categories ( category_id INT PRIMARY KEY , category_name VARCHAR(100) );
INSERT INTO Categories (category_id, category_name) VALUES 
(1, 'Electronics'), 
(2, 'Clothing'), 
(3, 'Home & Kitchen'),
(4, 'Books'),
(5, 'Sports');

-- 1. Products Table (Created after Categories due to FK)
CREATE TABLE Products (product_id INT PRIMARY KEY, name VARCHAR(150) , category_id INT, price DECIMAL(10, 2),
stock_quantity INT,added_date DATE,
FOREIGN KEY (category_id) REFERENCES Categories(category_id));
INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date) VALUES 
(101, 'Smartphone', 1, 15000.00, 50, '2023-01-10'),
(102, 'Laptop', 1, 55000.00, 20, '2023-02-15'),
(103, 'T-Shirt', 2, 800.00, 100, '2023-03-01'),
(104, 'Jeans', 2, 2500.00, 60, '2023-03-05'),
(105, 'Blender', 3, 3000.00, 30, '2024-01-20');

-- 3. Customers Table
CREATE TABLE Customers (customer_id INT PRIMARY KEY,name VARCHAR(100), email VARCHAR(100),phone_number VARCHAR(20),
address TEXT, registration_date DATE);
INSERT INTO Customers (customer_id, name, email, phone_number, address, registration_date) VALUES 
(201, 'Rahul Sharma', 'rahul@example.com', '9876543210', 'Delhi, India', '2021-06-15'),
(202, 'Priya Verma', 'priya@example.com', '9876543211', 'Mumbai, India', '2023-01-10'),
(203, 'Amit Singh', NULL, '9876543212', 'Bangalore, India', '2024-02-20'),
(204, 'Sneha Gupta', 'sneha@example.com', '9876543213', 'Pune, India', '2022-11-05'),
(205, 'John Doe', 'john@test.com', '9876543214', 'Goa, India', '2024-01-01');

-- 4. Orders Table
CREATE TABLE Orders (order_id INT PRIMARY KEY ,customer_id INT,order_date DATE,total_amount DECIMAL(10, 2),status VARCHAR(20),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES 
(301, 201, '2024-10-01', 15000.00, 'Delivered'),
(302, 201, '2024-10-15', 3000.00, 'Pending'),
(303, 202, '2024-09-01', 55000.00, 'Shipped'),
(304, 202, '2024-11-01', 2500.00, 'Delivered'),
(305, 204, '2023-01-01', 800.00, 'Cancelled');

-- 5. Order_Items Table
CREATE TABLE Order_Items (order_item_id INT PRIMARY KEY ,order_id INT,product_id INT,quantity INT,subtotal DECIMAL(10, 2),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id));
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES 
(401, 301, 101, 1, 15000.00),
(402, 302, 105, 1, 3000.00),
(403, 303, 102, 1, 55000.00),
(404, 304, 104, 1, 2500.00),
(405, 305, 101, 1, 15000.00);

-- 6. Payments Table
CREATE TABLE Payments (payment_id INT PRIMARY KEY AUTO_INCREMENT,order_id INT,payment_date DATE,payment_method VARCHAR(50),
payment_status VARCHAR(20),
FOREIGN KEY (order_id) REFERENCES Orders(order_id));
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status) VALUES 
(501, 301, '2024-10-01', 'UPI', 'Paid'),
(502, 302, '2024-10-15', 'COD', 'Pending'),
(503, 303, '2024-09-01', 'Credit Card', 'Paid'),
(504, 304, '2024-11-10', 'PayPal', 'Paid'),
(505, 305, '2024-11-01', 'UPI', 'Paid');

-- 7. Shipping Table
CREATE TABLE Shipping (shipping_id INT PRIMARY KEY ,order_id INT,shipping_date DATE,delivery_date DATE,shipping_status VARCHAR(20),
FOREIGN KEY (order_id) REFERENCES Orders(order_id));
INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_status) VALUES 
(601, 301, '2024-10-02', '2024-10-05', 'Delivered'),
(602, 302, '2024-09-02', NULL, 'In Transit'),
(603, 303, '2024-11-02', '2024-11-05', 'Delivered'),
(604, 304, '2024-08-21', '2024-08-24', 'Delivered'),
(605, 305, '2024-05-06', '2024-05-08', 'Delivered');

-- 1. Implement CRUD Operations
-- A. Insert new product (Manual ID 108)
INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date) 
VALUES (106, 'Gaming Mouse', 1, 1200.00, 45, CURDATE());

-- B. Update stock when an order is placed
UPDATE Products 
SET stock_quantity = stock_quantity - 1 
WHERE product_id = 101;

-- C. Delete orders that were cancelled more than 30 days ago
DELETE FROM Orders 
WHERE status = 'Cancelled' 
AND order_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 2. Use SQL Clauses (WHERE, HAVING, LIMIT)
-- A. Find all orders placed in the last 6 months
SELECT * FROM Orders 
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- B. Get the top 5 highest-priced products
SELECT * FROM Products ORDER BY price DESC 
LIMIT 5;

-- C. Find customers who have placed more than 3 orders
SELECT customer_id, COUNT(order_id) as order_count 
FROM Orders 
GROUP BY customer_id 
HAVING COUNT(order_id) > 3;

-- 3. Apply SQL Operators (AND, OR, NOT)
-- A. Get all orders where status = 'Pending' AND payment_status = 'Paid'
SELECT o.order_id, o.status, p.payment_status 
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
WHERE o.status = 'Pending' AND p.payment_status = 'Paid';

-- B. Find all products that are NOT out of stock
SELECT * FROM Products 
WHERE NOT stock_quantity = 0;

-- C. Retrieve customers who registered after 2022 OR have made purchases above 10,000
SELECT DISTINCT c.name, c.registration_date 
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(c.registration_date) > 2022 OR o.total_amount > 10000;

-- 4. Sorting & Grouping Data
-- A. List all products sorted by price in descending order
SELECT * FROM Products ORDER BY price DESC;

-- B. Display the number of orders placed by each customer
SELECT customer_id, COUNT(order_id) as total_orders 
FROM Orders 
GROUP BY customer_id;

-- C. Show total revenue generated per category
SELECT c.category_name, SUM(oi.subtotal) as total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

-- 5. Use Aggregate Functions
-- A. Find the total revenue generated by the store
SELECT SUM(total_amount) as store_revenue FROM Orders;

-- B. Identify the most purchased product
SELECT p.name, SUM(oi.quantity) as total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

-- C. Calculate the average order value
SELECT AVG(total_amount) as average_order_value FROM Orders;

-- 7. Implement Joins
-- A. Retrieve products with category names using INNER JOIN
SELECT p.name, c.category_name 
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id;

-- B. Get all orders with customer details using LEFT JOIN
SELECT o.order_id, c.name, c.email 
FROM Orders o
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

-- C. Find orders that haven't been shipped using RIGHT JOIN (Checking NULL in Shipping table)
SELECT o.order_id, s.shipping_status 
FROM Shipping s
RIGHT JOIN Orders o ON s.order_id = o.order_id
WHERE s.shipping_id IS NULL;

-- D. Show customers who have never placed an order (Simulated FULL OUTER JOIN using LEFT JOIN)
SELECT c.name 
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 8. Use Subqueries
-- A. Find orders placed by customers who registered after 2022
SELECT * FROM Orders 
WHERE customer_id IN (SELECT customer_id FROM Customers WHERE YEAR(registration_date) > 2022);

-- B. Identify the customer who has spent the most
SELECT name FROM Customers 
WHERE customer_id = (
    SELECT customer_id FROM Orders 
    GROUP BY customer_id 
    ORDER BY SUM(total_amount) DESC 
    LIMIT 1
);

-- C. Get products that have never been ordered
SELECT name FROM Products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Order_Items);

-- 9. Implement Date & Time Functions
-- A. Extract month from order_date to count orders per month
SELECT MONTH(order_date) as order_month, COUNT(*) as count 
FROM Orders 
GROUP BY MONTH(order_date);

-- B. Calculate delivery time (difference between shipping_date and delivery_date)
SELECT order_id, DATEDIFF(delivery_date, shipping_date) as days_to_deliver 
FROM Shipping 
WHERE delivery_date IS NOT NULL;

-- C. Format order_date as DD-MM-YYYY
SELECT order_id, DATE_FORMAT(order_date, '%d-%m-%Y') as formatted_date 
FROM Orders;

-- 10. Use String Manipulation Functions
-- A. Convert all product names to uppercase
SELECT UPPER(name) FROM Products;

-- B. Trim whitespace from customer names
SELECT TRIM(name) FROM Customers;

-- C. Replace missing email values with "Not Provided"
SELECT name, COALESCE(email, 'Not Provided') as email_status 
FROM Customers;

-- 11. Implement Window Functions
-- A. Rank customers based on total spending
SELECT customer_id, SUM(total_amount) as total_spent,
RANK() OVER (ORDER BY SUM(total_amount) DESC) as spending_rank
FROM Orders
GROUP BY customer_id;

-- B. Show the cumulative total revenue per month
SELECT order_date, total_amount,
SUM(total_amount) OVER (ORDER BY order_date) as running_revenue
FROM Orders;

-- C. Display the running total of orders placed
SELECT order_id, order_date,
COUNT(order_id) OVER (ORDER BY order_date) as running_order_count
FROM Orders;

-- 12. Apply SQL CASE Expressions
-- A. Assign Loyalty_Status to customers
SELECT c.name, SUM(o.total_amount) as total_spent,
CASE 
    WHEN SUM(o.total_amount) > 50000 THEN 'Gold'
    WHEN SUM(o.total_amount) BETWEEN 20000 AND 50000 THEN 'Silver'
    ELSE 'Bronze'
END as Loyalty_Status
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- B. Categorize products (Best Seller, Popular, Regular)
SELECT p.name, COALESCE(SUM(oi.quantity), 0) as total_sold,
CASE 
    WHEN SUM(oi.quantity) > 500 THEN 'Best Seller'
    WHEN SUM(oi.quantity) BETWEEN 200 AND 500 THEN 'Popular'
    ELSE 'Regular'
END as Sales_Category
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id;

