<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students</title>
    <style>
        body {
            background-color: white;
            color: black;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: red;
            text-align: center;
            margin-top: 20px;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="submit"] {
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-radius: 4px;
            width: 100%;
        }

        input[type="submit"] {
            background-color: red;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: darkred;
        }

        .student {
            background-color: #f2f2f2;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        .student a {
            text-decoration: none;
            color: black;
        }

        .container{
            margin: auto;
            margin-top: 40px;
            width: 70%;
        }
        header {
            background-color: black;
            padding: 20px;
        }

        header h1 {
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
    </style>
</head>
<body>
<header>
    <h1>ATERM</h1>
</header>
<nav>
    <a href="/students">Ученики</a>
    <a href="/subscriptions">Подписки</a>
    <a href="/lessons">Уроки</a>
    <a href="/prepods">Преподаватели</a>
</nav>
<div class="container">
    <h3>Ученики</h3>

    <form action="/students/" method="get">
        <input type="text" name="name" placeholder="Поиск">
        <input type="submit" value="Искать">
    </form>

    <form action="/student/create" method="post">
        <input type="text" name="name" placeholder="ФИО">
        <input type="text" name="phone" placeholder="Телефон">
        <input type="text" name="birthday" placeholder="Дата рождения">
        <input type="hidden" name="id" placeholder="ID" value="135">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Добавить ученика">
    </form>

    <#list students as student>
        <div class="student">
            <a href="/student/${student.id}">
                <div>${student.name}</div>
                <div>${student.phone}</div>
                <div>${student.birthday}</div>
            </a>
        </div>
    </#list>
</div>
</body>
</html>
