<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="user" scope="page" value="${sessionScope.user}"/>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
           url = "jdbc:mysql://localhost:3306/handyzebdb"
           user = "root" password = ""/>
<sql:query dataSource = "${snapshot}" var = "firstName">
    SELECT service_provider.firstName FROM service_provider INNER JOIN user ON service_provider.spId = user.idNum WHERE user.userName="${user}";
</sql:query>
    <nav class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-header navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="Profile.jsp">Home</a></li>
                        <li><a href="Inbox.jsp">Messages</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <c:forEach var = "first_name" items = "${firstName.rows}">
                                    <c:out value = "${first_name.firstName}"/>
                                </c:forEach>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dlabel">
                                <li><a href="Schedule.jsp">Edit Your Schedule</a></li>
                                <li><a href="Services.jsp">Add Services to Your Arsenal</a></li>
                                 <li><a href="Pending.jsp">View pending requests</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="Password.jsp">Change Your Password</a></li>
                            </ul>
                        </li>
                        <li><a href="Logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>