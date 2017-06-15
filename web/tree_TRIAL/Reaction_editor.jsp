<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Tree.TreeDAO" %>
<%@ page import="java.util.function.DoubleBinaryOperator" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Tree.T_URL" %>
<%@ page import="Tree.T_Reaction" %>
<%@ page import="java.util.List" %>
<%@ page import="Article.Reply" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Your reaction</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Function to enable JQuery UI elements--%>
    <script>
        $(function () {
           $("input[type='radio']").checkboxradio();
           $("#stanceRadioID").controlgroup();
        });
    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Reaction-Editor/>
</head>
<body>

<%!private static final MySQL DB = new MySQL();%>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");

    String requestType = request.getParameter("request");

    int TreeID = Integer.parseInt(request.getParameter("TreeID"));
    String text = "";
    boolean support = true;
    String lastEdit = "";
    int reactionID = -1;
    String author = username;
    List<Reply> replies = new ArrayList<>();

    if (requestType.equals("Update")) {
        reactionID = Integer.parseInt(request.getParameter("id"));
        System.out.println(reactionID);
        T_Reaction reaction = TreeDAO.getReactionbyId(DB, reactionID);
        text = reaction.getText();
        lastEdit = reaction.getDateLastEdited();
        support = reaction.isSupportForArgument();
        author = reaction.getAuthor();
        replies = reaction.getReplies();
    }
%>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="panel panel-login">
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h3><%=author%>'s Reaction</h3>

                                <% if (!lastEdit.equals("")) {%>
                                <p style="color: white">Last Edited: <%=lastEdit%>
                                </p>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="padding-bottom: 0">
                        <div class="row">
                            <div class="col-lg-12">
                                <form action="/Serve_TreeReaction" method="get" id="reactionFormID">
                                    <fieldset>
                                        <legend><i class="fa">&#xf24e;</i> For or against the tree ?</legend>
                                        <div class="form-group" id="stanceRadioID">
                                            <label for="forID">For</label>
                                            <input id="forID" type="radio" name="support" value="for"/>
                                            <label for="againstID">Against</label>
                                            <input id="againstID" type="radio" name="support" value="against">
                                        </div>
                                        <legend><i class="fa">&#xf0e5;</i> Have your say:</legend>
                                        <div class="form-group">
                                            <textarea id="description" name="content" rows="7"
                                                      cols="90"><%=text%></textarea required>
                                            <input type="hidden" name="reactionID" value="<%=reactionID%>">
                                            <input type="hidden" name="TreeID" value="<%=TreeID%>">
                                            <input type="hidden" name="repliesNum" value="<%=replies.size()%>">
                                            <button type="submit" form="reactionFormID" value="Submit"
                                                    class="btn btn-block btn-success">Submit
                                            </button>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% if (replies.size() > 0) {%>
                <div class="panel panel-default" style="border-color: #008975">
                    <div class="panel-heading" style="background-color: #008975">
                        <div class="row">
                            <div class="col-lg-12">
                                <h3>Replies</h3>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <%for (Reply reply : replies) {%>
                        <div class="panel panel-default" style="border-color: #00AA8D; margin-left: 2%">
                            <div class="panel-heading" style="background-color: #00AA8D">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>User: <%=reply.getAuthor()%></h4>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <p><%=reply.getText()%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <p style="display: inline-block; padding-right: 1%;">Likes: <%=reply.getLikes()%></p>
                                        <p style="display: inline-block; padding-right: 1%;">Views: <%=reply.getViews()%></p>
                                        <p style="display: inline-block; padding-right: 1%;">Last Edited: <%=reply.getDateLastEdited()%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function (){

        var support = <%= support%>;

        if (support) {
            $("#forID").prop('checked', true);
        } else {
            $("#againstID").prop('checked', true);
        }
        $("input[type='radio']").checkboxradio("refresh");
    });
</script>
</body>
</html>