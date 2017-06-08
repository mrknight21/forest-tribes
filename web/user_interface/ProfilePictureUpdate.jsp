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

    <%--JQuery JavaScript--%>
    <script
            src="https://code.jquery.com/jquery-3.2.1.js"
            integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
            crossorigin="anonymous"></script>

    <%--Bootstrap CSS--%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <%--Bootstrap JavaScript--%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <%--JQuery UI CSS--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <%--JQuery UI JavaScript--%>
    <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous"></script>

    <%--Icons CSS--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        @font-face {
            font-family: Plump;
            src: url('../Fonts/Plumpfull.ttf');
        }

        #headerUser, #headerHome, #headerCollection {
            font-family: Plump;
            color: white;
        }

        .container-fluid {
            background-color: #029f5b;
        }

        .navbar-default .navbar-nav > .open > a, .navbar-default .navbar-nav > .open > a:focus, .navbar-default .navbar-nav > .open > a:hover {
            background-color: #029f5b;
        }

        .navbar-default .navbar-toggle:focus, .navbar-default .navbar-toggle:hover {
            background-color: white;
        }

        .navbar-default {
            margin-bottom: 0;
        }

        .navbar-default .navbar-toggle {
            border-color: white;
            background-color: white;
        }

        .navbar-default .navbar-toggle .icon-bar {
            background-color: #029f5b;
        }

        #headerSearchSubmit {
            font-family: Plump;
            color: #029f5b;
        }

        #headerThumbnail {
            margin: 3px;
            height: 44px;
        }

        #headerSearchIcon {
            color: #029f5b;
        }
    </style>
</head>
<body>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/login_interface/Login.jsp");
    HttpSession session1 = request.getSession();
    String username = (String) session1.getAttribute("username");

    MySQL DB = new MySQL();
    User user = UserDAO.getUser(DB, username);
    String imagePath = user.getProfileImagePath();

%>

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#headerNavBar" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <img id="headerThumbnail" src="/User/<%= username%>/User_profile_picture_thumb.jpg"
                 class="img-thumbnail" alt="User Profile Picture">
        </div>
        <div class="collapse navbar-collapse" id="headerNavBar">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" id="headerUser" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-user"></i> <%= username%><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Update your account</a></li>
                        <li><a href="#">Change profile picture</a></li>
                        <li><a href="#">Change password</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Logout</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" id="headerCollection" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-picture"></i> Collection Display<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                    </ul>
                </li>
                <li>
                    <a id="headerHome" href="" role="button"><i class="glyphicon glyphicon-tree-conifer"></i> Home</a>
                </li>
            </ul>
            <form class="navbar-form navbar-right">
                <div id="headerSearch" class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button id="headerSearchSubmit" type="submit" class="btn btn-default"><i id="headerSearchIcon" class="glyphicon glyphicon-search"></i> Search</button>
            </form>
        </div>
    </div>
</nav>

<h1><%=username%>
</h1>
<div id="curret_Image">
    <a href="<%=imagePath%>"><img src=<%=imagePath%> width="400" height="400"></a>
</div>
<p>Free options</p>
<div id="defaultOpions">
    <form id="select_default_options" action="/Serve_UpdateProfilePicture" method="GET">
        <label for="option1"><a href="../default_options/default_options_1.jpg"><img
                src="../default_options/default_options_1.jpg" width="250" height="250"></a></label>
        <input id="option1" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_1.jpg"/>
        <label for="option2"> <a href="../default_options/default_options_2.jpg"><img
                src="../default_options/default_options_2.jpg" width="250" height="250"></a></label>
        <input id="option2" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_2.jpg"/>
        <label for="option3"> <a href="../default_options/default_options_3.jpg"><img
                src="../default_options/default_options_3.jpg" width="250" height="250"></a></label>
        <input id="option3" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_3.jpg"/>
        <label for="option4"> <a href="../default_options/default_options_4.jpg"><img
                src="../default_options/default_options_4.jpg" width="250" height="250"></a></label>
        <input id="option4" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_4.jpg"/>
        <label for="option5"><a href="../default_options/default_options_5.gif"><img
                src="../default_options/default_options_5.gif" width="250" height="250"></a></label>
        <input id="option5" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_5.gif"/>
        <p></p>
        <label for="option6"><a href="../default_options/default_options_6.jpg"><img
                src="../default_options/default_options_6.jpg" width="250" height="250"></a></label>
        <input id="option6" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_6.jpg"/>
        <label for="option7"> <a href="../default_options/default_options_7.jpg"><img
                src="../default_options/default_options_7.jpg" width="250" height="250"></a></label>
        <input id="option7" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_7.jpg"/>
        <label for="option8"> <a href="../default_options/default_options_8.jpg"><img
                src="../default_options/default_options_8.jpg" width="250" height="250"></a></label>
        <input id="option8" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_8.jpg"/>
        <label for="option9"><a href="../default_options/default_options_9.jpg"><img
                src="../default_options/default_options_9.jpg" width="250" height="250"></a></label>
        <input id="option9" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_9.jpg"/>
        <label for="option10"><a href="../default_options/default_options_10.jpg"><img
                src="../default_options/default_options_10.jpg" width="250" height="250"></a></label>
        <input id="option10" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/default_options_10.jpg"/>
        <p></p>
        <label for="default"><a href="../default_options/Userdefault.jpg"><img src="../default_options/Userdefault.jpg"
                                                                               width="250" height="250"></a></label>
        <input id="default" type="radio" class="default_DP_Options" name="DP_option"
               value="default_options/Userdefault.jpg" checked/>
        <p></p>
        <input type="submit" value="Change the profile picture to selected photo!">
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
