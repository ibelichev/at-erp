<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        h2 {
            color: #4CAF50;
        }
        a.button {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 0;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Hello, ${userName}!</h2>
        <p>Welcome to AT-ERP. Please, visit the following link to confirm your email:</p>
        <a href="http://localhost:9090/activate/${activationLink}" class="button">Activate your account</a>
        <p style="margin-top: 20px;">If you didn't create an account, please ignore this email.</p>
    </div>
</body>
</html>