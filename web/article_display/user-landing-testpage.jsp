<%--
  Created by IntelliJ IDEA.
  User: wasia
  Date: 4/06/2017
  Time: 1:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Article list</title>

    <style type="text/css">
        body > div > div {
            padding-top: 15px
        }

        .img-circle{
            margin-bottom: 15px;
        }

        .profile{
            margin-bottom: 0.9em;
        }
    </style>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.2.0.js" integrity="sha256-wPFJNIFlVY49B+CuAIrDr932XSb6Jk3J1M22M3E2ylQ=" crossorigin="anonymous"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">

    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
</head>
<body>
<!--Navigation bar-->
<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Question 3</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li><a href="https://www.auckland.ac.nz/">Auckland University</a></li>
                <li><a href="http://www.waikato.ac.nz/">Waikato University</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <!--Profile pane-->
    <div class="col-sm-12 col-md-3 panel panel-default">
        <img class="img-circle" src="../question2/images/queenstown8135665.jpg" style="width: 100%">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Profile</h3>
            </div>
            <div class="profile">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Full Name
            </div>
            <div class="profile"><!--panel-body-->
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Location
            </div>
        </div>
    </div>

    <!--Article panel-->
    <%@include file="articles-list.jsp"%>

</div>
</body>
</html>
