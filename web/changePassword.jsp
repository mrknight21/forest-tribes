<%@ page import="ictgradschool.ex05.Server_Utility" %><%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 1/06/2017
  Time: 11:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ictgradschool.ex05.Server_Utility" %>
<%@ page import="ictgradschool.ex05.MySQL" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    if(!Server_Utility.loggingStatusChecker(request)){
        response.sendRedirect("/ex05/Login.jsp");
    }
%>
<form action="/Serve_Changepassword" method="post">
    <legend>Change your password</legend>
    <p>${passwordStatus}</p>
    <label for="loginUsernameID">Current Passwod: </label>
    <input type="password" id="loginUsernameID" name="CurrentPassword" placeholder="Username"/>
    <br>
    <label for="loginPasswordID">New Password: </label>
    <input type="password" id="loginPasswordID" name="NewPassword" placeholder="Password"/>
    <br>
    <label for="loginPasswordID">Confirm New Password: </label>
    <input type="password" id="confirmPasswordID" name="ConfirmPassword" placeholder="Password"/>
    <input type="submit" value="Submit">
</form>
<a href="/ex05/Content.jsp" ><button>Cancel</button></a>

</body>
</html>




<!--
From: Content.jsp.

Form:
username:
password
new password:
confirm new password;

steps:
1. checkLogginstaus



destination: Serve_Changepassword action: post

-->