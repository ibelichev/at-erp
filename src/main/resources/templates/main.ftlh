<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        nav {
            background-color: black;
            padding: 10px;
            text-align: center;
        }

        nav a {
            color: red;
            text-decoration: none;
            margin: 0 10px;
        }

        nav a:hover {
            text-decoration: underline;
        }

        form {
            text-align: center;
            margin-top: 20px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
<header>
    <h1>ATERM</h1>
</header>

<#if role == "[ROLE_ADMIN]">
    <nav>
        <a href="/students">Ученики</a>
        <a href="/subscriptions">Подписки</a>
        <a href="/lessons">Уроки</a>
        <a href="/prepods">Преподаватели</a>
    </nav>
<#else>
    <nav>
        <a href="/client/lessons">Записаться на урок</a>
    </nav>
</#if>

<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Выйти">
</form>
</body>
</html>
