<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Tree.InfoTree" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Tree Info</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Page Specific CSS--%>
    <tags:Style_Full-Tree/>
    <%
        if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
        String username = (String) session.getAttribute("username");
        request.setAttribute("username", username);

    %>
    <script>
        $(document).ready(function () {
        var username = "<%=username%>";
        var author = "${tree.author}";
        if(username != author){
            $(".URL_Adder").remove();
            $(".URL_editor").remove();
            $(".URL_deleter").remove();
            $(".reaction_deleter").remove();
            $(".reaction_editor").remove();
        }
        });

    </script>
</head>
<body>



<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-login">
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h3>${tree.title}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <img src="<%=sitePath%>tree_TRIAL/Tree_Material/stage_0${tree.stage}.png"
                                     class="img-circle" style="display: block; margin: auto;">
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12">
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf2bd;</i>
                                    Author: ${tree.author}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf073;</i> Created
                                    on: ${tree.dateCreated}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf044;</i> Last
                                    Edited: ${tree.dateLastEdited}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf087;</i>
                                    Likes: ${tree.likes}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf0c0;</i>
                                    Views: ${tree.views}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf06c;</i>
                                    Stage: ${tree.stage}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf148;</i>
                                    Exp: ${tree.exp}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf1bb;</i>
                                    Size: ${tree.size}</p>
                                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf047;</i>
                                    Coordinate: (${tree.coordinX}, ${tree.coordinY})</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Facts:</h4>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <table>
                                    <thead>
                                    <tr>
                                        <th>For:</th>
                                        <th>Against:</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            <ul>
                                                <c:forEach var="URLS" items="${fact_for}">
                                                    <a href="${URLS.URL}">
                                                        <li>${URLS.title}</li>
                                                    </a>
                                                    <form class="URL_editor" id="urlFactEditorForID${URLS.id}"
                                                          action="<%=sitePath%>tree_TRIAL/URL_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="factual" name="type">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="for" name="support">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlFactEditorForID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="URL_deleter" id="urlFactDeleterForID${URLS.id}"
                                                          action="<%=sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="1" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="factual" name="type">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlFactDeleterForID${URLS.id}" value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach var="URLS" items="${fact_against}">
                                                    <a href="${URLS.URL}">
                                                        <li>${URLS.title}</li>
                                                    </a>
                                                    <form class="URL_editor" id="urlFactEditorAgainstID${URLS.id}"
                                                          action="<%= sitePath%>tree_TRIAL/URL_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="factual" name="type">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="against" name="support">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlFactEditorAgainstID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="URL_deleter" id="urlFactDeleterAgainstID${URLS.id}"
                                                          action="<%= sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="1" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="factual" name="type">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlFactDeleterAgainstID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12">
                                <form class="URL_Adder" id="urlFactAdderID${tree.id}" action="<%= sitePath%>tree_TRIAL/URL_editor.jsp"
                                      method="get">
                                    <input type="hidden" value="${tree.id}" name="TreeID">
                                    <input type="hidden" value="factual" name="type">
                                    <input type="hidden" value="add" name="request">
                                    <button type="submit" form="urlFactAdderID${tree.id}" value="Submit"
                                            class="btn btn-block btn-success"><i class="fa">&#xf067;</i> Add
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Commentary:</h4>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <table>
                                    <thead>
                                    <tr>
                                        <th>For:</th>
                                        <th>Against:</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            <ul>
                                                <c:forEach var="URLS" items="${commentary_for}">
                                                    <a href="${URLS.URL}">
                                                        <li>${URLS.title}</li>
                                                    </a>
                                                    <form class="URL_editor" id="urlCommentaryEditorForID${URLS.id}"
                                                          action="<%= sitePath%>tree_TRIAL/URL_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="commentary" name="type">
                                                        <input type="hidden" value="for" name="support">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlCommentaryEditorForID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="URL_deleter" id="urlCommentaryDeleterForID${URLS.id}"
                                                          action="<%= sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="2" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="commentary" name="type">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlCommentaryDeleterForID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach var="URLS" items="${commentary_against}">
                                                    <a href="${URLS.URL}">
                                                        <li>${URLS.title}</li>
                                                    </a>
                                                    <form class="URL_editor" id="urlCommentaryEditorAgainstID${URLS.id}"
                                                          action="<%= sitePath%>tree_TRIAL/URL_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="commentary" name="type">
                                                        <input type="hidden" value="against" name="support">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlCommentaryEditorAgainstID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="URL_deleter" id="urlCommentaryDeleterAgainstID${URLS.id}"
                                                          action="<%= sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${URLS.id}" name="id">
                                                        <input type="hidden" value="2" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="commentary" name="type">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="urlCommentaryDeleterAgainstID${URLS.id}"
                                                                value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-lg-12">
                                <form class="URL_Adder" id="urlCommentaryAdderID${tree.id}" action="<%= sitePath%>tree_TRIAL/URL_editor.jsp"
                                      method="get">
                                    <input type="hidden" value="${tree.id}" name="TreeID">
                                    <input type="hidden" value="commentary" name="type">
                                    <input type="hidden" value="add" name="request">
                                    <button type="submit" form="urlCommentaryAdderID${tree.id}" value="Submit"
                                            class="btn btn-block btn-success"><i class="fa">&#xf067;</i> Add
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Reactions:</h4>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <table>
                                    <thead>
                                    <tr>
                                        <th>For:</th>
                                        <th>Against:</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            <ul>
                                                <c:forEach var="reaction" items="${reaction_for}">
                                                    <li>${reaction.author}: ${reaction.text}</li>
                                                    <c:if test = "${( reaction.author == username) ||( tree.author == username)}">
                                                    <form class="reaction_editor" id="reactionEditorForID${reaction.id}"
                                                          action="<%= sitePath%>tree_TRIAL/Reaction_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${reaction.id}" name="id">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="for" name="support">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="reactionEditorForID${reaction.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="reaction_deleter" id="reactionDeleterForID${reaction.id}"
                                                          action="<%= sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${reaction.id}" name="id">
                                                        <input type="hidden" value="3" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="reactionDeleterForID${reaction.id}"
                                                                value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                </c:if>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach var="reaction" items="${reaction_against}">
                                                    <li>${reaction.author}: ${reaction.text}</li>
                                                    <c:if test = "${(reaction.author == username) ||( tree.author == username)}">
                                                    <form class="reaction_editor" id="reactionEditorAgainstID${reaction.id}"
                                                          action="<%= sitePath%>tree_TRIAL/Reaction_editor.jsp"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${reaction.id}" name="id">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="against" name="support">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="reactionEditorAgainstID${reaction.id}"
                                                                value="Submit"
                                                                class="btn btn-primary"><i class="fa">&#xf044;</i>
                                                            Update
                                                        </button>
                                                    </form>
                                                    <form class="reaction_deleter" id="reactionDeleterAgainstID${reaction.id}"
                                                          action="<%= sitePath%>Serve_DeleteTreeComponents"
                                                          method="get" style="display: inline-block">
                                                        <input type="hidden" value="${reaction.id}" name="id">
                                                        <input type="hidden" value="3" name="deletetype">
                                                        <input type="hidden" value="${tree.id}" name="TreeID">
                                                        <input type="hidden" value="Update" name="request">
                                                        <button type="submit" form="reactionDeleterAgainstID${reaction.id}"
                                                                value="Submit"
                                                                class="btn btn-danger"><i class="fa">&#xf014;</i> Delete
                                                        </button>
                                                    </form>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <form class="Reaction_Adder" id="reactionAdderID${tree.id}"
                                      action="<%= sitePath%>tree_TRIAL/Reaction_editor.jsp" method="get">
                                    <input type="hidden" value="${tree.id}" name="TreeID">
                                    <input type="hidden" value="add" name="request">
                                    <button type="submit" form="reactionAdderID${tree.id}" value="Submit"
                                            class="btn btn-block btn-success"><i class="fa">&#xf067;</i> Add
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
