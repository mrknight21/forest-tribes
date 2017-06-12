<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Article.ArticleDAO" %>
<%@ page import="Article.Article" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--Article(int id, String author, String title, String text, String shortIntro, List<Comment> comments,  int likes, int view, String dateCreated, String dateLastEdited)

protected int id;
  protected String author;
  protected String dateCreated;
  protected String dateLastEdited;
  protected int likes;
  protected String text;
  protected int views;--%>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>display Full article</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <tags:Style_Display-Full-Article/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    Article article = ArticleDAO.getArticleById(DB, Integer.parseInt(request.getParameter("article_id")));
    request.setAttribute("article", article);
%>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-12">
                            <h4>${article.title}</h4>
                        </div>
                    </div>
                </div>
                <div class="panel-body" id="content">
                    <div class="row">
                        <div class="col-lg-12">
                            <p>${article.text}</p>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="col-lg-12">
                            <p style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                Author: ${article.author}</p>
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
            </div>
            <c:if test="${article.commentCount != 0 }">
                <c:forEach var="comment" items="${article.comments}">
                    <h2>Comment: </h2>
                    <div class="comment container">
                        <h3> user: ${comment.author} likes:${comment.likes} views:${comment.views}
                            replies:${comment.replyCount}
                            last edited: ${comment.dateLastEdited}</h3>
                        <div class="comment content">
                            <p>${comment.text}</p>
                        </div>
                        <c:if test="${comment.replyCount != 0 }">
                            <c:forEach var="reply" items="${comment.replies}">
                                <h2>Reply: </h2>
                                <h4> user: ${reply.author} likes:${reply.likes} views:${reply.views} last
                                    edited: ${article.dateLastEdited}</h4>
                                <div class="reply content">
                                    <p>${reply.text}</p>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
