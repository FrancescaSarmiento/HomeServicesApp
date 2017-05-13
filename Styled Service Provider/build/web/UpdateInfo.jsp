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

<c:if test="${user == null}">
    <c:redirect url="NoSession.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Information</title>
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
                        <li><a href="Message.jsp">Messages</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                ${spInfo.firstName()}
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dlabel">
                                <li><a href="UpdateInfo.jsp" role="presentation">Edit Your Profile</a></li>
                            </ul>
                        </li>
                        <li><a href="Logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <h1>Update Information</h1>
        <h2>Currently logged in as <b>${spInfo.firstName}</b></h2>
        
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost:3306/handyzebdb"
                           user = "root" password = ""/>           
        
        <sql:query dataSource = "${snapshot}" var = "info">
            SELECT service_provider.shift_end, service_provider.shift_start, service_provider.firstName, service_provider.lastName, service_provider.email, service_provider.working_days, service_provider.contactNumber, user.userName FROM user INNER JOIN service_provider ON user.idNum=service_provider.spId WHERE user.userName="${user}";
        </sql:query>
        
            <div id="updateForm">
                <h3>Update Informations</h3>
                <form action="EditProfile" method="POST">
                    <div class="updateInfoSp">
                        <p><b>User Name:</b>
                            <c:forEach var = "user_name" items = "${info.rows}">
                                <input type="text" name="username" class="form-control" aria-describedby="basic-addon1" value=<c:out value = "${user_name.userName}"/>>
                            </c:forEach>
                        </p>

                        <p><b>New Password:</b>
                            <input type="password" name="password" class="form-control" aria-describedby="basic-addon1">
                        </p>

                        <p><b>E-Mail:</b>
                            <c:forEach var = "eMail" items = "${info.rows}">
                                <input type="text" name="email" class="form-control" aria-describedby="basic-addon1" value=<c:out value = "${eMail.email}"/>>
                            </c:forEach>
                        </p>

                        <p><b>Contact Number:</b>
                            <c:forEach var = "contact_number" items = "${info.rows}">
                                <input type="text" name="contactNumber" class="form-control" aria-describedby="basic-addon1" value=<c:out value = "${contact_number.contactNumber}"/>>
                            </c:forEach>
                        </p>
                    <div>
                    <p><b>Working Days:</b><br>
                    <ul>
                        <li><input type="checkbox" name="monday"> Monday</li>
                        <li><input type="checkbox" name="tuesday"> Tuesday</li>
                        <li><input type="checkbox" name="wednesday"> Wednesday</li>
                        <li><input type="checkbox" name="thursday"> Thursday</li>
                        <li><input type="checkbox" name="friday"> Friday</li>
                        <li><input type="checkbox" name="saturday"> Saturday</li>
                        <li><input type="checkbox" name="sunday"> Sunday</li>
                    </ul>
                    </p>
                    
                    <sql:query dataSource = "${snapshot}" var = "serviceTypes">
                        SELECT serviceType FROM service;
                    </sql:query>
                        <p><b>Services:</b><br>
                            <c:forEach var = "service_type" items = "${serviceTypes.rows}">
                                <input type="checkbox" name=<c:out value = "${service_type.serviceType}"/>><c:out value = "${service_type.serviceType}"/>
                            </c:forEach>
                        </p>
                    
                    <p><input type="submit" value="Save Changes"></p>
                </form>
            </div>        
    </body>
</html>
