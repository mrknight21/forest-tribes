<%@ page import="Utility.SecurityUtility" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Login</title>

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

        /* Smartphones (landscape) ----------- */
        @media only screen
        and (min-width: 321px) {
            .panel {
                margin-right: 0;
                margin-left: 17%;
                width: 70%;
            }

            .container {
                padding: 0;
            }

            #loginHidePanelLink {
                padding-left: 2%;
            }
        }

        /* Smartphones (portrait) ----------- */
        @media only screen
        and (max-width: 320px) {
            .panel {
                margin-top: 10%;
            }

            .col-lg-4 {
                padding-right: 2%;
            }

            #loginHidePanelLink {
                padding-left: 2%;
            }
        }

        @media only screen
        and (min-device-width: 321px)
        and (max-device-width: 420px)
        and (orientation: portrait) {
            .panel {
                margin-top: 30%;
                margin-left: 19%;
            }
        }

        /* iPads (landscape) ----------- */
        @media only screen
        and (min-device-width: 768px)
        and (max-device-width: 1024px)
        and (orientation: landscape) {
            .panel {
                margin-top: 12%;
            }
        }

        /* iPads (portrait) ----------- */
        @media only screen
        and (min-device-width: 768px)
        and (max-device-width: 1024px)
        and (orientation: portrait) {
            .panel {
                margin-top: 30%;
            }
        }

        /* Desktops and laptops ----------- */
        @media only screen
        and (min-width: 1224px) {

        }

        /* Large screens ----------- */
        @media only screen
        and (min-width: 1824px) {

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

        .panel-body {
            padding-top: 0px;
        }

        .panel-heading {
            padding-bottom: 0px;
        }

        .btn-login, .btn-register {
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

        .btn-primary.active, .btn-primary.active:hover, .btn-primary.active:focus {
            background-color: transparent;
            border-color: transparent;
            outline: none;
            color: white;
            height: auto;
            font-weight: normal;
            text-decoration: none;

        }

        .btn-primary, .btn-primary:hover, .btn-primary:focus {
            background-color: transparent;
            border-color: transparent;
            outline: none;
            color: white;
            height: auto;
            font-weight: normal;
            text-decoration: none;
        }

        .panel-login > .panel-heading a {
            text-decoration: none;
            color: #029f5b;
            font-weight: bold;
            font-size: 15px;
            -webkit-transition: all 0.1s linear;
            -moz-transition: all 0.1s linear;
            transition: all 0.1s linear;
        }

        .panel-login > .panel-heading a.active {
            color: #029f5b;
            font-size: 18px;
        }

        @font-face {
            font-family: Plump;
            src: url('../Fonts/Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('../Fonts/Amperzand.ttf');
        }

        .input-group {
            margin-bottom: 10px;
        }

        #messageLogin {
            color: red;
        }

        .container {
            width: 100%
        }

        #loginHideRow {
            padding-left: 2%;
            padding-top: 2%;
        }
    </style>
</head>
<body>

<% if (SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/user_interface/Home.jsp"); %>


<div class="container" style="background-color: transparent">
    <div id="loginHideRow" class="row">
        <a href="#" class="active btn-primary" id="loginHidePanelLink"><i class="fa">&#xf03e;</i> Hide login panel</a>
    </div>
    <div class="row">
        <div class="col-lg-4 col-lg-offset-4">
            <div id="loginMainPanel" class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-6">
                            <a href="#" class="active" id="loginFormLink"><i class="fa">&#xf015;</i> Login</a>
                        </div>
                        <div class="col-xs-6">
                            <a href="#" id="registrationFormLink"><i class="fa">&#xf044;</i> Register</a>
                        </div>
                    </div>
                    <hr>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <h4 style="text-align: center">The Beauty of Interconnectedness</h4>
                            <form id="loginFormID" action="/Serve_Authentication" method="post" role="form"
                                  style="display: block;">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" name="loginUsername" id="loginUsernameID" tabindex="1"
                                           class="form-control" placeholder="Username" value="">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" name="loginPassword" id="loginPasswordID" tabindex="2"
                                           class="form-control" placeholder="Password">
                                </div>
                                <p id="messageLogin" style="text-align: center">${message}</p>
                                <div class="form-group text-center">
                                    <input type="checkbox" tabindex="3" class="" name="loginRemember"
                                           id="loginRememberID">
                                    <label for="loginRememberID"> Remember Me</label>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="loginSubmit" id="loginSubmitID" tabindex="4"
                                                   class="form-control btn btn-login" value="Log In">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                <a href="" tabindex="5" class="forgot-password">Forgot Password?</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <form id="registrationFormID" action="/Serve_Registration" method="post" role="form"
                                  style="display: none;">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" name="registrationUsername" id="registrationUsernameID"
                                           tabindex="1" class="form-control" placeholder="Username" value="">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" name="registrationFirstName" id="registrationFirstNameID"
                                           tabindex="2" class="form-control" placeholder="First Name" value="">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" name="registrationLastName" id="registrationLastNameID"
                                           tabindex="3" class="form-control" placeholder="Last Name" value="">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                    <input type="email" name="registrationEmail" id="registrationEmailID" tabindex="4"
                                           class="form-control" placeholder="Email" value="">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" name="registrationPassword" id="registrationPasswordID"
                                           tabindex="5" class="form-control" placeholder="Password">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input type="password" name="registrationConfirmPassword"
                                           id="registrationConfirmPasswordID" tabindex="6" class="form-control"
                                           placeholder="Confirm Password">
                                </div>
                                <p id="messageRegistration" style="text-align: center">${messageRegistration}</p>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="registrationSubmit" id="registrationSubmitID"
                                                   tabindex="7" class="form-control btn btn-register"
                                                   value="Register Now">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $('#loginFormLink').click(function (e) {
            $("#loginFormID").delay(100).fadeIn(100);
            $("#registrationFormID").fadeOut(100);
            $('#registrationFormLink').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
        $('#registrationFormLink').click(function (e) {
            $("#registrationFormID").delay(100).fadeIn(100);
            $("#loginFormID").fadeOut(100);
            $('#loginFormLink').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
        $('#loginHidePanelLink').click(function (e) {
            $("#loginMainPanel").fadeToggle(500);
            $("#loginHidePanelLink").toggleClass("active");
        });
    });
</script>
</body>
</html>

<!--
Destination = authentification
parameter:
"loginUsername"
"loginPassword"

Destination = Registration

<h2>Login</h2>
<p id="message">${loginProb}</p>
<form action="/Serve_Authentication" method="post">
<fieldset>
<legend>Your Login Details</legend>
<label for="loginUsernameID">Username:</label>
<input type="text" id="loginUsernameID" name="loginUsername" placeholder="Username"/>
<br><br>
<label for="loginPasswordID">Password:</label>
<input type="password" id="loginPasswordID" name="loginPassword" placeholder="Password"/>
</fieldset>
<br>
<input type="submit" value="Login">
<input type="reset" value="Clear">
</form>
<br>
<a href="Registration.jsp">Create an Account</a>