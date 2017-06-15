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

<%
    final MySQL DB = new MySQL();
    int articleId = Integer.parseInt(request.getParameter("articleId"));
    Article article = ArticleDAO.getArticleById(DB, articleId);

    Boolean deletionRights = false;
    if (article.getAuthor().equals(username)) deletionRights = true;
    else ArticleDAO.increaseViews(DB, articleId);

    request.setAttribute("username", username);
    request.setAttribute("deletionRights", deletionRights);
    request.setAttribute("article", article);
%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: ${article.title}</title>

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

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-login">
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
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
                    <div class="panel-footer" style="padding-bottom: 0">
                        <div class="row">
                            <div class="col-lg-12">
                                <a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp?author=${article.author}" style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                    Author: ${article.author}</a>
                                <p style="display: inline-block"><i class="fa">&#xf0c0;</i>
                                    Views: ${article.views}</p>
                                <a href="#" onclick="revealComments()" style="display: inline-block"><i class="fa">&#xf112;</i>
                                    Responses: ${article.responseCount}</a>
                                <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                    Edited: ${article.dateLastEdited}</p>
                                <%if (deletionRights) {%>
                                <div class="row" style="background-color: #f5f5f5">
                                    <a class="btn btn-primary"
                                       style="display:inline-block; float: left; width: 48%; margin: 1%"
                                       href="<%=sitePath%>article_display/EditArticle.jsp?articleId=<%=articleId%>">Edit
                                        Article</a>
                                    <form action="<%=sitePath%>TextUpdate" method="post"
                                          style="display: inline-block; float: right; width: 48%; margin: 1%">
                                        <input type="radio" name="id" value="<%=articleId%>" checked hidden/>
                                        <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>
                                        <input type="submit" class="btn btn-danger" name="deleteArticle"
                                               value="Delete Article" style="width: 100%;"/>
                                    </form>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>

                <%--Add JS to make Comment box to appear on click--%>
                <div id="commentDivID" class="panel panel-default">

                    <form action="<%=sitePath%>TextUpdate" method="post">
                        <%--parentId--%>
                        <input type="radio" name="parentId" value="<%=articleId%>" checked hidden/>
                        <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>

                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <textarea style="width: inherit" rows="3" name="text"
                                              placeholder="Share your thoughts" required></textarea>
                                    <input type="submit" name="createComment"
                                           class="btn btn-block btn-success"
                                           value="Submit Comment"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <%----%>

                <div id="commentsDivID" class="panel panel-default" style="border: none">
                    <c:if test="${article.responseCount != 0 }">
                        <c:forEach var="comment" items="${article.comments}">
                            <div class="panel panel-default" style="margin-left: 2%; border-color: #00AA8D">
                                <div class="panel-heading" style="background-color: #00AA8D">
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
                                            <a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp?author=${comment.author}"  style="display: inline-block"><i class="fa">&#xf2bd;</i>
                                                User: ${comment.author}</a>
                                            <p style="display: inline-block"><i class="fa">&#xf087;</i>
                                                Likes: ${comment.likes}</p>
                                            <a href="#" onclick="revealReplies${comment.id}()"
                                               style="display: inline-block"><i class="fa">&#xf112;</i>
                                                Replies: ${comment.replyCount}</a>
                                            <p style="display: inline-block"><i class="fa">&#xf044;</i>
                                                Edited: ${comment.dateLastEdited}</p>
                                            <div class="row">
                                                <c:if test="${username.equals(comment.author)}">
                                                    <form action="<%=sitePath%>TextUpdate" method="post"
                                                          style="display: inline-block; float: left; width: 48%; margin: 1%">
                                                        <input type="radio" name="articleId" value="<%=articleId%>"
                                                               checked
                                                               hidden/>
                                                        <input type="radio" name="id" value="${comment.id}" checked
                                                               hidden/>
                                                        <input type="submit" class="btn btn-primary"
                                                               name="updateComment" value="Edit Comment"
                                                               style="width: 100%"/>
                                                    </form>
                                                </c:if>
                                                <c:if test="${deletionRights || username.equals(comment.author)}">
                                                    <form action="<%=sitePath%>TextUpdate" method="post"
                                                          style="display: inline-block; float: right; width: 48%; margin: 1%">
                                                        <input type="radio" name="articleId" value="<%=articleId%>"
                                                               checked
                                                               hidden/>
                                                        <input type="radio" name="id" value="${comment.id}" checked
                                                               hidden/>
                                                        <input type="submit" class="btn btn-danger"
                                                               name="deleteComment" value="Delete Comment"
                                                               style="width: 100%"/>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <script>
                                    function revealReplies${comment.id}() {
                                        $("#replyDivID${comment.id}").toggle();
                                    }
                                </script>

                                <div id="replyDivID${comment.id}" class="panel-body"
                                     style="padding: 0; display: none; border: none">

                                        <%--Add JS to make Reply box to appear on click--%>
                                    <form action="<%=sitePath%>TextUpdate" method="post" style="margin-bottom: 2%">
                                            <%--parentId--%>
                                        <input type="radio" name="parentId" value="${comment.id}" checked hidden/>
                                        <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>

                                        <div class="panel-footer">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <textarea style="width: inherit" rows="3" cols="100" name="text"
                                                              placeholder="Share your thoughts" required></textarea>
                                                    <input type="submit" name="createReply"
                                                           class="btn btn-block btn-success"
                                                           value="Submit Reply"/>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                        <%----%>


                                    <c:if test="${comment.replyCount != 0 }">
                                        <c:forEach var="reply" items="${comment.replies}">
                                            <div class="panel panel-default"
                                                 style="margin-left: 4%; margin-right: 2%; border-color: #00BF9A">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <p>Reply: ${reply.text}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-footer" style="background-color: #00BF9A;
                                                                                 border-color: #00BF9A">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp?author=${reply.author}" style="display: inline-block; color: white"><i
                                                                    class="fa">&#xf2bd;</i>
                                                                User: ${reply.author}</a>
                                                            <p style="display: inline-block; color: white"><i
                                                                    class="fa">&#xf087;</i>
                                                                Likes: ${reply.likes}</p>
                                                            <p style="display: inline-block; color: white"><i
                                                                    class="fa">&#xf044;</i>
                                                                Last
                                                                Edited: ${reply.dateLastEdited}</p>
                                                            <div class="row">
                                                                <c:if test="${username.equals(reply.author)}">
                                                                    <form action="<%=sitePath%>TextUpdate"
                                                                          method="post" style="display: inline-block; float: left; width: 48%; margin: 1%">
                                                                        <input type="radio" name="articleId"
                                                                               value="<%=articleId%>"
                                                                               checked hidden/>
                                                                        <input type="radio" name="id"
                                                                               value="${reply.id}"
                                                                               checked
                                                                               hidden/>
                                                                        <input type="submit"
                                                                               class="btn btn-primary"
                                                                               name="updateReply" value="Edit Reply" style="width: 100%"/>
                                                                    </form>
                                                                </c:if>
                                                                <c:if test="${deletionRights || username.equals(reply.author)}">
                                                                    <form action="<%=sitePath%>TextUpdate"
                                                                          method="post" style="display: inline-block; float: right; width: 48%; margin: 1%">
                                                                        <input type="radio" name="articleId"
                                                                               value="<%=articleId%>"
                                                                               checked hidden/>
                                                                        <input type="radio" name="id"
                                                                               value="${reply.id}"
                                                                               checked
                                                                               hidden/>
                                                                        <input type="submit"
                                                                               class="btn btn-danger"
                                                                               name="deleteReply" value="Delete Reply" style="width: 100%"/>
                                                                    </form>
                                                                </c:if>
                                                            </div>
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
