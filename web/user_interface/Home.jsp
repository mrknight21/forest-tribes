<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 31/05/2017
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="User.UserSecurity" %>
<%@ page import="Utility.SecurityUtility" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%  if(!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/login_interface/Login.jsp");
    HttpSession session1 = request.getSession();
    String username = (String) session1.getAttribute("username");
%>
<%@include file="../Header.jsp"%>
<p>Hi <%= username%></p>
<p>${message}</p>

<a href="/user_interface/changePassword.jsp"><button>Change Password</button></a>

<a href="/Serve_Logout"><button>Log Out</button></a>

</body>
</html>


<!--

Todo: Add panel for articles (like the bootstrap web portfolio)


Input: login page, login servelet, regits page,
Session parameter: login, username

steps:
1. checkingLoginStatus
2. showing username.
3. options:
Logout( redirect to logOutpage.jsp)
ChangePassword (changingpassword.jsp)

-->