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
        <title>Handy Zeb - Schedule Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
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
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/>
        <sql:query dataSource = "${snapshot}" var = "schedule">
            SELECT booking.bookingId, booking.reserved_date, CONCAT(customer.firstName,' ',customer.lastName) AS name, customer.address, customer.contactNumber FROM booking NATURAL JOIN customer WHERE booking.bookingStatus="pending" AND booking.reserved_date >= CURDATE() AND spId="12" ORDER BY 1 DESC
        </sql:query>
        
        <div class="container-fluid">
             <div class="row-fluid">
                <div class="span2">
                    <div class="col-sm-3 col-md-2">
                        <ul class="nav nav-pills nav-stacked sidebar">
                            <li><a href="Profile.jsp">Home</a></li>
                            <li class="active"><a href="Pending.jsp">Pending Requests</a></li>
                            <li><a href="acceptedBooking.jsp">Accepted Requests</a></li>
                            <li><a href="ongoingBooking.jsp">Ongoing Requests</a></li>
                            <li><a href="CancelRequests.jsp">Cancel Requests</a></li>
                            <li><a href="rejectBooking.jsp">Reject Requests</a></li>
                            <li><a href="ApproveTransaction.jsp">Approve Transactions</a></li>
                       </ul>
                    </div>
                </div>
             </div>
            <div class="span10">
                <h3 class="secondPageHeader">Pending Requests</h3>
                <div class="sched tableContent">
                        <table class="table table-striped table-hover">
                            <tr>
                                <th class="date">Date Reserved</th>
                                <th class="nameCol">Name</th>
                                <th class="addrCol">Address</th>
                                <th class="contactCol">Contact Number</th>
                                <th class="submitCol"></th>
                                <th class="rejectCol"></th>
                            </tr>
                            <c:forEach var = "sche_dule" items = "${schedule.rows}">        
                            <tr>
                                <td class='date'><c:out value = "${sche_dule.reserved_date}"/></td>
                                <td class='name'><c:out value = "${sche_dule.name}"/></td>
                                <td class='addrss'><c:out value = "${sche_dule.address}"/></td>
                                <td class='cntct'><c:out value = "${sche_dule.contactNumber}"/></td>
                                <td class="bookId"><c:set var="book" scope="session" value="${sche_dule.bookingId}"/></td>
                                <td>
                                    <form action="AcceptServlet" method="POST">
                                        <input type="submit" value="Accept">
                                    </form>
                                </td>
                                <td>
                                    <form action="RejectServlet" method="POST">
                                        <input type="submit" value="Reject">
                                    </form>
                                </td>
                            </tr>
                        </table>
                    </div>
                </c:forEach>
                        </div>
        </div>
    </body>
</html>