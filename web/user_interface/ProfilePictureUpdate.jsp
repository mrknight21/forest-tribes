<%@ page import="Utility.SecurityUtility" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.awt.*" %>
<%@ page import="User.UserDAO" %>
<%@ page import="User.User" %>
<%@ page import="Utility.MySQL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Profile_Image Update</title>

    <%--JQuery JavaScript--%>
    <script src="https://code.jquery.com/jquery-3.2.1.js"
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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous"></script>

    <%--Icons CSS--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <%--Function to enable JQuery UI elements--%>
    <script>
        $(function () {
            $("input[type='radio']").checkboxradio();
        });
    </script>

    <style>
        .full {
            background: url('../login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }

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
            border-color: #029f5b;
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
            width: 44px;
        }

        #headerSearchIcon {
            color: #029f5b;
        }

        legend {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 1.42857143;
            color: #333;
            font-weight: 700;
        }

        #userImageID {
            display: block;
            margin: auto;
            width: 250px;
        }

        .img-thumbnail {
            height: 140px;
            width: 140px;
            border-color: transparent;
        }

        .btn-register {
            background-color: #029f5b;
            outline: none;
            color: white;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
        }

        .form-control[disabled] {
            background-color: #029f5b;
            opacity: 1;
        }

        #pictureChoiceDefaultID {
            padding-right: 0;
            padding-left: 0;
        }

        label.btn.btn-primary {
            width: 180px;
            height: 160px;
        }

        input.btn.btn-primary {
            max-width: 190px;
        }

        label {
            max-width: none;
        }

        .btn-primary {
            color: black;
            background-color: #f6f6f6;
            border: 1px solid #c5c5c5;
        }

        .btn-primary:hover {
            background-color: #ccc;
            border: 1px solid #c5c5c5;;
        }

        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            background-color: #029f5b;
            border-color: #1A9B42;
        }

        .ui-icon-background, .ui-state-active .ui-icon-background {
            border: white;
            background-color: #ffffff;
        }

        .ui-visual-focus {
            box-shadow: none;
        }

        .ui-checkboxradio-radio-label.ui-checkboxradio-checked .ui-icon, .ui-checkboxradio-radio-label.ui-checkboxradio-checked:hover .ui-icon {
            width: 16px;
            height: 16px;
            box-shadow: none;
            background-color: #ccc;
        }

        .panel-login {
            margin-top: 5%;
        }

        .form-group {
            margin-bottom: 0;
        }

        #changePictureUploadDivID {
            padding-left: 15px;
        }

        #changePictureDefaultDivID {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
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
                       aria-expanded="false"><i class="glyphicon glyphicon-user"></i> <%= username%><span
                            class="caret"></span></a>
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
                       aria-expanded="false"><i class="glyphicon glyphicon-picture"></i> Collection Display<span
                            class="caret"></span></a>
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
                <button id="headerSearchSubmit" type="submit" class="btn btn-default"><i id="headerSearchIcon"
                                                                                         class="glyphicon glyphicon-search"></i>
                    Search
                </button>
            </form>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-10 col-lg-offset-1">
                            <fieldset>
                                <legend><i style="font-size:24px" class="fa">&#xf03e;</i> Your Current Profile Picture:
                                </legend>
                                <a href="<%=imagePath%>"><img id="userImageID" src="<%=imagePath%>"
                                                              class="img-rounded"
                                                              alt="User Profile Picture" height="400"></a>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-10 col-lg-offset-1">
                            <form id="select_default_options" action="../Serve_UpdateProfilePicture" method="GET">
                                <fieldset>
                                    <legend id="pictureChoiceDefaultID"><i style="font-size:24px"
                                                                           class="fa">&#xf046;</i> Default Choices:
                                    </legend>
                                    <div class="form-group">
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_1.jpg"><input id="option1"
                                                                                                           type="radio"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_1.jpg"
                                                                                                           autocomplete="off"/><img
                                                    src="../default_options/default_options_1.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_2.jpg"><input id="option2"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_2.jpg"/><img
                                                    src="../default_options/default_options_2.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="../default_options/default_options_3.jpg"><input id="option3"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_3.jpg"/><img
                                                    src="../default_options/default_options_3.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="../default_options/default_options_4.jpg"><input id="option4"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_4.jpg"/><img
                                                    src="../default_options/default_options_4.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_5.gif"><input id="option5"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_5.gif"/><img
                                                    src="../default_options/default_options_5.gif"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_6.jpg"><input id="option6"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_6.jpg"/><img
                                                    src="../default_options/default_options_6.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="../default_options/default_options_7.jpg"><input id="option7"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_7.jpg"/><img
                                                    src="../default_options/default_options_7.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_8.jpg"><input id="option8"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_8.jpg"/><img
                                                    src="../default_options/default_options_8.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_9.jpg"><input id="option9"
                                                                                                           type="radio"
                                                                                                           class="default_DP_Options"
                                                                                                           name="DP_option"
                                                                                                           value="default_options/default_options_9.jpg"/><img
                                                    src="../default_options/default_options_9.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="../default_options/default_options_10.jpg"><input
                                                    id="option10"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_10.jpg"/><img
                                                    src="../default_options/default_options_10.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a href="../default_options/Userdefault.jpg"><input
                                                    id="default"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/Userdefault.jpg"
                                                    checked/><img
                                                    src="../default_options/Userdefault.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                    </div>
                                    <div id="changePictureDefaultDivID" class="col-lg-12">
                                        <input type="submit" name="changePictureDefault"
                                               id="changePictureDefaultSubmitID"
                                               class="form-control btn btn-register"
                                               value="Change profile picture">
                                    </div>
                                </fieldset>
                            </form>
                            <br>
                            <form id="upload_own_photo" action="../Serve_UpdateProfilePicture" method="post"
                                  enctype="multipart/form-data">
                                <fieldset>
                                    <legend><i style="font-size:24px" class="fa">&#xf0ee;</i> Upload your own
                                        Photo:
                                    </legend>
                                    <div id="changePictureUploadDivID" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-file"></i></span>
                                        <input class="btn btn-primary" type="file" name="pic"
                                               accept="image/*">
                                    </div>
                                    <br>
                                    <div class="col-lg-12">
                                        <input type="submit" name="changePictureUpload" id="changePictureUploadSubmitID"
                                               class="form-control btn btn-register"
                                               value="Change profile picture">
                                    </div>
                                </fieldset>
                                <br>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
