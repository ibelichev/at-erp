<!DOCTYPE html>
<html>
<head>
    <title>BUYSELL</title>
</head>
<body>
<h1>BUYSELL</h1><hr>
<h4>Регистрация</h4>
<form action="/registration" method="post">
    ФИО: <input type="text" name="name"><br><br>
    Эл. почта: <input type="email" name="email"><br><br>
    Пароль: <input type="password" name="password"><br><br>
    <select name="roles" required>
            <option value="">Роль</option>

                <option value="ROLE_CLIENT">Ученик</option>
                <option value="ROLE_ADMIN">Админ</option>

        </select>
    <input type="hidden" name="_csrf" value="${_csrf.token}">

    <input type="submit" value="Зарегестрировать"/>
</form>

<#if errorMessage??>
    <h2 style="color: red">{errorMessage}</h2>
</#if>

</body>
</html>