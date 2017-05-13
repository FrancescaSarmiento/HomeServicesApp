<%-- 
    Document   : Outbox
    Created on : May 13, 2017, 1:13:12 AM
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
        <title>Outbox</title>
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
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <div class="col-sm-3 col-md-2">
                        <div class="btn-group">
                        <a href="CreateMessage.jsp" class="btn btn-danger btn-sm btn-block" role="button"><i class="glyphicon glyphicon-edit"></i> Compose</a>
                        <hr>
                        <hr>
                        <ul class="nav nav-pills nav-stacked sidebar">
                            <form action="filerServlet" method="POST">
                                <p>Filter Out By Name: 
                                    <input type="text" name="filteredName"><input type="submit" value="Search"></p>
                            </form>
                            <li><a href="Inbox.jsp" role="presentation">Inbox </a></li>
                            <li class="active"><a href="Outbox.jsp" role="presentation">Outbox</a></li>
                        </ul>
                        </div>
                    </div>
                </div>
                <div class="span10">
                    <h1 class="pageHeader">Outbox</h1>
                    <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/> 
        
                    <sql:query dataSource = "${snapshot}" var = "info1">
                        SELECT idNum FROM user WHERE userName='${user}'; 
                    </sql:query>

                    <sql:query dataSource = "${snapshot}" var = "info">
                        <c:forEach var = "info_1" items = "${info1.rows}">
                            SELECT customer.firstName, customer.lastName, message.senderId, message.messageBody, message.timeSent FROM user INNER JOIN message ON user.idNum=message.senderId INNER JOIN customer ON message.receiverId=customer.custId WHERE message.senderId='<c:out value = "${info_1.idNum}"/>';
                        </c:forEach>
                    </sql:query>

                   <div id="inbox" class="spanContent">

                        <c:forEach var = "messages" items = "${info.rows}">
                            <p><c:out value = "${messages.firstName}"/> <c:out value = "${messages.lastName}"/> || <c:out value = "${messages.senderId}"/> || <c:out value = "${messages.messageBody}"/> || <c:out value = "${messages.timeSent}"/></p><br> <a href="CreateMessage.jsp">Reply</a>
                        </c:forEach>
                    </div>   
                </div>
            </div>
        </div>
    </body>
</html>

