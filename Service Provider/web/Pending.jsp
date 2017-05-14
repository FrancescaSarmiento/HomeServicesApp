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
        <h3 class="secondPageHeader">Pending requests</h3>
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/>
        <sql:query dataSource = "${snapshot}" var = "schedule">
            SELECT booking.bookingId, booking.reserved_date, CONCAT(customer.firstName,' ',customer.lastName) AS name, customer.address, customer.contactNumber FROM booking NATURAL JOIN customer WHERE booking.bookingStatus="pending" AND booking.reserved_date >= CURDATE() AND spId="12" ORDER BY 1 DESC
        </sql:query>
        
        <div class="container-fluid">
            <div class="serviceContainer">
                <c:forEach var = "sche_dule" items = "${schedule.rows}">
                    <div class="sched">
                        <p class='date'><c:out value = "${sche_dule.reserved_date}"/></p>
                        <p class='name'><c:out value = "${sche_dule.name}"/></p>
                        <p class='addrss'><c:out value = "${sche_dule.address}"/></p>
                        <p class='cntct'><c:out value = "${sche_dule.contactNumber}"/></p>
                        
                        <c:set var="book" scope="session" value="${sche_dule.bookingId}"/>
                        <form action="AcceptServlet" method="POST">
                            <input type="submit" value="Accept">
                        </form>
                        <form action="RejectServlet" method="POST">
                            <input type="submit" value="Reject">
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>