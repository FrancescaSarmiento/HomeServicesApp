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
    </head>
    <body>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        
        <p>Today is <%= new Date() %>.</p>
        <h2>Hello, <b>${spInfo.firstName}</b>!</h2>
        
        <div id="schedule">
            <h3>Schedule</h3>
        </div>

        <div id="cart">
            <h3>Profile</h3>
            
            <p><a href="UpdateInfo.jsp">Edit Your Profile</a></p>
            <p><a href="Message">Check your messages</a></p>
            <p><a href="Logout">Logout</a></p>
        </div>
    </body>
</html>
