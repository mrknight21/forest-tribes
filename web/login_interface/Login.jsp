<%@ page import="Utility.SecurityUtility" %>
<!DOCTYPE html>
<html lang="en" class="full">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <style>
        .full {
            background: url('login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }

        .panel {
            margin-top: 50%;
        }

        h2 {
            margin-top: 0px;
            margin-bottom: 10px;
            font-family: 'Plump';
            color: #029f5b;
        }

        h5 {
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
            color: #fff;
            font-size: 14px;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
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
            src: url('../WEB-INF/Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('../WEB-INF/Amperzand.ttf');
        }
    </style>
</head>
<body>

<% if (SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/ex05/Home.jsp"); %>


<div class="container" style="background-color: transparent">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-6">
                            <a href="#" class="active" id="loginFormLink">Login</a>
                        </div>
                        <div class="col-xs-6">
                            <a href="#" id="registrationFormLink">Register</a>
                        </div>
                    </div>
                    <hr>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h2 style="text-align: center">Forest Tribes</h2>
                            <h5 style="text-align: center">The Beauty of Interconnectedness</h5>
                            <form id="loginFormID" action="" method="post" role="form" style="display: block;">
                                <div class="form-group">
                                    <input type="text" name="loginUsername" id="loginUsernameID" tabindex="1"
                                           class="form-control" placeholder="Username" value="">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="loginPassword" id="loginPasswordID" tabindex="2"
                                           class="form-control" placeholder="Password">
                                </div>
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
                            <form id="registrationFormID" action="" method="post" role="form" style="display: none;">
                                <div class="form-group">
                                    <input type="text" name="registrationUsername" id="registrationUsernameID"
                                           tabindex="1" class="form-control" placeholder="Username" value="">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="registrationFirstName" id="registrationFirstNameID"
                                           tabindex="2" class="form-control" placeholder="First Name" value="">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="registrationLastName" id="registrationLastNameID"
                                           tabindex="3" class="form-control" placeholder="Last Name" value="">
                                </div>
                                <div class="form-group">
                                    <input type="email" name="registrationEmail" id="registrationEmailID" tabindex="4"
                                           class="form-control" placeholder="Email" value="">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="registrationPassword" id="registrationPasswordID"
                                           tabindex="5" class="form-control" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="registrationConfirmPassword"
                                           id="registrationConfirmPasswordID" tabindex="6" class="form-control"
                                           placeholder="Confirm Password">
                                </div>
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