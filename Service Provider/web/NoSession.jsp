<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Handy Zeb - Not Logged In/Session Expired</title>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        
        <h2>You are not logged in yet.</h2>
        <p>You have to be logged in to use the app</p>

        <p>Please <a href="SpLogin.jsp">log in</a> first.</p>
    </body>
</html>
