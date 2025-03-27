# 🥡🍜 FOOD HUB 🍛🥤 - Online Food Ordering System

## 🚀 Overview
Welcome to **Food Hub**, a full-stack web application designed for a seamless online food ordering experience! Users can explore restaurants, browse menus, add items to their cart, and securely place orders.

> Built using **JDBC, JSP, Servlets, CSS, JavaScript, Bootstrap, jQuery, and the DAO pattern**.

---

## 🌟 Features

### 🏠 Homepage Navigation
- Browse **restaurants** and **menus** effortlessly.
- Click on a **menu item** to see all restaurants serving that dish.
- Click on a **restaurant** to view its **entire menu**.



### 🔑 Login & Signup
- **User Registration:** Customers and restaurant admins can register.
- **Secure Login:** Password authentication with hashing.
- **Session Management:** Users remain logged in until they log out manually.
- **Role-Based Access:** Customers can order, and restaurant admins can manage menus and orders.



### 🏡 Post-Login Homepage
After login:
- **Customers** see recommended dishes, trending restaurants, and exclusive offers.
- **Restaurant Admins** see order statistics, new orders, and menu management options.



### 🍽️ Menu Selection Flow
#### **Option 1: Select by Dish**
- Click on a dish (e.g., "Pizza") to see **restaurants serving it**.
- Choose a restaurant to see its full menu.

#### **Option 2: Select by Restaurant**
- Click on a **restaurant** to view all its available dishes.



### 🛒 Dynamic Cart Management
- Add or remove items dynamically.
- Real-time cart updates with a footer summary popup.



### 💳 Secure Checkout
- View the order summary before finalizing the order.
- Choose a preferred **payment mode**.



### ✅ Order Confirmation
- Unique **Order ID** generated for each order.
- View ordered items, total amount, and payment details.



### ⚠️ Smart Error Handling
- **Global Exception Handling**: Implemented using Servlet Filters.
- **404 - Page Not Found**: Redirects to a custom error page when a URL is invalid.
- **500 - Internal Server Error**: Displays a friendly error page instead of a raw stack trace.
- **Centralized Error Logging**: Captures errors and forwards them to `error.jsp`.



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
✅ **Security:** Password hashing for authentication  
✅ **Error Handling:** Servlet Filters for exceptions  

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
- **Password Hashing**: Secure user authentication.
- **Unique Order ID Generation**: Ensures security and tracking.

---

## 🚀 Future Enhancements
- 🔹 **Restaurant Owner Verification**
- 🔹 **Payment Gateway Integration**
- 🔹 **User Reviews & Ratings**
- 🔹 **Enhanced UI with animations**

---

## 👨‍💻 Author
📌 **Donthi Geethika Bhargavi**  

---
