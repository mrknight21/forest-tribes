<%@ page import="ictgradschool.ex05.Server_Utility" %>
<%@ page import="ictgradschool.ex05.MySQL" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
</head>
<body>

<% if(Server_Utility.loggingStatusChecker(request)) response.sendRedirect("/ex05/Content.jsp"); %>


<h2>Create an Account</h2>
<p>${registProblem}</p>
<form action="/Serve_Registration" method="post">
    <fieldset>
        <legend>Your User Details</legend>
        <label for="registrationUsernameID">Username:</label>
        <input type="text" id="registrationUsernameID" name="registrationUsername" placeholder="Username"/>
        <br><br>
        <label for="registrationEmailID">Email</label>
        <input type="email" id="registrationEmailID" name="registrationEmail" placeholder="Email"/>
        <br><br>
        <label for="registrationPassword">Password</label>
        <input type="password" id="registrationPassword" name="registrationPassword" placeholder="Password"/>
        <br>
    </fieldset>
    <br>
    <input type="submit" value="Create an Account"/>
    <input type="reset" value="Clear"/>
</form>
<br>
<a href="Login.jsp" ><button>Cancel</button></a>
</body>
</html>


<!--
Output:
Destination: /Serve_Registration
parameter: post
"registrationUsername"
"registrationEmail"
"registrationPassword"


Destination: login page, trigger by "cancel" hyperlink.

Receive:
Cookie: registProblem
potential values: usernameIssue

checker:
ChecknonLogin();
-->