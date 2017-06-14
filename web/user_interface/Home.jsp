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

<%  if(!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<html>
<head>
    <title>Forest Tribes: Home</title>
    <%@include file="../WEB-INF/Head_Scripts.jsp"%>
</head>
<body>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<p>Hi <%= username%></p>
<p>${message}</p>
<a href="<%=sitePath%>user_interface/changePassword.jsp"><button>Change Password</button></a>
<a href="<%=sitePath%>Serve_Logout"><button>Log Out</button></a>

<iframe name="iframe_a" src="<%=sitePath%>tree_TRIAL/ForestTribe.jsp"frameborder=0 height="900px" width="1200px" scrolling="auto">
    <p>Your browser does not support iframes.</p>
</iframe>

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