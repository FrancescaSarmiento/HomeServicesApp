<%-- 
    Document   : Schedule
    Created on : May 13, 2017, 3:32:43 AM
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
        <jsp:include page="WEB-INF/fragments/navbar.jsp"/>
        <jsp:include page="WEB-INF/fragments/banner.html"/>
        <h2 class="pageHeader">Update Schedule</h2>
        <hr>
        <h3 class="secondPageHeader">Update Informations</h3>
            <div class="container-fluid">
                <div class="schedContainer">
                <form action="EditSchedule" method="POST">
                    <p>Working Days:</p>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox1" name="sunday"> Sunday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox2" name="monday"> Monday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox3" name="tuesday"> Tuesday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox4" name="wednesday"> Wednesday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox5" name="thursday"> Thursday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox6" name="friday"> Friday
                    </label>
                    <label class="checkbox-inline"> 
                        <input type="checkbox" id="inlineCheckbox7" name="saturday"> Saturday
                    </label>
                    <p><input type="submit" class="btn btn-primary btn-lg btn-block" value="Save Changes"></p>
                </form>
                </div>
            </div>
    </body>
</html>