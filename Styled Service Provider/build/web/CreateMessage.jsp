<%-- 
    Document   : CreateMessage
    Created on : May 12, 2017, 10:17:16 PM
    Author     : Hiromi Uematsu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="user" scope="page" value="${sessionScope.user}"/>

<c:if test="${user == null}">
    <c:redirect url="fail.html"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Messages</title>
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
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <div class="col-sm-3 col-md-2">
                        <a href="CreateMessage.jsp" class="btn btn-danger btn-sm btn-block" role="button"><i class="glyphicon glyphicon-edit"></i> Compose</a>
                        <hr>
                        <ul class="nav nav-pills nav-stacked sidebar">
                            <form action="filerServlet" method="POST">
                                <p>Filter Out By Name:<br>
                                    <input type="text" class="filterBox" name="filteredName"><input type="submit" value="Search"></p>
                            </form>
                            <li><a href="Inbox.jsp" role="presentation">Inbox </a>
                            </li>
                            <li><a href="Outbox.jsp" role="presentation">Outbox</a></li>
                        </ul>
                    </div>
                </div>
                <div class="span10">
                    <h1 class="pageHeader">Messages</h1>
                    <div id="createMessage" class="tableContent">
                        <form action="MessageServlet" method="POST">

                            <p>
                                Customer ID: <input type="number" name="customerID" required>
                            </p>

                            <textarea class="form-control" style="width:100%;" row="3" placeholder="Enter your message here."></textarea>

                            <p><input type="submit" value="Send Message"></p>

                        </form>
                    </div>        
                </div>
            </div>
        </div>
    </body>
</html>