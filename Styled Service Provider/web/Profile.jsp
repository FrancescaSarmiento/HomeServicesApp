<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="user" scope="page" value="${sessionScope.user}"/>
<c:set var="spInfo" scope="page" value="${sessionScope.spInfo}"/>

<c:if test="${user == null}">
    <c:redirect url="NoSession.jsp"/>
</c:if>

<!DOCTYPE html> 
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Handy Zeb - Profile Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
        <link rel="stylesheet" href="styles.css">
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/2.0.4/js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-header navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="Profile.jsp">Home</a></li>
                        <li><a href="Inbox.jsp">Messages</a></li>                 
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                ${spInfo.firstName()}
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dlabel">
                                <li><a href="Schedule.jsp">Edit Your Schedule</a></li>
                                <li><a href="Services.jsp">Add Services to Your Arsenal</a></li>
                            </ul>
                        </li>
                        <li><a href="Logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        
        <div class="container2">
            <h1>Today is</h1>
            <p id="timeStamp"><%= new Date() %></p>
            <h2>Hello, <b>${spInfo.firstName}</b>!</h2>
            <hr>
            <h3>Schedule</h3>
        </div>
    </body>
</html>
