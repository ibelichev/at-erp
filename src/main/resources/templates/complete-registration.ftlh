<!DOCTYPE html>
<html>
<head>
    <title>Завершение регистрации</title>
</head>
<body>
    <h1>Завершение регистрации</h1>
    <form action="/complete-registration" method="post">
        <input type="hidden" name="email" th:value="${email}">
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password" required>
        <button type="submit">Завершить регистрацию</button>
    </form>
    <div th:if="${errorMessage}">
        <p th:text="${errorMessage}"></p>
    </div>
</body>
</html>