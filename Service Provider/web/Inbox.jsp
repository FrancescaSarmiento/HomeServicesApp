<%-- 
    Document   : Inbox
    Created on : May 12, 2017, 10:30:13 PM
    Author     : Hiromi Uematsu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="user" scope="page" value="${sessionScope.user}"/>

<c:if test="${user == null}">
    <c:redirect url="NoSession.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inbox</title>
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
                        <form action="SearchMessage" method="POST">
                            <p>Filter Out By Name: 
                                <input type="text" name="filteredName"><input type="submit" value="Search"></p>
                        </form>
                        <li class="active"><a href="Inbox.jsp" role="presentation">Inbox </a>
                        </li>
                        <li><a href="Outbox.jsp" role="presentation">Outbox</a></li>
                        </ul>
                </div>
              </div>
              <div class="span10">
                <h1 class="pageHeader">Inbox</h1>
                <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/> 
        
                <sql:query dataSource = "${snapshot}" var = "info1">
                    SELECT idNum FROM user WHERE userName='${user}'; 
                </sql:query>
        
                <sql:query dataSource = "${snapshot}" var = "info">
                    <c:forEach var = "info_1" items = "${info1.rows}">
                        SELECT customer.custId, CONCAT(customer.firstName,' ', customer.lastName) AS name, message.messageBody, message.timeSent FROM message INNER JOIN customer ON message.senderId=customer.custId WHERE message.receiverId='<c:out value = "${info_1.idNum}"/>';
                    </c:forEach>
                </sql:query>
        
                <div id="inbox" class="spanContent">
                    <c:forEach var = "messages" items = "${info.rows}">
                        <p><c:out value = "${messages.custId}"/> || <c:out value = "${messages.name}"/> || <c:out value = "${messages.messageBody}"/> || <c:out value = "${messages.timeSent}"/></p><br>
                    </c:forEach>               
                </div>    
                </div>
            </div>
        </div>    
    </body>
</html>