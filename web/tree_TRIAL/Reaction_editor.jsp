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
    <title>Forest Tribes: URL Editor</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

    <%--Page Specific CSS--%>

    <style>
        .full {
            background: url('<%=sitePath%>tree_TRIAL/background_02.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }
    </style>
</head>
<body>

<%!private static final MySQL DB = new MySQL();%>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");

    String requestType = request.getParameter("request");

    int TreeID = Integer.parseInt(request.getParameter("TreeID"));
    String text ="";
    boolean support = true;
    String lastEdit = "";
    int reactionID = -1;
    String author = username;
    List<Reply> replies = new ArrayList<>();

    if (requestType.equals("Update")){
        reactionID = Integer.parseInt(request.getParameter("id"));
        System.out.println(reactionID);
        T_Reaction reaction = TreeDAO.getReactionbyId(DB, reactionID);
        text = reaction.getText();
        lastEdit= reaction.getDateLastEdited();
        support = reaction.isSupportForArgument();
        author = reaction.getAuthor();
        replies = reaction.getReplies();
    }
%>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<form action="/Serve_TreeReaction" method="get">

    <p>User: <%=author%></p>
    <% if (!lastEdit.equals("")){%>
    <p>Last Edited: <%=lastEdit%></p>
    <%}%>
    <p></p>
    <p>For or against the tree?</p>
    <br>
    <% if (support){%>
    <label for="for">For</label>
    <input id="for" type="radio"  class= "supportRadio" name="support" value="for" checked/>
    <label for="against"> Against</label>
    <input id="against" type="radio" name="support" class= "supportRadio" value="against">
    <%} else if (!support){ %>
    <label for="for">For</label>
    <input id="for" type="radio"  class= "supportRadio" name="support" value="for"/>
    <label for="against"> Against</label>
    <input id="against" type="radio" name="support" class= "supportRadio" value="against" checked/>
    <%}%>

    <P></P>
    <label for="description">Have your say: </label>
    <br>
    <textarea id="description" name="content" rows="7" cols="80"><%=text%></textarea>
    <p></p>
    <input type="hidden" name="reactionID" value="<%=reactionID%>">
    <input type="hidden" name="TreeID" value="<%=TreeID%>">
    <input type="hidden" name="repliesNum" value="<%=replies.size()%>">
    <input type="submit" value="Submit!!">
</form>

<p></p>
<p></p>
<p></p>
<div class="replies_container">
<% if (replies.size() > 0){
    for (Reply reply: replies){%>
<div class="single_reply_container">
    <p>User: <%=reply.getAuthor()%></p>
    <p>Likes: <%=reply.getLikes()%>  Views: <%=reply.getViews()%> Last Edited: <%=reply.getDateLastEdited()%></p>
    <p><%=reply.getText()%></p>
</div>
   <% }
}%>
</div>
</body>
</html>