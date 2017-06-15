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
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: All articles</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <script>
        function revealArticle(id) {
            var search = id.search(/\d/);
            var idNumber = id.substring(search);

            var introTextID = "#displayIntroTextID" + idNumber;
            var fullTextID = "#displayFullTextID" + idNumber;
            var linkID = "#displayArticleLinkID" + idNumber;

            $(fullTextID).delay(100).fadeIn(100);
            $(introTextID).fadeOut(100);
            $(linkID).hide();
        }
    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Display-All-Articles/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    List<Article> articles = ArticleDAO.getAllArticles(DB);
    request.setAttribute("articles", articles);
%>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div id="displayMainPanelID" class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-12">
                            <fieldset>
                                <legend id="displayMainTitleID">All Articles:</legend>
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
                                        <a href="DisplayFullArticle.jsp?articleId=${article.id}">
                                            <h4>${article.title}</h4></a>
                                    </div>
                                    <div class="panel-body" id="displayArticlePanelBodyID">
                                        <p id="displayIntroTextID${article.id}"><em>${article.shortIntro}</em></p>
                                        <div id="displayFullTextID${article.id}" style="display: none">${article.text}</div>
                                        <a id="displayArticleLinkID${article.id}" href="#"
                                           onclick="revealArticle(this.id)">Reveal full article</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp?author=${article.author}" style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                            Author: ${article.author}</a>
                                        <p style="display: inline-block"><i class="fa">&#xf0c0;</i>
                                            Views: ${article.views}</p>
                                        <p style="display: inline-block"><i class="fa">&#xf112;</i>
                                            Replies: ${article.responseCount}</p>
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