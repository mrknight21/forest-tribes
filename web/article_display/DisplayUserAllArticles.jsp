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
<html>
<head>
    <title>Display all articles</title>
</head>
<body>

<% if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/login_interface/Login.jsp");

    final MySQL DB = new MySQL();

    HttpSession httpSession = request.getSession();
    String username = (String) httpSession.getAttribute("username");

    List<Article> articles = ArticleDAO.getArticlesByUser(DB, username);



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


<%

    for (Article arcticle: articles){
    int id = arcticle.getId();
    String author = arcticle.getAuthor();
    String title = arcticle.getTitle();
    String content = arcticle.getText();
    int likes = arcticle.getLikes();
    int views = arcticle.getViews();
    int replieNum = arcticle.getCommentCount();
    String intro = arcticle.getShortIntro();
    String lastedit = arcticle.getDateLastEdited();
%>
<div class="articleContainers">
    <h2><%=title%></h2>
    <h3>Author: <%=author%>  article id: <%=id%>  likes: <%=likes%>  views: <%=views%> Replies: <%=replieNum%>  last time edited: <%=lastedit%></h3>
    <div class="article_content">
        <p><%=intro%></p>
    </div>
</div>
<%}%>

</body>
</html>
