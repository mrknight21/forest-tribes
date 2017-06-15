<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="Utility.SecurityUtility" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Plant your tree</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%@include file="../WEB-INF/Mapviewer.jsp"%>

    <script>
        $( function() {
            $("#seed").click(function () {
                console.log("click");
                $("body").css("cursor", "url(\"Tree_Material/sprout_hand.png\"), default");
                $("#myiframe").contents().find("#map").css("cursor", "url(\"Tree_Material/sprout_hand.png\"), default");
                $("#seed").css("display", "none");
                $(this).css("pointer-events", "none");
                $("#myiframe").contents().find("#map").click(function () {

                    var X = $("#myiframe").contents().find("#Y").val();
                    var Y = $("#myiframe").contents().find("#X").val();
                    var Xcoor = X + "px";
                    var Ycoor = Y + "px";
                    $("#myiframe").contents().find("#map").append("<img src='Tree_Material/stage_01.png' id='new_seed' style='-webkit-transform: scale(0.75);-moz-transform: scale(0.75);-ms-transform: scale(0.75);-o-transform: scale(0.75);transform: scale(0.75);'>");
                    $("#myiframe").contents().find("#new_seed").css("top", Ycoor).css("left", Xcoor).css("position", "absolute");
                    $("#Xcoordinate").val(X);
                    $("#Ycoordinate").val(Y);
                    $(this).off("click");
                    $("body").css("cursor", "");
                    $("#myiframe").contents().find("#map").css("cursor", "");
                });
            });

            $("#resetButtonID").click(function () {
                $("#myiframe").contents().find("#new_seed").remove();
                $("#seed").css("display", "initial");
                $("#seed").css("pointer-events", "auto");
            });
        });
    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Reaction-Editor/>
</head>
<body>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-login">
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h3><i class="fa">&#xf06c;</i> Plant your Big Issue:</h3>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form action="<%= sitePath%>Serve_TreeCreation" METHOD="get" id="plantFormID">
                                    <fieldset>
                                        <legend>The Name of your Big Issue:</legend>
                                        <div class="form-group">
                                            <input id="title" type="text" name="title" style="width: 50%" required>
                                        </div>
                                        <legend>Tell use more about it:</legend>
                                        <div class="form-group">
                                            <textarea id="description" name="shortIntro" rows="6"
                                                      cols="80" required></textarea>
                                        </div>
                                        <legend><i class="fa">&#xf245;</i> Click me to plant your tree</legend>
                                        <div class="form-group" id="seed">
                                            <img src="Tree_Material/sprout.png" style="display: block; margin: auto">
                                        </div>
                                        <legend>Coordinates:</legend>
                                        <div class="form-group">
                                            <label for="Xcoordinate">X Position:</label>
                                            <input type="number" value="0" id="Xcoordinate" name="X" readonly>
                                            <label for="Ycoordinate">Y Position:</label>
                                            <input type="number" value="0" id="Ycoordinate" name="Y" readonly>
                                            <button type="submit" form="plantFormID" value="Confirm Location"
                                                    class="btn btn-success" style="display: inline-block">Confirm Location
                                            </button>
                                            <button type="reset" id="resetButtonID" form="plantFormID" value="Reset Location"
                                                    class="btn btn-danger" style="display: inline-block">Reset Location
                                            </button>
                                        </div>
                                        <legend>Zoom Control:</legend>
                                        <div class="form-group" style="position:relative; float: left; z-index: 999">
                                            <div class="slider" id="zoom-control"></div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div id="loader"><img src="<%=sitePath%>tree_TRIAL/Tree_Material/tree-leaf-gif.gif"></div>
                    <iframe class="whole" name="iframe_a" id="myiframe" src="ForestTribe.jsp" frameborder=0
                            height="750px"
                            width="1000px" scrolling="auto" onload="StopLoader()" style="display: block; margin: auto">
                        <p>Your browser does not support iframes.</p>
                    </iframe>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
