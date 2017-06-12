<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Article.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="Article.Article" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");%>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Display all articles</title>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <style>
        .panel-footer p {
            padding-right: 1%;
        }

        .full {
            background: url('<%=sitePath%>login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }

        #displayMainPanelID {
            margin-top: 2%;
        }

        .panel-heading {
            padding-bottom: 0;
        }

        #displayMainPanelBodyID {
            padding-top: 0;
        }

        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
        }

        #displayMainTitleID {
            font-family: Futura;
        }

        h4 {
            font-family: Futura;
            color: white;
        }

        .panel-default > .panel-heading {
            background-color: #029f5b;
            border-color: #029f5b;
        }
    </style>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    List<Article> articles = ArticleDAO.getAllArticles(DB);
    request.setAttribute("articles", articles);

    /*ID INT AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  title VARCHAR(80) NOT NULL,
  content TEXT NOT NULL,
  likes INT,
  views INT,
  commentCount INT,
  shortIntro VARCHAR(120),
  creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lastEdit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,*/
%>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div id="displayMainPanelID" class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-12">
                            <fieldset>
                              <legend id="displayMainTitleID">Articles:</legend>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div id="displayMainPanelBodyID" class="panel-body">
                    <div class="row">
                        <c:forEach items="${articles}" var="article">
                            <!--Article panel-->
                            <div class="col-lg-12">
                                <div class="panel panel-default" id="displayArticlePanelID">
                                    <div class="panel-heading">
                                        <h4>${article.title}</h4>
                                    </div>
                                    <div class="panel-body">
                                        <p><em>${article.shortIntro}</em></p>
                                    </div>
                                    <div class="panel-footer">
                                        <p style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                            Author: ${article.author}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf097;</i> Article
                                            ID: ${article.id}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf087;</i>
                                            Likes: ${article.likes}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf0c0;</i>
                                            Views: ${article.views}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf112;</i>
                                            Replies: ${article.commentCount}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf044;</i> Last
                                            Edited: ${article.dateLastEdited}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>