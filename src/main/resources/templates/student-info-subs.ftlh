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

    <h5 style="margin-left: 103px">Подписки: ${subscriptions.subscriptionName}</h5>

    <div class="student-info">
        <div>План уроков: ${subscriptions.amountOfLessons}</div>
        <div>Факт уроков: ${subscriptions.nowLesson}</div>
        <div>К оплате: ${subscriptions.toPay}</div>
        <div>Оплачено: ${subscriptions.money}</div>

        <form action="/subscription/delete/${student.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Удалить подписку">
        </form>
    </div>

    <form action="/student/delete/${student.id}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Удалить ученика">
    </form>

    <h3>Запланировать урок</h3>

    <form action="/lesson/create" method="post">
        <input type="hidden" name="studentId" value="${student.id}">
        <input type="hidden" name="studentName" value="${student.name}">
        <input type="number" name="numbOfLesson" placeholder="Номер занятия" required>
        <input type="date" name="date" placeholder="Дата" required>
        <input type="time" name="time" placeholder="Время" required>
        <select name="prepod" required>
            <option value="">Выберите преподавателя</option>
            <#list prepods as prepod>
                <option value="${prepod.name}">${prepod.name}</option>
            </#list>
        </select>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Назначить">
    </form>

    <h3>Список уроков</h3>

    <#if lessons?has_content>
        <table>
            <thead>
            <tr>
                <th>Номер урока</th>
                <th>Дата</th>
                <th>Время</th>
                <th>Преподаватель</th>
                <th>Статус</th>
                <th>Действия</th>

            </tr>
            </thead>
            <tbody>
            <#list lessons as lesson>
                <tr>
                    <td>${lesson.numbOfLesson}</td>
                    <td>${lesson.date}</td>
                    <td>${lesson.time}</td>
                    <td>${lesson.prepod}</td>
                    <td>${lesson.status}</td>

                    <#if lesson.status != "Проведен">
                        <td>
                            <form action="/lesson/${lesson.id}/delete" method="post" style="display: inline;">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Удалить">
                            </form>

    <#--                        /lesson/{id}/update/{status}-->

                            <form action="/lesson/${lesson.id}/update/${student.id}/${"Проведен"}" method="post" style="display: inline;">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Проведен">
                            </form>

                            <form action="/lesson/${lesson.id}/update/${student.id}/${"Сгорело"}" method="post" style="display: inline;">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" value="Сгорело">
                            </form>
                        </td>
                    </#if>


                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <p>Ни один урок не назначен</p>
    </#if>
</div>
</body>
</html>