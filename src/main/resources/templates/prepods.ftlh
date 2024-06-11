<!DOCTYPE html>
<html>
<head>
    <title>Список преподавателей</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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

        h1 {
            text-align: center;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f5f5f5;
            font-weight: bold;
        }

        form {
            text-align: center;
            margin-top: 20px;
        }

        input[type="text"] {
            padding: 5px;
            border: 1px solid #ddd;
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
        .container {
            width: 70%;
            margin: auto;
            margin-top: 40px;
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
    <h1>Список преподавателей</h1>

    <table>
        <thead>
        <tr>
            <th>Идентификатор</th>
            <th>Имя</th>
            <th>Действия</th>
        </tr>
        </thead>
        <tbody>
        <#list prepods as prepod>
            <tr>
                <td>${prepod.id}</td>
                <td>${prepod.name}</td>
                <td>
                    <form action="/prepod/${prepod.id}/delete" method="post" style="display: inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Удалить">
                    </form>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>

    <h2>Добавить преподавателя</h2>

    <form action="/prepod/create" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        <label for="name">Имя:</label>
        <input type="text" id="name" name="name">
        <input type="submit" value="Добавить">
    </form>
</div>
</body>
</html>