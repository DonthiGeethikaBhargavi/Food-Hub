# 🥡🍜 FOOD HUB 🍛🥤 - Online Food Ordering System

## 🚀 Overview
Welcome to **Food Hub**, a full-stack web application designed for a seamless online food ordering experience! Built from the ground up, this project allows users to explore restaurants, browse menus, add items to their cart, and securely place orders.

> Built using **JDBC, JSP, SQL, Servlets, CSS, JavaScript, Bootstrap, jQuery, and the DAO pattern**.

---

## 🌟 Features
✅ **User Authentication** (Login & Signup) 🔑  
✅ **View & Order Food** from various restaurants 🍕  
✅ **Add to Cart & Dynamic Cart Summary** 🛒  
✅ **Order History** 📜    
✅ **Secure Payment Modes** (UPI, Cash, Cards) 💳  
✅ **Responsive UI & Interactive Design** 🎨  
✅ **Custom Error Handling & Global Exception Handling** ⚠️

### 🏠 Homepage Navigation
- Browse **restaurants** and **menus** effortlessly.
- Click on a **menu item** to see all restaurants serving that dish.
- Click on a **restaurant** to view its **entire menu**.



### 🔐 User Authentication (Login & Signup)  
- Users can **sign up** for an account.  
- **Login** allows users to access their personalized dashboard.  
- After logging in, the navbar displays:  
  - 👤 User's Name  
  - 📜 Order History  
  - 🛒 Cart  
  - 🚪 Logout Button  


### 🍽️ Menu Selection Flow
#### **Option 1: Select by Dish**
- Click on a dish (e.g., "Pizza") to see **restaurants serving it**.
- Choose a restaurant to see its full menu.

#### **Option 2: Select by Restaurant**
- Click on a **restaurant** to view all its available dishes.



### 🛒 Dynamic Cart Management
- Add or remove items dynamically.
- Real-time cart updates .



### 💳 Secure Checkout
- View the order summary before finalizing the order.
- Choose a preferred **payment mode**.



### ✅ Order Confirmation
- Unique **Order ID** generated for each order.
- View ordered items, total amount, and payment details.



### ⚠️ Smart Error Handling
1️⃣ **Global Exception Handling (`GlobalExceptionFilter.java`)**  
   - Captures all unhandled exceptions.  
   - Redirects users to a **user-friendly error page** (`error.jsp`).  
   - Handles **404 (Not Found)** & **500 (Internal Server Error)** automatically.  

2️⃣ **Custom Error Handler (`CustomErrorHandler.java`)**  
   - Extracts & displays detailed error messages.  
   - Forwards errors to a **styled error page**.  
   - Ensures **consistent error responses** across the application.  



---

## 🗄️ Database Schema
The application is powered by **MySQL**. Below is the **schema structure**:

### 📌 Tables
#### **1️⃣ `users`** (Stores user details)
```sql
CREATE TABLE users (
    UserId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Address TEXT,
    Role ENUM('Customer', 'RestaurantAdmin', 'SystemAdmin') NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLoginDate TIMESTAMP
);
```

#### **2️⃣ `restaurants`** (Stores restaurant information)
```sql
CREATE TABLE restaurants (
    RestaurantId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT NOT NULL,
    Rating DECIMAL(3,2) DEFAULT 0.00,
    CuisineType VARCHAR(100),
    IsActive TINYINT(1) DEFAULT 1,
    EstimatedDeliveryTime INT NOT NULL DEFAULT 30,
    AdminUserId INT UNIQUE,
    ImagePath VARCHAR(255)
);
```

#### **3️⃣ `orders`** (Stores order details)
```sql
CREATE TABLE orders (
    OrderId VARCHAR(20) PRIMARY KEY,
    UserId INT NOT NULL,
    RestaurantId INT NOT NULL,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status ENUM('Pending', 'Delivered', 'Cancelled', 'In Progress') NOT NULL DEFAULT 'Pending',
    PaymentMode ENUM('UPI', 'Cash', 'Debit Card', 'Credit Card') NOT NULL
);
```

#### **4️⃣ `menu`** (Stores restaurant menus)
```sql
CREATE TABLE menu (
    MenuId INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantId INT NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Ratings DECIMAL(3,2) DEFAULT 0.00,
    IsAvailable TINYINT(1) DEFAULT 1,
    ImagePath VARCHAR(255)
);
```

---

## 🛠️ Technologies Used
✅ **Backend:** Java (JDBC, Servlets, JSP)  
✅ **Frontend:** HTML, CSS, JavaScript, Bootstrap, jQuery  
✅ **Database:** MySQL  
✅ **Web Server:** Apache Tomcat
✅ ** Design Pattern:** Data Access Object (DAO)  

---

## 🏗️ Setup Instructions

### ⚡ Prerequisites
- JDK 8 or higher
- Apache Tomcat Server
- MySQL Database
- IDE (Eclipse, IntelliJ, NetBeans)

### 📥 Steps to Run
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/foodhub.git
   ```
2. Import the project into your IDE.
3. Configure the database:
   ```sql
   CREATE DATABASE foodhub;
   ```
   Import the schema using:
   ```sh
   mysql -u root -p foodhub < database_schema.sql
   ```
4. Update database credentials in `DBConnection.java`.
5. Deploy on **Apache Tomcat**.
6. Open the browser and go to:
   ```
   http://localhost:8080/FoodHub/
   ```

---

## 🔐 Security
- **Password Hashing:** User passwords are not stored in plaintext. We use a strong one-way hashing algorithm (e.g., SHA-256 or BCrypt) to secure credentials against database breaches.
- **SQL Injection Prevention:** All database queries are executed using PreparedStatements, which prevents malicious SQL injection attacks by safely parameterizing user input.
- **Session Management:** Secure user sessions are managed after login to ensure that authenticated routes and user-specific data (like the cart and order history) are protected.
- **Cross-Site Scripting (XSS) Prevention:** User inputs are properly escaped before being rendered on pages to prevent XSS attacks.
- **Unique & Non-Sequential Order IDs:** Generating unique, non-sequential Order IDs helps protect order data from enumeration attacks where a malicious user could guess other valid order IDs.

---

## 🚀 Future Enhancements
- 🔹**Restaurant Owner Dashboard:** A dedicated interface for restaurant owners to manage their menu, view orders, and update restaurant details.
- 🔹 **Real Payment Gateway Integration:** Integrate with a service like Stripe or Razorpay for actual transaction processing.
- 🔹 **User Reviews & Ratings:** Allow users to rate and review restaurants and menu items.
- 🔹 **Live Order Tracking:** A map-based interface to track the delivery agent's location in real-time. 🚴
- 🔹 **Coupon & Discount System:** Implement functionality for applying promotional codes at checkout.
- 🔹 **Enhanced UI/UX:** Introduce modern animations, micro-interactions, and a more dynamic user interface.

---

## 👨‍💻 Author
📌 **Donthi Geethika Bhargavi**  

---
