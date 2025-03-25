package com.food.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
 private static final String URL = "jdbc:mysql://localhost:3306/fooddeliveryapp";
 private static final String USERNAME="root";
 private static final String PASSWORD="root";
  public static Connection getConnection() {
	 Connection connection = null;
	 try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
		 connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	 }
	 catch(ClassNotFoundException e) {
		 e.printStackTrace();
		 
	 } catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	 return connection;
 }
 
}
