<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <form action="php/login.php" method="post">
            <div class="loginForm-container">
                <label><b>Username:</b></label>
                <input type="text" name="uName" placeholder="Enter Username" required/>
                <label><b>Password:</b></label>
                <input type="password" name="pass" placeholder="Enter Password" required/>
                <button type="submit">Login</button>
            </div>
        </form>
        <a href="register-page.php"><button type="submit">Register</button></a>
    </body>
</html>
