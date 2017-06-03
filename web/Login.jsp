<%@ page import="ictgradschool.ex05.Server_Utility" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<% if(Server_Utility.loggingStatusChecker(request)) response.sendRedirect("/ex05/Content.jsp"); %>

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
</body>
</html>

<!--
Destination = authentification
parameter:
"loginUsername"
"loginPassword"

Destination = Registration

