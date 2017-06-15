<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Article.ArticleDAO" %>
<%@ page import="Article.Text" %>
<%@ page import="Article.Comment" %>
<%@ page import="Article.Reply" %>

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
    <title>Forest Tribes: Edit your article</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Importing Quill RTE libraries--%>
    <script src="https://cdn.quilljs.com/1.2.6/quill.min.js" type="text/javascript"></script>

    <link href="https://cdn.quilljs.com/1.2.6/quill.snow.css" rel="stylesheet">

  <tags:Style_Create-Article/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<%
    final MySQL DB = new MySQL();
    int textId = Integer.parseInt(request.getParameter("id"));
    int parentId = -1;
    int articleId = Integer.parseInt(request.getParameter("articleId"));
    String type = "";

    Text reply = new Comment();
    if (request.getParameter("updateComment") != null) {
        reply = ArticleDAO.getCommentById(DB, textId);
        parentId = ((Comment)reply).getParentID();
        type = "Comment";
    }
    else if (request.getParameter("updateReply") != null) {
        reply = ArticleDAO.getReplyById(DB, textId);
        parentId = ((Reply)reply).getParentID();
        type = "Reply";
    }

    if (!reply.getAuthor().equals(username))
        response.sendRedirect("../article_display/DisplayAllArticles.jsp");

//    Add script to increase Article views by one one each load.
    request.setAttribute("text", reply);
%>


<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-login">
                <form id="articleFormID" action="<%= sitePath%>TextUpdate" method="post">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <h5>Amend your ways: </h5>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="padding-top: 0">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="row form-group">
                                        <input id="articleContentInputID" name="text" type="hidden" value="">
                                        <div id="editor-container" style="height:375px">${text.text}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="radio" name="id" value="${text.id}" checked hidden/>
                                    <input type="radio" name="parentId" value="<%=parentId%>" checked hidden/>
                                    <input type="radio" name="articleId" value="<%=articleId%>" checked hidden/>
                                    <input type="submit" class="form-control btn btn-login" name="update<%=type%>" id="updateArticleSubmitID" value="Reform your life" disabled>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    var quill = new Quill('#editor-container', {
        modules: {
            toolbar: [
                ['bold', 'italic'],
                ['link', 'blockquote', 'code-block',],
                [{list: 'ordered'}, {list: 'bullet'}]
            ]
        },
        placeholder: 'Compose your article here',
        theme: 'snow'
    });

    quill.once("text-change", function(delta, oldDelta, source){

        var content = $("#articleContentInputID");

        content.val(quill.root.innerHTML);

        $("#updateArticleSubmitID").prop('disabled', false);
    });

    quill.on("text-change", function(delta, oldDelta, source){

        var content = $("#articleContentInputID");

        content.val(quill.root.innerHTML);
    });


</script>

</body>
</html>