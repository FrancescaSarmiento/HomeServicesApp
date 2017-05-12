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
    </head>
    <body>
        
        <h1>Messages</h1>
        
            <div id="createMessage">
                
                <form action="MessageServlet" method="POST">
                    
                    <p>Customer ID:<br>
                        <input type="number" name="customerID" required>
                    </p>
                    
                    <textarea rows="4" cols="50">
                        Enter message here.
                    </textarea>
                    
                    <p><input type="submit" value="Send Message"></p>
                    
                </form>
                
            </div>        
    </body>
</html>