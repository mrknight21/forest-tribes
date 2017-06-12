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
    <title>Display all Articles</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

 <tags:Style_Display-All-User-Articles/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    List<Article> articles = ArticleDAO.getArticlesByUser(DB, username);
    request.setAttribute("articles", articles);
  %>

<h1>ALL ARTICLES!!!!!</h1>

<div class="container">
    <c:forEach items="${articles}" var="article">
        <!--Article panel-->
        <div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
            <div class="panel panel-default" id="article">

                <div class="panel-heading">
                    <form action="DisplayFullArticle.jsp">
                        <label for="fullarticle-${article.id}">
                            <a href="DisplayFullArticle.jsp?article_id=${article.id}"><h4>${article.title}</h4></a>
                        </label>
                        <input type="text" value="${article.id}" name="article_id" readonly hidden/>
                        <input type="submit"
                               id="fullarticle-${article.id}"
                               hidden
                        />
                    </form>
                </div>

                <div class="panel-body">
                    <h3>${article.shortIntro}</h3>

                    <div class="article_content">
                        <p>
                            Author: ${article.author} article id: ${article.id} likes: ${article.likes}
                            views: ${article.views}
                            Replies: ${article.commentCount} last time edited: ${article.dateLastEdited}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
