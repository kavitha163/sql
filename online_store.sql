-- =========================================
-- ONLINE STORE - MINI E-COMMERCE SQL PROJECT
-- =========================================


-- =========================================
-- 1. TABLES
-- =========================================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(255),
    registration_date DATE
);


CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT,
    category_id INT,
    added_date DATE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- =========================================
-- 2. INSERT DATA
-- =========================================

INSERT INTO Customers
(customer_id, name, email, phone, city, registration_date)
VALUES
(1, 'Rahul', 'rahul@gmail.com', '9876543210', 'Hyderabad', '2024-01-10'),
(2, 'Priya', 'priya@gmail.com', '9876543211', 'Vijayawada', '2024-02-15'),
(3, 'Arjun', 'arjun@gmail.com', '9876543212', 'Hyderabad', '2024-03-20'),
(4, 'Sneha', 'sneha@gmail.com', '9876543213', 'Guntur', '2024-04-12'),
(5, 'Kiran', 'kiran@gmail.com', '9876543214', 'Hyderabad', '2024-05-18'),
(6, 'Anjali', 'anjali@gmail.com', '9876543215', 'Chennai', '2024-06-22');


INSERT INTO Categories
(category_id, category_name, description)
VALUES
(1, 'Electronics', 'Electronic devices'),
(2, 'Clothing', 'Men and women clothing'),
(3, 'Books', 'Educational books'),
(4, 'Home Appliances', 'Home useful appliances');


INSERT INTO Products
(product_id, product_name, price, stock_quantity, category_id, added_date)
VALUES
(101, 'Laptop', 55000.00, 10, 1, '2024-01-15'),
(102, 'Mobile Phone', 25000.00, 20, 1, '2024-02-10'),
(103, 'Headphones', 1500.00, 30, 1, '2024-03-12'),
(104, 'T-Shirt', 800.00, 50, 2, '2023-12-10'),
(105, 'Jeans', 1800.00, 25, 2, '2024-04-20'),
(106, 'Python Book', 1200.00, 15, 3, '2024-05-05'),
(107, 'SQL Book', 900.00, 20, 3, '2024-06-15'),
(108, 'Mixer Grinder', 3500.00, 12, 4, '2024-07-10');


INSERT INTO Orders
(order_id, customer_id, order_date, total_amount, status)
VALUES
(1001, 1, '2024-07-01', 55000.00, 'Completed'),
(1002, 2, '2024-07-05', 25000.00, 'Completed'),
(1003, 1, '2024-07-10', 3900.00, 'Completed'),
(1004, 3, '2024-08-01', 1800.00, 'Completed'),
(1005, 4, '2024-08-10', 3500.00, 'Cancelled'),
(1006, 5, '2024-08-15', 26200.00, 'Completed');


INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, price, subtotal)
VALUES
(1, 1001, 101, 1, 55000.00, 55000.00),
(2, 1002, 102, 1, 25000.00, 25000.00),
(3, 1003, 103, 2, 1500.00, 3000.00),
(4, 1003, 107, 1, 900.00, 900.00),
(5, 1004, 105, 1, 1800.00, 1800.00),
(6, 1005, 108, 1, 3500.00, 3500.00),
(7, 1006, 102, 1, 25000.00, 25000.00),
(8, 1006, 106, 1, 1200.00, 1200.00);


-- =========================================
-- 3. BASIC QUERIES
-- =========================================

-- Products with price greater than 1000

SELECT *
FROM Products
WHERE price > 1000;


-- Customers from Hyderabad

SELECT *
FROM Customers
WHERE city = 'Hyderabad';


-- Products belonging to Electronics category

SELECT p.product_name,
       p.price,
       c.category_name
FROM Products p
JOIN Categories c
ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics';


-- =========================================
-- 4. JOINS
-- =========================================

-- Customer name with their orders

SELECT c.name,
       o.order_id,
       o.order_date,
       o.total_amount,
       o.status
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id;


-- Product name with order quantity

SELECT p.product_name,
       oi.quantity
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id;


-- Order details with customer information

SELECT o.order_id,
       o.order_date,
       o.total_amount,
       o.status,
       c.name,
       c.email,
       c.phone,
       c.city
FROM Orders o
JOIN Customers c
ON o.customer_id = c.customer_id;


-- Products with category name

SELECT p.product_name,
       p.price,
       p.stock_quantity,
       c.category_name
FROM Products p
JOIN Categories c
ON p.category_id = c.category_id;


-- Customers with products they purchased

SELECT c.name,
       p.product_name,
       oi.quantity,
       oi.price,
       oi.subtotal
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Items oi
ON o.order_id = oi.order_id
JOIN Products p
ON oi.product_id = p.product_id;


-- =========================================
-- 5. AGGREGATE FUNCTIONS
-- =========================================

-- Count total number of products

SELECT COUNT(*) AS total_products
FROM Products;


-- Find average product price

SELECT AVG(price) AS average_price
FROM Products;


-- Calculate total sales amount

SELECT SUM(total_amount) AS total_sales
FROM Orders;
--- Count total orders placed
SELECT COUNT(*) AS total_orders FROM Orders;
--- Find highest priced product
SELECT MAX(price) AS highest_price FROM Products;
-- 1. Find customers who never placed orders
SELECT *
FROM Customers
WHERE customer_id NOT IN
(
  SELECT customer_id
  FROM Orders
);

-- 2. Find products never ordered
SELECT *
FROM Products
WHERE product_id NOT IN
(
  SELECT product_id
  FROM Order_Items
);

-- 3. Show products with price greater than average price
SELECT *
FROM Products
WHERE price >
(
  SELECT AVG(price)
  FROM Products
);

-- 4. Find customers who spent more than average spending
SELECT c.customer_id,
       c.name,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) >
(
  SELECT AVG(total_amount)
  FROM Orders
);

-- 5. Show orders above average total amount
SELECT *
FROM Orders
WHERE total_amount >
(
  SELECT AVG(total_amount)
  FROM Orders
);
-- 1. Update product price
UPDATE Products
SET price = 60000
WHERE product_id = 101;

-- 2. Change customer email
UPDATE Customers
SET email = 'rahul_new@gmail.com'
WHERE customer_id = 1;

-- 3. Update product category
UPDATE Products
SET category_id = 3
WHERE product_id = 106;

-- 4. Delete cancelled orders (first delete from Order_Items)
DELETE FROM Order_Items
WHERE order_id IN
(
  SELECT order_id
  FROM Orders
  WHERE status = 'Cancelled'
);

-- 5. Delete cancelled orders from Orders table
DELETE FROM Orders
WHERE status = 'Cancelled';

-- 6. Delete customers with no orders
DELETE FROM Customers
WHERE customer_id NOT IN
(
  SELECT customer_id
  FROM Orders
);
-- 1. Create a view to display customer orders
CREATE VIEW customer_orders AS
SELECT c.customer_id,
       c.name,
       o.order_id,
       o.order_date,
       o.total_amount,
       o.status
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id;

-- 2. Create a view for product details with category
CREATE VIEW product_category AS
SELECT p.product_id,
       p.product_name,
       p.price,
       p.stock_quantity,
       c.category_name
FROM Products p
JOIN Categories c
ON p.category_id = c.category_id;

-- 3. Create a view showing order item details
CREATE VIEW order_item_details AS
SELECT oi.order_item_id,
       oi.order_id,
       p.product_name,
       oi.quantity,
       oi.price,
       oi.subtotal
FROM Order_Items oi
JOIN Products p
ON oi.product_id = p.product_id;

-- 4. Create a view to display total spending by each customer
CREATE VIEW customer_spending AS
SELECT c.customer_id,
       c.name,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 5. Create a view showing best-selling products
CREATE VIEW best_selling_products AS
SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;
---Stored Procedures---
1. mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE add_customer(
    ->     IN p_customer_id INT,
    ->     IN p_name VARCHAR(100),
    ->     IN p_email VARCHAR(100),
    ->     IN p_phone VARCHAR(15),
    ->     IN p_city VARCHAR(255),
    ->     IN p_registration_date DATE
    -> )
    -> BEGIN
    ->   INSERT INTO Customers
    ->   (customer_id, name, email, phone, city, registration_date)
    ->   VALUES
    ->   (p_customer_id, p_name, p_email, p_phone, p_city, p_registration_date);
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL add_customer(
    -> 7,
    -> 'Ravi',
    -> 'ravi@gmail.com',
    -> '9876543216',
    -> 'Hyderabad',
    -> '2024-09-01'
    -> );
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Customers;

2. mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE update_product_price(
    ->     IN p_product_id INT,
    ->     IN p_new_price DECIMAL(10,2)
    -> )
    -> BEGIN
    ->   UPDATE Products
    ->   SET price = p_new_price
    ->   WHERE product_id = p_product_id;
    -> END //
ERROR 1304 (42000): PROCEDURE update_product_price already exists
mysql>
mysql> DELIMITER ;
mysql> CALL update_product_price(101, 60000);
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT *
    -> FROM Products
    -> WHERE product_id = 101;

3.  mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE customer_orders(
    ->     IN p_customer_id INT
    -> )
    -> BEGIN
    ->   SELECT *
    ->   FROM Orders
    ->   WHERE customer_id = p_customer_id;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL customer_orders(1);

mysql> SELECT *
    -> FROM Orders
    -> WHERE customer_id = 1;

4. mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE total_sales()
    -> BEGIN
    ->   SELECT SUM(total_amount) AS total_sales
    ->   FROM Orders;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL total_sales();
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL total_sales();

5.  mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE products_by_category(
    ->     IN p_category_id INT
    -> )
    -> BEGIN
    ->   SELECT *
    ->   FROM Products
    ->   WHERE category_id = p_category_id;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL products_by_category(1);

-- 1. Top 5 best selling products
SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 2. Most frequent customers
SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;

-- 3. Monthly sales report
SELECT YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       SUM(total_amount) AS total_sales
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 4. Category generating highest revenue
SELECT c.category_id,
       c.category_name,
       SUM(oi.subtotal) AS total_revenue
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 5. Customer spending analysis
SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;


