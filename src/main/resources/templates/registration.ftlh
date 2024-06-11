<!DOCTYPE html>
<html>
<head>
    <title>AT-ERP</title>
</head>
<body>
    <h1>Регистрация</h1>
    <form action="/registration" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">Подтвердить</button>
    </form>

<#if errorMessage??>
    <h2 style="color: red">{errorMessage}</h2>
</#if>

</body>
</html>