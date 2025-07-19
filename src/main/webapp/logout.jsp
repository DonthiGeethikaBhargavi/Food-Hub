<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logout- Food Hub</title>
<link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
</head>
<body>
   <%
    session.invalidate();
    response.sendRedirect("Home");
   %>
   
</body>
</html>