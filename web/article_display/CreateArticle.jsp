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
    <title>Forest Tribes: Create your article</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Importing Quill RTE libraries--%>
    <script src="https://cdn.quilljs.com/1.2.6/quill.min.js" type="text/javascript"></script>

    <link href="https://cdn.quilljs.com/1.2.6/quill.snow.css" rel="stylesheet">

  <tags:Style_Create-Article/>
</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-login">
                <fieldset>
                    <legend>Create your article:</legend>
                </fieldset>
                <form id="articleFormID" action="<%= sitePath%>TextUpdate" method="post">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <h5>Article Title: </h5>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <input class="form-control" id="articleTitleInputID" name="title"
                                               type="text" value="" placeholder="Enter your article title here" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <h5>Article Summary: </h5>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <input class="form-control" id="articleTitleSummaryID" name="summary"
                                               type="text" value="" placeholder="Enter your article summary here" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <h5>Article Content: </h5>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="padding-top: 0">
                            <div class="row">
                                <div class="col-lg-12" style="padding: 0">
                                    <div class="form-group">
                                        <input id="articleContentInputID" name="text" type="hidden" required>
                                        <div id="editor-container" style="height:375px"></div>
                                        <div class="col-lg-12">
                                            <input type="submit" class="btn btn-block btn-success" name="createArticle" id="createArticleSubmitID" value="Publish your article" disabled style="margin-top: 2%">
                                        </div>
                                    </div>
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
                ['link', 'blockquote', 'code-block', 'image'],
                [{list: 'ordered'}, {list: 'bullet'}]
            ]
        },
        placeholder: 'Compose your article here',
        theme: 'snow'
    });

    quill.once("text-change", function(delta, oldDelta, source){
        $("#createArticleSubmitID").prop('disabled', false);
    });

    quill.on("text-change", function(delta, oldDelta, source){

        var content = $("#articleContentInputID");

        content.val(quill.root.innerHTML);

    });
</script>

</body>
</html>

<%--<form action="<%=sitePath%>TextUpdate" method="post">--%>

<%--<div class="panel-heading">--%>
<%--<div class="row">--%>
<%--<div class="col-lg-12">--%>
<%--<h4>--%>
<%--<textarea rows="2" cols="75" name="title"></textarea>--%>
<%--</h4>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>


<%--<div class="panel-body" id="content">--%>
<%--<div class="row">--%>
<%--<div class="col-lg-12">--%>
<%--<div id="editor-container" style="height: 375px">--%>
<%--<p>Hello World!</p>--%>
<%--<p>Some initial <strong>bold</strong> text</p>--%>
<%--<p><br></p>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<%--<div class="panel-footer">--%>
<%--<div class="row">--%>
<%--<div class="col-lg-12">--%>
<%--<p style="display: inline-block"><i class="fa">&#xf112;</i>--%>
<%--<input type="submit" name="createArticle" value="Publish Article"/>--%>
<%--</p>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<%--</form>--%>