<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="Utility.SecurityUtility" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Change password</title>
    <%@include file="../WEB-INF/head-scripts.jsp"%>

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

    <tags:change-password-style/>
</head>
<body>

<%@ include file="../WEB-INF/header-navbar.jsp" %>

<div id="mainContainerID" class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-login">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <h4 style="text-align: center">The Beauty of Interconnectedness</h4>
                            <form action="<%=sitePath%>Serve_Changepassword" method="post" role="form" style="display: block">
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
                                    <a id="cancelLink" href="<%=sitePath%>Home.jsp"><p style="text-align: center"><i
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