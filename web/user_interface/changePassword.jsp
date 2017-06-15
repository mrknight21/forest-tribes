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
    <title>Forest Tribes: Change your password</title>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

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

        $(document).ready(function () {
            $("#changePasswordConfirmID").keyup(checkPasswordMatch);
        });
    </script>

    <tags:Style_Change-Password/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div id="mainContainerID" class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-login">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <form action="<%=sitePath%>Serve_Changepassword" method="post" role="form"
                                  style="display: block">
                                <fieldset>
                                    <legend><i class="fa">&#xf044;</i> Change your password:</legend>
                                    <p>${passwordStatus}</p>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password" id="changePasswordCurrentID" name="CurrentPassword"
                                               class="form-control" required
                                               placeholder="Current password" tabindex="1" value=""/>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password" id="changePasswordNewID" name="NewPassword"
                                               class="form-control" required
                                               placeholder="New password" tabindex="2" value=""/>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password" id="changePasswordConfirmID" name="ConfirmPassword"
                                               class="form-control"
                                               placeholder="Confirm password" tabindex="3" value="" required
                                               onchange="checkPasswordMatch();"/>
                                    </div>
                                    <p id="changePasswordMessageID" style="text-align: center; display: none;">The
                                        entered-in
                                        passwords do not match. Please try again.</p>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <input type="submit" name="changeSubmit" id="changePasswordSubmitID"
                                                       tabindex="4"
                                                       class="btn btn-block btn-success" value="Change your password">
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                            <div class="row">
                                <div class="col-lg-12">
                                    <a id="cancelLink" href="<%=sitePath%>user_interface/Home.jsp"><p style="text-align: center"><i
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