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
    </head>
    <body>
        
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
                    
                    <p><b>User Name:</b><br>
                        <c:forEach var = "user_name" items = "${info.rows}">
                            <input type="text" name="username" value=<c:out value = "${user_name.userName}"/>>
                        </c:forEach>
                    </p>
                                        
                    <p><b>New Password:</b><br>
                        <input type="password" name="password">
                    </p>
                    
                    <p><b>E-Mail:</b><br>
                        <c:forEach var = "eMail" items = "${info.rows}">
                            <input type="text" name="email" value=<c:out value = "${eMail.email}"/>>
                        </c:forEach>
                    </p>
                    
                    <p><b>Contact Number:</b><br>
                        <c:forEach var = "contact_number" items = "${info.rows}">
                            <input type="text" name="contactNumber" value=<c:out value = "${contact_number.contactNumber}"/>>
                        </c:forEach>
                    </p>
                    
                    <p><b>Working Days:</b><br>
                        <input type="checkbox" name="monday"> Monday<br>
                        <input type="checkbox" name="tuesday"> Tuesday<br>
                        <input type="checkbox" name="wednesday"> Wednesday<br>
                        <input type="checkbox" name="thursday"> Thursday<br>
                        <input type="checkbox" name="friday"> Friday<br>
                        <input type="checkbox" name="saturday"> Saturday<br>
                        <input type="checkbox" name="sunday"> Sunday<br>
                    </p>
                    
                    <sql:query dataSource = "${snapshot}" var = "serviceTypes">
                        SELECT serviceType FROM service;
                    </sql:query>
                        <p><b>Services:</b><br>
                            <c:forEach var = "service_type" items = "${serviceTypes.rows}">
                                <input type="checkbox" name=<c:out value = "${service_type.serviceType}"/>><c:out value = "${service_type.serviceType}"/><br>
                            </c:forEach>
                        </p>
                    
                    <p><input type="submit" value="Save Changes"></p>
                </form>
            </div>        
    </body>
</html>
