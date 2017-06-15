<%@ page import="Utility.SecurityUtility" %>
<% if (SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../user_interface/Home.jsp"); %>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Login</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Page Specific CSS--%>
    <tags:Style_Login/>

    <script>
        function checkPasswordMatch() {
            var password = $("#registrationPasswordID").val();
            var passwordConfirm = $("#registrationConfirmPasswordID").val();

            if (password !== passwordConfirm) {
                $("#registrationSubmitID").prop('disabled', true);
                $("#registrationMessageID").show();
            } else {
                $("#registrationSubmitID").prop('disabled', false);
                $("#registrationMessageID").hide();
            }
        }

        $(document).ready(function () {
            $("#registrationConfirmPasswordID").keyup(checkPasswordMatch);
        });
    </script>
</head>
<body>

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
                            <form id="loginFormID" action="<%=sitePath%>Serve_Authentication" method="post" role="form"
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
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="loginSubmit" id="loginSubmitID" tabindex="4"
                                                   class="form-control btn btn-login" value="Log In">
                                        </div>
                                    </div>
                                </div>
                                <div id="thirdPartyLoginDivID" class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                <%--Google signin button--%>
                                                <div id="loginGoogle" class="g-signin2" data-onsuccess="onSignIn"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <form id="registrationFormID" action="<%=sitePath%>Serve_Registration" method="post"
                                  role="form"
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
                                           placeholder="Confirm Password" onchange="checkPasswordMatch();">
                                </div>
                                <p id="registrationMessageID" style="text-align: center; display: none;">The entered-in
                                    passwords do not match. Please try again.</p>
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
    // Google API
    function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);

        // Pass ID token to backend:
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '<%=sitePath%>TokenSignIn');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            console.log('Signed in as: ' + xhr.responseText);
            if (xhr.responseText != null) window.open("<%=sitePath%>user_interface/Home.jsp", "_self");
        };
        xhr.send('idtoken=' + id_token);
    };
</script>

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