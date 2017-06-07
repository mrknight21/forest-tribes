<%@ page import="Utility.SecurityUtility" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.awt.*" %>
<%@ page import="User.UserDAO" %>
<%@ page import="User.User" %>
<%@ page import="Utility.MySQL" %><%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 6/06/2017
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile_Image Update</title>
</head>
<body>


<%
    if(!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/login_interface/Login.jsp");
    HttpSession session1 = request.getSession();
    String username = (String) session1.getAttribute("username");

    MySQL DB = new MySQL();
    User user = UserDAO.getUser(DB, username);
    String imagePaTH = user.getProfileImagePath();

%>

<%@include file="../Header.jsp"%>

<h1><%=username%></h1>
<div id="curret_Image">
    <a href="<%=imagePaTH%>"><img src=<%=imagePaTH%> width="400" height="400"></a>
</div>
<p>Free options</p>
<div id="defaultOpions">
    <form id="select_default_options" action="/Serve_UpdateProfilePicture" method="GET">
        <label for="option1"><a href="../default_options/default_options_1.jpg"><img src="../default_options/default_options_1.jpg" width="250" height="250"></a></label>
        <input id="option1" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_1.jpg"/>
        <label for="option2"> <a href="../default_options/default_options_2.jpg"><img src="../default_options/default_options_2.jpg" width="250" height="250"></a></label>
        <input id="option2" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_2.jpg"/>
        <label for="option3"> <a href="../default_options/default_options_3.jpg"><img src="../default_options/default_options_3.jpg" width="250" height="250"></a></label>
        <input id="option3" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_3.jpg"/>
        <label for="option4"> <a href="../default_options/default_options_4.jpg"><img src="../default_options/default_options_4.jpg" width="250" height="250"></a></label>
        <input id="option4" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_4.jpg"/>
        <label for="option5"><a href="../default_options/default_options_5.gif"><img src="../default_options/default_options_5.gif" width="250" height="250"></a></label>
        <input id="option5" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_5.gif"/>
        <p></p>
        <label for="option6"><a href="../default_options/default_options_6.jpg"><img src="../default_options/default_options_6.jpg" width="250" height="250"></a></label>
        <input id="option6" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_6.jpg"/>
        <label for="option7"> <a href="../default_options/default_options_7.jpg"><img src="../default_options/default_options_7.jpg" width="250" height="250"></a></label>
        <input id="option7" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_7.jpg"/>
        <label for="option8"> <a href="../default_options/default_options_8.jpg"><img src="../default_options/default_options_8.jpg" width="250" height="250"></a></label>
        <input id="option8" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_8.jpg"/>
        <label for="option9"><a href="../default_options/default_options_9.jpg"><img src="../default_options/default_options_9.jpg" width="250" height="250"></a></label>
        <input id="option9" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_9.jpg"/>
        <label for="option10"><a href="../default_options/default_options_10.jpg"><img src="../default_options/default_options_10.jpg" width="250" height="250"></a></label>
        <input id="option10" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/default_options_10.jpg"/>
        <p></p>
        <label for="default"><a href="../default_options/Userdefault.jpg"><img src="../default_options/Userdefault.jpg" width="250" height="250"></a></label>
        <input id="default" type="radio"  class= "default_DP_Options" name="DP_option" value="default_options/Userdefault.jpg" checked/>
        <p></p>
        <input type="submit" value="Change the profile picture to selected photo!" >
    </form>
    <p></p>
    <p></p>
    <form id="upload_own_photo" action="/Serve_UpdateProfilePicture" method="post" enctype="multipart/form-data">
        <input type="file" name="pic" accept="image/*">
        <input type="submit">
    </form>
</div>
</body>
</html>
