<%-- 
    Document   : Password
    Created on : May 13, 2017, 6:03:55 PM
    Author     : Jerome
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:if test="${user == null}">
    <c:redirect url="NoSession.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Handy Zeb - Schedule Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
        <link rel="stylesheet" href="styles.css">
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/2.0.4/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="WEB-INF/fragments/navbar.jsp"/>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        <h3 class="secondPageHeader">Change Password</h3>
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/> 
        
        <div class="container-fluid">
            <div class="serviceContainer">
                <form action="ChangePass" method="POST">
                    <p>Type in your <b>old</b> Password: 
                        <input type="password" name="old_pass">
                    </p>

                    <p>Type in your <b>new</b> Password: 
                        <input type="password" name="new_pass">
                    </p>

                    <p>Retype your <b>new</b> Password: 
                        <input type="password" name="new_passr">
                    </p>

                    <p><input type="submit" value="Save Changes"></p>
                </form>
            </div>
        </div>
    </body>
</html>
