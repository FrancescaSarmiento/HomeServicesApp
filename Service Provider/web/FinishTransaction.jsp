<%-- 
    Document   : FinishTransaction
    Created on : May 14, 2017, 3:13:27 PM
    Author     : Jerome
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="user" scope="page" value="${sessionScope.user}"/>

<c:if test="${user == null}">
    <c:redirect url="NoSession.jsp"/>
</c:if>
    
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Handy Zeb - SP Login Page</title>
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
        
        <h2>Finish Transaction</h2>
        
        <div class="loginArea">
            <p>We're almost done, just let us know what you did:</p>
            <form action="AddService" method="POST">
                <p>Service Made:
                    <input type="text" name="serv" class="form-control" placeholder="Service Name" aria-describedby="basic-addon1" required>
                </p>
                <p>Number of Hours for you to finish the job:
                    <input type="number" step="0.1" name="hours" class="form-control" placeholder="200" aria-describedby="basic-addon1" required>
                </p>
                <input class="btn btn-primary btn-lg btn-block" type="submit" value="Add Service">
            </form>
        </div>
        <div><p>Done then? Just click <a href='FinishTransaction'>here</a> to finish the transaction.
                (Please wait until the client has approved of the things you've done.)
            </p></div>
    </body>
</html>