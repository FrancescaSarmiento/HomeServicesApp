<%-- 
    Document   : ongoingBooking
    Created on : May 13, 2017, 3:23:35 AM
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
        <title>Ongoing Requestst</title>
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
                <jsp:include page="WEB-INF/fragments/requestsnav.html"/>
                <div class="span10">
                   <h3 class="secondPageHeader">On going requests</h3>
                    <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                                       url = "jdbc:mysql://localhost:3306/handyzebdb"
                                       user = "root" password = ""/> 

                    <sql:query dataSource = "${snapshot}" var = "info1">
                        SELECT idNum FROM user WHERE userName='${user}'; 
                    </sql:query>

                    <sql:query dataSource = "${snapshot}" var = "info">
                        <c:forEach var = "info_1" items = "${info1.rows}">
                            SELECT customer.firstName, customer.lastName, booking.bookingId, booking.reserved_date, service.serviceType FROM booking NATURAL JOIN service NATURAL JOIN customer WHERE booking.spId='<c:out value = "${info_1.idNum}"/>' AND booking.bookingStatus='ongoing' ORDER BY booking.bookingId DESC;
                        </c:forEach>
                    </sql:query>
                    
                    <div id="requests" class="tableContent">
                        <form action="FinishServlet" method="POST">
                            <table class="table table-striped table-hover">
                                <tr>
                                    <th class="bookIdCol"></th>
                                    <th class="nameCol">Name</th>
                                    <th class="dateCol">Date Reserved</th>
                                    <th class="typeCol">Type</th>
                                    <th class="submitCol"></th>
                                </tr>
                                    <c:forEach var = "requests" items = "${info.rows}">
                                    <tr>
                                        <td><input type="hidden" name="bookingId" value=<c:out value = "${requests.bookingId}"/> readonly></td>
                                        <td><c:out value = "${requests.firstName}"/> <c:out value="${requests.lastName}"/></td>
                                        <td><c:out value="${requests.reserved_date}"/></td>
                                        <td><c:out value="${requests.serviceType}"/></td>
                                        <td><input type="submit" class="btn btn-success" name="timeFinished" value="Finish"></td>
                                    </tr>
                            </c:forEach>
                                </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>           
    </body>
</html>