<%@ page import="User.UserSecurity" %>
<%@ page import="Utility.SecurityUtility" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Home</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%@include file="../WEB-INF/Mapviewer.jsp" %>

    <%--Page Specific CSS--%>
    <tags:Style_Reaction-Editor/>
    <script>
        $(document).ready(function () {
        $("#secret").click(function (event){
            $(this).css("display","none");
            $("#myiframe").contents().find(".trees").attr("src","<%=sitePath%>tree_TRIAL/Tree_Material/Venusaur_stage_4.png")
        })

        });

    </script>
</head>
<body>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-login">
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h3><i class="fa">&#xf1bb;</i> The Forest Map:</h3>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="z-index: 999">
                        <div class="row">
                            <div class="col-lg-12">
                                <fieldset>
                                <legend>Background Selector: <img id="secret" src="<%=sitePath%>tree_TRIAL/Tree_Material/Secret_Star_Icon.png" width="15px" height="15" style="float: right;"></legend>
                                    <select name="background" id="background_selector" style="margin-bottom: 1%">
                                        <option value="background_Mars.jpg">Mars</option>
                                        <option value="background_Schizophrenic.jpg">Schizophrenic</option>
                                        <option value="background_GreenMozaic.jpg">Green Mozaic</option>
                                        <option value="background_Brick.jpg">Brick</option>
                                    </select>
                                    <br>
                                    <legend>Zoom Control:</legend>
                                    <div class="slider" id="zoom-control"></div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <div id="iframe_container">
                        <div id="loader"><img src="<%=sitePath%>tree_TRIAL/Tree_Material/tree-leaf-gif.gif"></div>
                        <iframe onload="StopLoader()" id="myiframe" name="iframe_a"
                                src="<%=sitePath%>tree_TRIAL/ForestTribe.jsp" frameborder=0 width="100%" height="900px"
                                scrolling="auto">
                            <p>Your browser does not support iframes.</p>
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>


<!--

Todo: Add panel for articles (like the bootstrap web portfolio)


Input: login page, login servelet, regits page,
Session parameter: login, username

steps:
1. checkingLoginStatus
2. showing username.
3. options:
Logout( redirect to logOutpage.jsp)
ChangePassword (changingpassword.jsp)

-->