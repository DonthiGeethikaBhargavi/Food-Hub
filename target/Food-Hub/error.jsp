<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex, nofollow">
    <title>Oops! Something Went Wrong - Food Hub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <!-- <link rel="stylesheet" href="error.css"> -->
    <style >
         /* Error Page Styling */
 * {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* 🍲 Full-Screen Premium Food Background */
        body {
            background: url('https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg') no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            position: relative;
        }

        /* 🍽️ Dark Overlay for Better Visibility */
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
        }

        /* ✨ Clean & Elegant Error Box */
        .error-container {
            position: relative;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 90%;
            animation: fadeIn 1s ease-in-out;
            z-index: 10;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* 🍜 Animated Bowl of Food Icon */
        .error-icon {
            width: 100px;
            height: 100px;
            background: url('https://cdn-icons-png.flaticon.com/512/2276/2276931.png') no-repeat center center/cover;
            margin: auto;
            display: block;
            animation: bounce 1.5s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* 🍷 Classy Title */
        .error-title {
            font-size: 38px;
            font-family: 'Pacifico', cursive;
            color: #ffcc00;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        }

        /* 📜 Error Message */
        .error-message {
            font-size: 18px;
            color: #ffffff;
            margin-top: 10px;
        }

        /* 🔥 Buttons */
        .btn-custom {
            margin-top: 20px;
            padding: 12px 30px;
            font-size: 18px;
            border-radius: 30px;
            text-decoration: none;
            background: linear-gradient(45deg, #ff3300, #cc0000);
            color: white;
            font-weight: bold;
            transition: 0.3s;
            display: inline-block;
            border: none;
        }

        .btn-custom:hover {
            background: linear-gradient(45deg, #ffcc00, #ff6600);
            box-shadow: 0px 0px 10px rgba(255, 204, 0, 0.8);
        }

        /* ✨ Smooth Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        /* 📱 Responsive Design */
        @media (max-width: 768px) {
            .error-container {
                width: 90%;
                padding: 30px;
            }
            .error-title {
                font-size: 30px;
            }
            .error-icon {
                width: 90px;
                height: 90px;
            }
        }
    </style>
    
</head>
<body>

    <!-- Dark Overlay -->
    <div class="overlay"></div>

    <!-- Error Content -->
    <div class="error-container">
        <!-- 🍜 Animated Food Bowl Icon -->
        <div class="error-icon"></div>

        <h1 class="error-title">Oops! Something Went Wrong</h1>

        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage == null) {
                errorMessage = "An unexpected error occurred while processing your request.";
            }
        %>
        <p class="error-message">
            <strong><%= errorMessage %></strong>
        </p>

        <% 
            Throwable errorException = (Throwable) request.getAttribute("exception");
            if (errorException != null) { 
        %>
            <p class="error-message"><strong>Error Details: <%= errorException.getMessage() %></strong></p>
        <% } %>

        <!-- Navigation Buttons -->
        <a href="javascript:history.back()" class="btn-custom" aria-label="Go Back">
            <i class="fas fa-arrow-left"></i> Go Back
        </a>
        <a href="Home" class="btn-custom" aria-label="Return to Homepage">
            <i class="fas fa-home"></i> Back to Home
        </a>
    </div>

</body>
</html>
