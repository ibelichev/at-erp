<!DOCTYPE html>
<html>
<head>
    <title>ATERM</title>
    <style>
        body {
            background-color: white;
            color: black;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: black;
            padding: 20px;
        }

        h1 {
            color: red;
            text-align: center;
            margin: 0;
        }

        hr {
            border: none;
            height: 2px;
            background-color: red;
            margin: 20px 0;
        }

        h4 {
            color: black;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            width: 300px;
            margin: 0 auto;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-radius: 4px;
            background-color: #f2f2f2;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #c70000;
        }

        a {
            color: red;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<header>
    <h1>ATERM</h1>
</header>
<hr>
<h4>Авторизация</h4>
<form action="/login" method="post">
    <label for="email">Эл. почта:</label>
    <br>
    <input type="email" id="email" name="username" required>
    <br><br>
    <label for="password">Пароль:</label>
    <br>
    <input type="password" id="password" name="password" required>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
    <br><br>
    <input type="submit" value="Вход">
</form>
<#--<p><a href="/registration">Зарегистрироваться</a></p>-->
</body>
</html>