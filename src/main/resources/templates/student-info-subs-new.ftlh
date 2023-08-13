<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student</title>
    <style>
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

        .student-info {
            margin: 20px auto;
            width: 70%;
            padding: 10px;
            background-color: #f2f2f2;
            border-radius: 4px;
        }

        form {
            text-align: center;
            margin-top: 20px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        input[type="time"],
        input[type="submit"],
        select {
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-radius: 4px;
            width: 70%;
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

        .container {
            width: 70%;
            margin: auto;
            margin-top: 40px;
        }

        h3 {
            margin: 20px 0;
            text-align: center;
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

        tbody tr:hover {
            background-color: #f9f9f9;
        }

        p {
            text-align: center;
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
    <h3>Ученик: ${student.name}</h3>

    <div class="student-info">
        <div><b>ФИО: </b>${student.name}</div>
        <div><b>Телефон: </b>${student.phone}</div>
        <div><b>Дата рождения: </b>${student.birthday}</div>
    </div>

    <div class="subscriptions">
        <#list subscriptions as subscription>
            <a href="/subscription/${subscription.id}">
                <h5 style="margin-left: 103px">Подписки: ${subscription.subscriptionName}</h5>
            </a>
        </#list>
    </div>

    <div class="student-info">
        <form action="/subscriptions/add" method="post">
            <input type="hidden" name="id" value="${idd}">
            <input type="text" name="subscriptionName" placeholder="Название подписки">
            <input type="text" name="studentName" placeholder="ФИО ученика" value="${student.name}">
            <input type="hidden" name="studentId" value="${student.id}">
            <input type="text" name="amountOfLessons" placeholder="План уроков">
            <input type="hidden" name="nowLesson" value="0">
            <input type="text" name="toPay" placeholder="К оплате">
            <input type="text" name="money" placeholder="Внести оплату">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Добавить подписку">
        </form>

        <form action="/student/delete/${student.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Удалить ученика">
        </form>
    </div>

</div>
</body>
</html>