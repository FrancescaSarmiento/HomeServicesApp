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
        
        <h2 id="loginHeader">Login</h2>
        
        <div class="loginArea">
            <form action="SpLogin" method="POST">
                <p>Username:
                    <input type="text" name="name" class="form-control" placeholder="Username" aria-describedby="basic-addon1" required>
                </p>
                <p>Password:
                    <input type="password" name="pass" class="form-control" placeholder="Password" aria-describedby="basic-addon1" required>
                </p>
                <input class="btn btn-primary btn-lg btn-block" type="submit" value="Login">
            </form>
        </div>
    </body>
</html>
