# E-Commerce Database SQL Project 🛒

## 📖 Introduction
This project is a comprehensive SQL script designed to simulate the backend database of a fully functional **E-Commerce platform**. It demonstrates the complete lifecycle of database management, from designing the schema and normalizing relationships to performing advanced data analytics.

The project establishes a relational database (`ECommerceDB`) capable of managing inventory, processing customer orders, tracking shipments, and handling payments. It serves as an excellent reference for understanding how real-world data is structured and queried.

---

## 🚀 Topics Covered
This project covers a wide range of SQL concepts, progressing from beginner to advanced levels:

### 1. Database Design (DDL)
* **Schema Creation:** Creating databases and tables.
* **Constraints:** Primary Keys, Foreign Keys, and `ON DELETE CASCADE` for referential integrity.
* **Data Types:** Proper use of `DECIMAL` for currency, `DATE` for timestamps, and `VARCHAR`.

### 2. Data Manipulation (DML)
* **CRUD Operations:** Create (Insert), Read (Select), Update, and Delete data.
* **Data Cleaning:** Handling `NULL` values using `COALESCE`.

### 3. Advanced Querying
* **Joins:** `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN` to combine data across multiple tables.
* **Aggregation:** Using `SUM`, `COUNT`, `AVG` with `GROUP BY` and `HAVING` clauses.
* **Filtering:** Complex filtering using `WHERE`, `AND`, `OR`, `NOT`, and Date functions (`DATE_SUB`, `DATEDIFF`).

### 4. Analytics & Reporting
* **Window Functions:** Using `RANK()` and `OVER()` for ranking customers and calculating running totals.
* **Subqueries:** Nested queries for finding specific data points (e.g., highest spender).
* **Logic Control:** Using `CASE` statements to categorize customers (Gold/Silver/Bronze) and products.

---

## 📂 Database Schema
The database consists of the following relational tables:

1.  **Categories:** Product classifications (Electronics, Clothing, etc.).
2.  **Products:** Item details, pricing, and stock levels.
3.  **Customers:** User profiles and contact information.
4.  **Orders:** High-level order details (dates, status).
5.  **Order_Items:** Specific items within an order (links Products to Orders).
6.  **Payments:** Payment methods and transaction status.
7.  **Shipping:** Tracking delivery dates and logistics status.

---

## 🛠️ How to Run the Code

### Prerequisites
You need a relational database management system (RDBMS) installed. This script is optimized for **MySQL** or **MariaDB**.
* Recommended Tools: **MySQL Workbench**, **DBeaver**, or **HeidiSQL**.

### Installation Steps
1.  **Download/Copy the Script:**
    Save the SQL code provided in this repository to a file named `ecommerce_db.sql`.

2.  **Open Your SQL Tool:**
    Launch MySQL Workbench (or your preferred tool) and connect to your local server.

3.  **Load the Script:**
    Open the `ecommerce_db.sql` file in the query editor.

4.  **Execute:**
    Click the **Execute** (Lightning bolt icon ⚡) button to run the entire script.
    * *Note:* The script includes `DROP DATABASE IF EXISTS`, so it will automatically reset and recreate the database every time you run it.

5.  **Verify:**
    Refresh your schemas panel. You should see `ECommerceDB`. You can now run individual queries from the bottom section of the script to see the results.

---
