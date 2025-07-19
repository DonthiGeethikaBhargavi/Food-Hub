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


### 👤 Customer Features
✅ **User Authentication** (Login & Signup) 🔑  
✅ **Browse Restaurants & Menus** 🍽️  
✅ **Add to Cart & Dynamic Cart Summary** 🛒  
✅ **Order Placement & History** 📦  
✅ **Secure Payment Modes** 💳  
✅ **Responsive UI & Interactive Design** 📱  

### 🧑‍🍳 Restaurant Owner Features
✅ **Owner Dashboard**  
✅ **Add / Edit / Delete Menu Items**  
✅ **View Restaurant Orders**  
✅ **Update Menu Availability**  

### 🛡️ Admin Features
✅ **Admin Login & Session Management**  
✅ **Admin Dashboard for Platform Monitoring**  
✅ **Manage Restaurant Admins (Add/Edit/Delete)**  
✅ **Deactivate Restaurants / Remove Orders** 


### ⚠️ Smart Error Handling
1️⃣ **Global Exception Handling (`GlobalExceptionFilter.java`)**  
   - Captures all unhandled exceptions.  
   - Redirects users to a **user-friendly error page** (`error.jsp`).  
   - Handles **404 (Not Found)** & **500 (Internal Server Error)** automatically.  

2️⃣ **Custom Error Handler (`CustomErrorHandler.java`)**  
   - Extracts & displays detailed error messages.  
   - Forwards errors to a **styled error page**.  
   - Ensures **consistent error responses** across the application.  


## 🗺️ Navigation Flow

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

---

## 📊 Entity-Relationship (ER) Diagram

The following diagram illustrates the relationship between all the tables in the **Food Hub** database:

![ER Diagram]<img width="1420" height="1577" alt="Screenshot 2025-07-16 113558" src="https://github.com/user-attachments/assets/b552c382-c5f5-4ea3-b0a1-88f1d7450dcb" />


---

## 🗄️ Database Schema
The application is powered by **MySQL**. Below is the **schema structure**:

### 📌 Tables
#### **1️⃣ `User`** (Stores user details)
```sql
CREATE TABLE User (
    UserId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Address TEXT,
    Role ENUM('Customer', 'RestaurantAdmin', 'SystemAdmin') NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLoginDate TIMESTAMP NULL
);
```

#### **2️⃣ `Restaurant`** (Stores restaurant information)
```sql
CREATE TABLE Restaurant (
    RestaurantId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Address TEXT NOT NULL,
    Rating DECIMAL(3,2) DEFAULT 0.00,
    CuisineType VARCHAR(100),
    IsActive TINYINT(1) DEFAULT 1,
    EstimatedDeliveryTime INT NOT NULL DEFAULT 30,
    AdminUserId INT UNIQUE,
    ImagePath VARCHAR(255)
);

```

#### **4️⃣ `Menu`** (Stores restaurant menus)
```sql
CREATE TABLE Menu (
    MenuId INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantId INT NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Ratings DECIMAL(3,2) DEFAULT 0.00,
    IsAvailable BOOLEAN DEFAULT TRUE,
    ImagePath VARCHAR(255),
    UNIQUE (RestaurantId, ItemName),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);
```

#### **3️⃣ `OrderTable`** (Stores order details)
```sql
CREATE TABLE OrderTable (
    OrderId VARCHAR(20) PRIMARY KEY,
    UserId INT NOT NULL,
    RestaurantId INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status ENUM('Pending', 'Delivered', 'Cancelled', 'In Progress') NOT NULL DEFAULT 'Pending',
    PaymentMode ENUM('UPI', 'Cash', 'Debit Card', 'Credit Card') NOT NULL,
    FOREIGN KEY (UserId) REFERENCES User(UserId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);

```

#### **4️⃣ `OrderItem`** (Stores OrderItem)
```sql
CREATE TABLE OrderItem (
    OrderItemId INT PRIMARY KEY AUTO_INCREMENT,
    OrderId VARCHAR(20) NOT NULL,
    MenuId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    TotalPrice DECIMAL(10,2) NOT NULL,
    UNIQUE (OrderId, MenuId),
    FOREIGN KEY (OrderId) REFERENCES OrderTable(OrderId),
    FOREIGN KEY (MenuId) REFERENCES Menu(MenuId)
);
```

#### **4️⃣ `OrderHistory`** (Stores OrderHistory)
```sql
CREATE TABLE OrderHistory (
    OrderHistoryID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderID VARCHAR(20),
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2),
    Status ENUM('Delivered', 'Cancelled', 'Returned') NOT NULL,
    RestaurantID INT,
    RestaurantName VARCHAR(20),
    MenuItems TEXT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantId)
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
- 🔹 **Real Payment Gateway Integration:** Integrate with a service like Stripe or Razorpay for actual transaction processing.
- 🔹 **User Reviews & Ratings:** Allow users to rate and review restaurants and menu items.
- 🔹 **Live Order Tracking:** A map-based interface to track the delivery agent's location in real-time. 🚴
- 🔹 **Coupon & Discount System:** Implement functionality for applying promotional codes at checkout.
- 🔹 **Enhanced UI/UX:** Introduce modern animations, micro-interactions, and a more dynamic user interface.

---

## 👨‍💻 Author
📌 **Donthi Geethika Bhargavi**  

---
