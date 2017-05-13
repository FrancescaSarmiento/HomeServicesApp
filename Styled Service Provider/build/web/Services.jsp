<%-- 
    Document   : Services
    Created on : May 13, 2017, 4:30:40 AM
    Author     : Jerome
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        <nav class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-header navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="Profile.jsp">Home</a></li>
                        <li><a href="Inbox.jsp">Messages</a></li>                 
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                ${spInfo.firstName()}
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dlabel">
                                <li><a href="Schedule.jsp">Edit Your Schedule</a></li>
                                <li><a href="Services.jsp">Add Services to Your Arsenal</a></li>
                            </ul>
                        </li>
                        <li><a href="Logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        <h2 class="pageHeader">Update Services</h2>
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost:3306/handyzebdb"
                   user = "root" password = ""/>
        <hr>
        <h3 class="secondPageHeader">Update Informations</h3>
        <div class="container-fluid">
            <div class="serviceContainer">
                <form action="Services" method="POST">
                    <p>You still need to check your current services (If you still offer them).</p>
                    <sql:query dataSource = "${snapshot}" var = "serviceTypes">
                        SELECT serviceType FROM service;
                    </sql:query>
                    <p><b>Services:</b><br>
                        <c:forEach var = "service_type" items = "${serviceTypes.rows}">
                            <label class="checkbox-inline">
                                <input type="checkbox" name=<c:out value = "${service_type.serviceType}"/>><c:out value = "${service_type.serviceType}"/><br>
                            </label>
                        </c:forEach>
                    </p>

                    <p><input type="submit" class="btn btn-primary btn-lg btn-block" value="Save Changes"></p>
                    </form>
             </div>
         </div>
        <div id="returnToHome">
           <a href="Profile.jsp">Return to Main Page</a>
        </div>        
    </body>
</html>