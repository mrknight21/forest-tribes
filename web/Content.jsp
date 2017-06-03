<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 31/05/2017
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="ictgradschool.ex05.Server_Utility" %>
<%@ page import="ictgradschool.ex05.MySQL" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%  if(!Server_Utility.loggingStatusChecker(request)) response.sendRedirect("/ex05/Login.jsp");
    HttpSession session1 = request.getSession();
    String username = (String) session1.getAttribute("username");
%>

<p>Hi <%= username%></p>
<p>${Welcome}</p>

<a href="/ex05/changePassword.jsp"><button>Change Password</button></a>

<a href="/Serve_Logout"><button>Log Out</button></a>

</body>
</html>


<!--
Input: login page, login servelet, regits page,
Session parameter: login, username

steps:
1. checkingLoginStatus
2. showing username.
3. options:
Logout( redirect to logOutpage.jsp)
ChangePassword (changingpassword.jsp)

-->