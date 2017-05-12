<%-- 
    Document   : updateInfo
    Created on : May 12, 2017, 12:16:18 PM
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
    </head>
    <body>
        
        <h1>Messages</h1>
        
            <div id="messageMenu">
                <a href="CreateMessage.jsp"><h3>Create New Message</h3></a>
                <a href="Inbox.jsp"><h3>Inbox</h3></a>
                <a href="Outbox.jsp"<h3>Outbox</3></a>
            </div>        
    </body>
</html>
