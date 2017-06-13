<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Article.ArticleDAO" %>
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
    <title>Display Full Article</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <script>
        function revealComments() {
            $("#commentDivID").toggle();
            $("#commentsDivID").toggle();
        }
    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Display-Full-Article/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    int articleId = Integer.parseInt(request.getParameter("articleId"));
    Article article = ArticleDAO.getArticleById(DB, articleId);

    Boolean deletionRights = false;
    Boolean editRights = false;
    if (article.getAuthor().equals(username))
        deletionRights = true;


//    Add script to increase Article views by one one each load.
    request.setAttribute("article", article);
%>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-login">
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
                                <a href="#" onclick="revealComments()" style="display: inline-block"><i class="fa">&#xf112;</i>
                                    Replies: ${article.responseCount}</a>
                                <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                    Edited: ${article.dateLastEdited}</p>
                                <%if (deletionRights) {%>
                                <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                <form action="<%=sitePath%>TextUpdate" method="post">
                                    <input type="radio" name="id" value="<%=articleId%>" checked hidden/>
                                    <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>
                                    <input type="submit" name="deleteArticle" value="Delete Article"/>
                                </form>
                                </p>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>

                <%--Add JS to make Comment box to appear on click--%>
                <div id="commentDivID" class="panel panel-default" style="display: none">

                    <form action="<%=sitePath%>TextUpdate" method="post">
                        <%--parentId--%>
                        <input type="radio" name="parentId" value="<%=articleId%>" checked hidden/>
                        <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>

                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <textarea style="display: inline-block" rows="3" cols="100" name="text"
                                              placeholder="Share your thoughts"></textarea>
                                    <input style="display: inline-block" type="submit" name="createComment"
                                           class="btn-primary"
                                           value="Submit Comment"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <%----%>

                <div id="commentsDivID" class="panel panel-default" style="display: none">
                    <c:if test="${article.responseCount != 0 }">
                        <c:forEach var="comment" items="${article.comments}">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <img id="headerThumbnail"
                                                 src="<%=sitePath%>User/${comment.author}/User_profile_picture_thumb.jpg"
                                                 class="img-thumbnail" alt="User Profile Picture">
                                            <h5 style="display: inline-block;">${comment.author}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p>${comment.text}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                                User: ${comment.author}</p>
                                            <p style="display: inline-block"><i class="fa">&#xf087;</i>
                                                Likes: ${comment.likes}</p>
                                            <p style="display: inline-block"><i class="fa">&#xf112;</i>
                                                Replies: ${comment.replyCount}</p>
                                            <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                                Edited: ${comment.dateLastEdited}</p>
                                            <%if (deletionRights) {%>
                                            <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                            <form action="<%=sitePath%>TextUpdate" method="post">
                                                <input type="radio" name="articleId" value="<%=articleId%>" checked
                                                       hidden/>
                                                <input type="radio" name="id" value="${comment.id}" checked hidden/>
                                                <input type="submit" name="deleteComment" value="Delete Comment"/>
                                            </form>
                                            </p>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel-body" style="padding: 0">

                                        <%--Add JS to make Reply box to appear on click--%>
                                    <form action="<%=sitePath%>TextUpdate" method="post">
                                            <%--parentId--%>
                                        <input type="radio" name="parentId" value="${comment.id}" checked hidden/>
                                        <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>

                                        <div class="panel-footer">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <p style="display: inline-block"><i class="fa">&#xf112;</i>
                                                        <input type="submit" name="createReply" value="Send reply"/>
                                                        <textarea rows="2" cols="100" name="text"
                                                                  placeholder="Create a reply"></textarea></p>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                        <%----%>


                                    <c:if test="${comment.replyCount != 0 }">
                                        <c:forEach var="reply" items="${comment.replies}">
                                            <div class="panel panel-default" style="display: none">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <p>Reply: ${reply.text}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-footer">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <p style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                                                User: ${reply.author}</p>
                                                            <p style="display: inline-block"><i class="fa">&#xf087;</i>
                                                                Likes: ${reply.likes}</p>
                                                            <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                                                Last
                                                                Edited: ${reply.dateLastEdited}</p>
                                                            <%if (deletionRights) {%>
                                                            <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                                            <form action="<%=sitePath%>TextUpdate" method="post">
                                                                <input type="radio" name="articleId"
                                                                       value="<%=articleId%>"
                                                                       checked hidden/>
                                                                <input type="radio" name="id" value="${reply.id}"
                                                                       checked
                                                                       hidden/>
                                                                <input type="submit" name="deleteReply"
                                                                       value="Delete Reply"/>
                                                            </form>
                                                            </p>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
