<%-- 
    Document   : FixRates
    Created on : May 14, 2017, 5:49:16 PM
    Author     : Jerome
--%>

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
    <c:redirect url="NoSession.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Handy Zeb - Add Services</title>
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
        
        <sql:query dataSource = "${snapshot}" var = "info">
            SELECT service_provider.spId FROM user INNER JOIN service_provider ON user.idNum=service_provider.spId WHERE user.userName="${user}";
        </sql:query>
        <c:forEach var = "sp" items = "${info.rows}">
            <c:set var="spId" scope="page" value = "${sp.spId}"/>
        </c:forEach>
        
        <div id="updateForm">
            <h3>Type in your fixed rate for each service.</h3>
            <form action="AddFixRate" method="POST">
                <sql:query dataSource = "${snapshot}" var = "serviceTypes">
                    SELECT service.serviceType FROM service NATURAL JOIN sp_service NATURAL JOIN service_provider WHERE service_provider.spId=${spId};
                </sql:query>
                    <p><b>Services:</b><br></p>
                    <p>
                        <c:forEach var = "service_type" items = "${serviceTypes.rows}">
                            <c:out value = "${service_type.serviceType}"/>: <input type="number" step="0.01" name=<c:out value = "${service_type.serviceType}"/> required><br><br>
                        </c:forEach>
                    </p>

                <p><input type="submit" value="Save Changes"></p>
            </form>
        </div>        
    </body>
</html>
