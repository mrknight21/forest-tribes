<%@ page import="User.UserSecurity" %>
<%@ page import="Utility.SecurityUtility" %>
<%@ page import="java.nio.file.Path" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  if(!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Home</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp"%>
    <%@include file="../WEB-INF/Mapviewer.jsp"%>



</head>
<body>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<p>Hi <%= username%></p>
<p>${message}</p>



    <select name="background" id="background_selector">
        <option value="background_Mars.jpg">Mars</option>
        <option value="background_Schizophrenic.jpg">Schizophrenic</option>
        <option value="background_GreenMozaic.jpg">Green Mozaic</option>
        <option value="background_Brick.jpg">Brick</option>
    </select>
    <br><br>

    <div slider container style="position:relative; top: 0%; left: 35%; z-index: 999">
        <label for="zoom-control"  style="color: brown;font-size: xx-large; font-family: 'Californian FB';">Zoom Control: <em id="zoom-control-lable"></em></label>
        <div class="slider" id="zoom-control"></div>
    </div>


<div id="iframe_container" >
    <div id="loader" ><img src="<%= sitePath%>tree_TRIAL/Tree_Material/tree-leaf-gif.gif" style="display: block;margin: auto;width: 50%;"></div>
<iframe  onload="StopLoader()" id="myiframe" name="iframe_a" src="<%=sitePath%>tree_TRIAL/ForestTribe.jsp" frameborder=0 width="100%" height="900px" scrolling="auto">
    <p>Your browser does not support iframes.</p>
</iframe>
</div>

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