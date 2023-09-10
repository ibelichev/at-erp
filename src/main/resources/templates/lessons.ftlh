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
            text-align: center;
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

        h2 {
            color: red;
            margin: 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

        tbody tr:hover {
            background-color: #f9f9f9;
        }

        p {
            text-align: center;
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
    <h1>Все уроки</h1>

    <#if lessonsByPrepod?has_content>
        <#list lessonsByPrepod?keys as prepod>
            <h2>${prepod}</h2>
            <table>
                <thead>
                <tr>
                    <th>Номер урока</th>
                    <th>Дата</th>
                    <th>Время</th>
                    <th>Ученик</th>
                </tr>
                </thead>
                <tbody>
                <#list lessonsByPrepod[prepod] as lesson>
                    <tr>
                        <td>${lesson.numbOfLesson}</td>
                        <td>${lesson.date}</td>
                        <td>${lesson.time}</td>
                        <td>${lesson.subscription.student.name}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#list>
    <#else>
        <p>No lessons found.</p>
    </#if>
</div>
</body>
</html>
