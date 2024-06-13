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

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 4px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .btn {
            background-color: red;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: darkred;
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
        <#if student.passportSeries??>
            <div><b>Серия паспорта: </b>${student.passportSeries}</div>
        </#if>
        <#if student.passportNumber??>
            <div><b>Номер паспорта: </b>${student.passportNumber}</div>
        </#if>
    </div>

    <#if !student.passportSeries?? && !student.passportNumber??>
        <button id="addPassportBtn" class="btn">Добавить серию и номер паспорта</button>
    </#if>

    <div class="subscriptions">
        <#list subscriptions as subscription>
            <a href="/subscription/${subscription.id}">
                <h5 style="margin-left: 103px">Подписки: ${subscription.subscriptionName}</h5>
            </a>
        </#list>
    </div>

    <div class="student-info">
        <form action="/subscriptions/add" method="post">
            <input type="text" name="subscriptionName" placeholder="Название подписки">
            <input type="text" name="studentName" placeholder="ФИО ученика" value="${student.name}">
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

<!-- The Modal -->
<div id="passportModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form action="/student/add_passport" method="post">
            <input type="text" name="passportSeries" placeholder="Серия паспорта" required>
            <input type="text" name="passportNumber" placeholder="Номер паспорта" required>
            <input type="hidden" name="studentId" value="${student.id}">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Добавить">
        </form>
    </div>
</div>

<script>
    // Get the modal
    var modal = document.getElementById("passportModal");

    // Get the button that opens the modal
    var btn = document.getElementById("addPassportBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks the button, open the modal
    if(btn){
        btn.onclick = function() {
            modal.style.display = "block";
        }
    }

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
</body>
</html>