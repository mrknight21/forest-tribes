<%@ page import="Utility.SecurityUtility" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Change password</title>

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

    <script>
        function checkPasswordMatch() {
            var password = $("#changePasswordNewID").val();
            var passwordConfirm = $("#changePasswordConfirmID").val();

            if (password !== passwordConfirm) {
                $("#changePasswordSubmitID").prop('disabled', true);
                $("#changePasswordMessageID").show();
            } else {
                $("#changePasswordSubmitID").prop('disabled', false);
                $("#changePasswordMessageID").hide();
            }
        }

        $(document).ready(function (){
           $("#changePasswordConfirmID").keyup(checkPasswordMatch);
        });
    </script>

    <style>
        .full {
            background: url('/login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
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

        @font-face {
            font-family: Amperzand;
            src: url('../Fonts/Amperzand.ttf');
        }

        #headerUser, #headerHome, #headerCollection {
            font-family: Plump;
            color: white;
        }

        #cancelLink {
            font-family: Plump;
            color: red;
        }

        h1 {
            margin-top: 0;
            margin-bottom: 10px;
            font-family: 'Plump';
            color: #029f5b;
        }

        h4 {
            margin-bottom: 10px;
            font-family: 'Amperzand';
        }

        .btn-login {
            background-color: #029f5b;
            outline: none;
            color: white;
            font-size: 14px;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
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
        }

        #headerSearchIcon {
            color: #029f5b;
        }

        .panel {
            margin-top: 20%;
        }

        .input-group {
            margin-bottom: 10px;
        }

        legend {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 1.42857143;
            color: #333;
            font-weight: 700;
        }

        #changePasswordMessageID {
            font-family: Plump;
            color: red;
        }

        .form-control[disabled] {
            background-color: #029f5b;
            opacity: 1;
        }
    </style>
</head>
<body>
<%
    if (!SecurityUtility.loggingStatusChecker(request)) {
        response.sendRedirect("/login_interface/Login.jsp");
    }
    String username = (String) session.getAttribute("username");
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
<div id="mainContainerID" class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-login">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <h4 style="text-align: center">The Beauty of Interconnectedness</h4>
                            <form action="/Serve_Changepassword" method="post" role="form" style="display: block">
                                <legend>Change your password:</legend>
                                <p>${passwordStatus}</p>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" id="changePasswordCurrentID" name="changePasswordCurrent"
                                           class="form-control"
                                           placeholder="Current password" tabindex="1" value=""/>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" id="changePasswordNewID" name="changePasswordNew"
                                           class="form-control"
                                           placeholder="New password" tabindex="2" value=""/>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" id="changePasswordConfirmID" name="changePasswordConfirm"
                                           class="form-control"
                                           placeholder="Confirm password" tabindex="3" value="" onchange="checkPasswordMatch();"/>
                                </div>
                                <p id="changePasswordMessageID" style="text-align: center; display: none;">The entered-in
                                    passwords do not match. Please try again.</p>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="changeSubmit" id="changePasswordSubmitID"
                                                   tabindex="4"
                                                   class="form-control btn btn-login" value="Change your password">
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div class="row">
                                <div class="col-lg-12">
                                    <a id="cancelLink" href="/user_interface/Home.jsp"><p style="text-align: center"><i
                                            class="fa">&#xf00d;</i> Cancel</p></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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