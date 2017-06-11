<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Article.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="Article.Article" %><%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 8/06/2017
  Time: 3:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");%>
<html>
<head>
    <title>Display all articles</title>
    <%@include file="../WEB-INF/Head_Scripts.jsp"%>
</head>
<body>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    List<Article> articles = ArticleDAO.getArticlesByUser(DB, username);
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

<h1>ALL ARTICLES!!!!!</h1>

<div class="container">
    <c:forEach items="${articles}" var="article">
        <!--Article panel-->
        <div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
            <div class="panel panel-default" id="article">
                <div class="panel-heading">
                    <h2>${article.title}</h2>
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
