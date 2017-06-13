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

<%--
    final MySQL DB = new MySQL();
    Article article = ArticleDAO.getArticleById(DB, Integer.parseInt(request.getParameter("article_id")));
    request.setAttribute("article", article);
--%>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">

            <div class="panel panel-default">

                <form action="<%=sitePath%>TextUpdate" method="post">

                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>
                                    <textarea rows="2" cols="75" name="title"></textarea>
                                </h4>
                            </div>
                        </div>
                    </div>


                    <div class="panel-body" id="content">
                        <div class="row">
                            <div class="col-lg-12">
                                <p>
                                    <textarea rows="10" cols="75" name="text"></textarea>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12">
                                <p style="display: inline-block"><i class="fa">&#xf112;</i>
                                    <input type="submit" name="createArticle" value="Publish Article"/>
                                </p>
                            </div>
                        </div>
                    </div>

                </form>

            </div>

        </div>
    </div>
</div>
</body>
</html>
