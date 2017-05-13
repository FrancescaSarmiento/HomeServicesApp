<%-- 
    Document   : rejectBooking
    Created on : May 13, 2017, 4:35:24 PM
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
        <title>Reject Requests</title>
    </head>
    <body>
        
        <div class="nav">
            <a href="sphome.jsp">Home</a>
            <a href="Booking.jsp">Pending Requests</a>
            <a href="acceptedBooking.jsp">Accepted Requests</a>
            <a href="ongoingBooking.jsp">Ongoing Requests</a>
            <a href="CancelRequests.jsp">Cancel Requests</a>
            <a href="rejectBooking.jsp">Reject Requests</a>
            <a href="ApproveTransaction.jsp">Approve Transactions</a>
        </div>
        
        <h1>List of Pending Requests</h1>
        
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/> 
        
        <sql:query dataSource = "${snapshot}" var = "info1">
            SELECT idNum FROM user WHERE userName='${user}'; 
        </sql:query>
            
        <sql:query dataSource = "${snapshot}" var = "info">
            <c:forEach var = "info_1" items = "${info1.rows}">
                SELECT customer.firstName, customer.lastName, booking.reserved_date, booking.bookingId, booking.bookingStatus, service.serviceType FROM booking NATURAL JOIN service NATURAL JOIN customer WHERE booking.spId='<c:out value = "${info_1.idNum}"/>' AND booking.bookingStatus='pending' ORDER BY booking.bookingId DESC;
            </c:forEach>
        </sql:query>
        
        <div id="requests">
            <h2>List of Accepted Requests:</h2>
            <form action="RejectServlet" method="POST">
                <c:forEach var = "requests" items = "${info.rows}">
                    <p><input type="hidden" name="bookingId" value=<c:out value = "${requests.bookingId}"/> maxlength="1" size="1" readonly><c:out value = "${requests.firstName}"/> <c:out value="${requests.lastName}"/>: <c:out value="${requests.reserved_date}"/> <c:out value="${requests.serviceType}"/> <input type="submit" name="reject" value="Reject"></p>
                </c:forEach>
            </form>
        </div>
                
    </body>
</html>
