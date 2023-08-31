<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Подписки</title>
    <style>
        body {
            background-color: white;
            color: black;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        div {
            background-color: #f2f2f2;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 10px;
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
    <h3>Подписки</h3>
    <#list subscriptions as sub>
        <div>
            <div><b>Имя ученика: </b>
              <#if sub.student?has_content>
                ${sub.student.name}
              <#else>
                N/A
              </#if>
            </div>
            <div><b>Название подписки: </b>${sub.subscriptionName}</div>
            <div><b>Id: </b>${sub.student.id}</div>
        </div>
    </#list>
</div>
</body>
</html>
