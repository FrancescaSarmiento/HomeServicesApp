<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Handy Zeb - SP Login Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        
        <h2>Login</h2>
        
        <form action="SpLogin" method="POST">
            <p>Username:<br><input type="text" name="name" required></p>
            <p>Password:<br><input type="password" name="pass" required></p>
            <p><input type="submit" value="Login"></p>
        </form>
    </body>
</html>
