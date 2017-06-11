<%@ page import="Utility.SecurityUtility" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 10/06/2017
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
  Article(int id, String author, String title, String text, String shortIntro, List<Comment> comments,  int likes, int view, String dateCreated, String dateLastEdited)



  protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");%>
<html>
<head>
    <title>display Full article</title>
    <%@include file="../WEB-INF/head-scripts.jsp"%>
</head>
<body>
<%@ include file="../WEB-INF/header-navbar.jsp" %>

<div class="article container">
<h1>${article.title}</h1>
<h2>Author: ${article.author}                                      likes:${article.likes}  views:${article.views} replies:${article.commentCount}   last edited: ${article.dateLastEdited}</h2>
    <div id="content">
        <p>${article.text}</p>
    </div>
<c:if test = "${article.commentCount != 0 }">
<c:forEach var="comment" items="${article.comments}">
    <h2>Comment: </h2>
<div class="comment container">
    <h3>         user: ${comment.author}       likes:${comment.likes} views:${comment.views} replies:${comment.replyCount} last edited: ${comment.dateLastEdited}</h3>
    <div class="comment content">
        <p>${comment.text}</p>
    </div>
    <c:if test = "${comment.replyCount != 0 }">
    <c:forEach var="reply" items="${comment.replies}">
        <h2>Reply: </h2>
        <h4>                   user: ${reply.author}             likes:${reply.likes} views:${reply.views} last edited: ${article.dateLastEdited}</h4>
        <div class="reply content">
            <p>${reply.text}</p>
        </div>
    </c:forEach>
    </c:if>
</div>
</c:forEach>
    </c:if>
</div>
</body>
</html>
