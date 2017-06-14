<%--todo connect TPA login with servlet login & registration--%>

<%@ page import="Utility.SecurityUtility" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Login</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Google Library--%>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id"
          content="528062179592-r23sffi9bm4tnntec1e6eei3s1oot0k9.apps.googleusercontent.com">

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

<%--//FB login:--%>
<%--//////////////////////////////////////////////////////////////////////--%>
<script>
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook.
            testAPI();
        } else {
            // The person is not logged into your app or we are unable to tell.
            document.getElementById('status').innerHTML = 'Please log ' +
                'into this app.';
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function () {
        FB.init({
            appId: '1228095957317856',
            cookie: true,  // enable cookies to allow the server to access
                           // the session
            xfbml: true,  // parse social plugins on this page
            version: 'v2.8' // use graph api version 2.8
        });

        // Now that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your app or not.
        //
        // These three cases are handled in the callback function.

        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });

    };

    // Load the SDK asynchronously
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function (response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name + '!';
        });
    }
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<%--//////////////////////////////////////////////////////////////--%>

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
                                <div id="thirdPartyLoginDivID" class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                <div id="status">
                                                    <%--FB Login button:--%>
                                                    <fb:login-button scope="public_profile,email"
                                                                     onlogin="checkLoginState();">
                                                    </fb:login-button>
                                                </div>
                                                <%--Google signin button--%>
                                                <div id="loginGoogle" class="g-signin2" data-onsuccess="onSignIn"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br>
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
                            <form id="registrationFormID" action="<%=sitePath%>Serve_Registration" method="post" role="form"
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