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
    <c:redirect url="fail.html"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inbox</title>
    </head>
    <body>
        
        <h1>Inbox</h1>
        
        <div id="filtering">
            <form action="filerServlet" method="POST">
                <p>Filter Out By Name: 
                    <input type="text" name="filteredName"><input type="submit" value="Search"></p>
            </form>
        </div>
        
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/> 
        
        <sql:query dataSource = "${snapshot}" var = "info1">
            SELECT idNum FROM user WHERE userName='${user}'; 
        </sql:query>
        
        <sql:query dataSource = "${snapshot}" var = "info">
            <c:forEach var = "info_1" items = "${info1.rows}">
                SELECT customer.firstName, customer.lastName, message.senderId, message.messageBody, message.timeSent FROM user INNER JOIN message ON user.idNum=message.receiverId INNER JOIN customer ON message.senderId=customer.custId WHERE message.receiverId='<c:out value = "${info_1.idNum}"/>';
            </c:forEach>
        </sql:query>
        
            <div id="inbox">
                
                <c:forEach var = "messages" items = "${info.rows}">
                    <p><c:out value = "${messages.firstName}"/> <c:out value = "${messages.lastName}"/> || <c:out value = "${messages.senderId}"/> || <c:out value = "${messages.messageBody}"/> || <c:out value = "${messages.timeSent}"/></p><br> <a href="CreateMessage.jsp">Reply</a>
                </c:forEach>
                
            </div>        
    </body>
</html>