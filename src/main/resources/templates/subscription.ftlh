<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Subscription</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
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
<h5 style="margin-left: 103px">Подписки: ${subscription.subscriptionName}</h5>

<div class="student-info">
    <div>План уроков: ${subscription.amountOfLessons}</div>
    <div>Факт уроков: ${subscription.nowLesson}</div>
    <div>К оплате: ${subscription.toPay}</div>
    <div>Оплачено: ${subscription.money}</div>

    <form action="/subscription/delete/${subscription.id}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Удалить подписку">
    </form>
</div>

<h3>Запланировать урок</h3>

<form action="/lesson/create" method="post">
    <input type="hidden" name="subscription" value="${subscription.id}">
    <#if student?exists>
        <div><b>Имя ученика: </b>${student.name}</div>
    </#if>

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

                        <form action="/lesson/${lesson.id}/update/${subscription.id}/${"Проведен"}" method="post" style="display: inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="submit" value="Проведен">
                        </form>

                        <form action="/lesson/${lesson.id}/update/${subscription.id}/${"Сгорело"}" method="post" style="display: inline;">
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


<div id="lessonCalendar"></div>


</div>

<script th:inline="javascript">
    /*<![CDATA[*/
    var lessonFramesData = /*[[${lessonFramesJSON}]]*/ [];
    /*]]>*/
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/fullcalendar.min.js"></script>

<script>
$(document).ready(function() {
    var eventsData = lessonFramesData.map(function(lessonFrame) {
        return {
            title: lessonFrame.prepod,
            start: lessonFrame.date + 'T' + lessonFrame.prepod,
            end: lessonFrame.date + 'T' + lessonFrame.prepod,
            color: lessonFrame.isAvailable ? 'green' : 'red'
        };
    });

    $('#lessonCalendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        events: eventsData,
        eventRender: function(event, element) {
            element.css('background-color', event.color);
        }
    });
});
</script>

</body>
</html>