<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Tree.TreeDAO" %>
<%@ page import="java.util.function.DoubleBinaryOperator" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Tree.T_URL" %><%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 14/06/2017
  Time: 2:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>
    <%--Page Specific CSS--%>
    <tags:Style_Display-Full-Article/>
    <title>URL_Editor</title>
</head>
<body>
<%!private static final MySQL DB = new MySQL();%>
<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");


    String requestType = request.getParameter("request");
    String URLtype = request.getParameter("type");

    int TreeID = Integer.parseInt(request.getParameter("TreeID"));
    boolean isfactual = (URLtype.equals("factual"));
    String title ="";
    String shortIntro ="";
    String URL ="";
    boolean support = true;
    String lastEdit = "";
    int URLid = -1;


    if (requestType.equals("Update")){
        URLid = Integer.parseInt(request.getParameter("id"));
        System.out.println(isfactual);
        System.out.println(URLid);
        T_URL url = TreeDAO.getURLbyId(DB, URLid, isfactual);
        title = url.getTitle();
        shortIntro = url.getText();
        URL = url.getURL();
        lastEdit= url.getDateLastEdited();
        support = url.isSupportForArgument();
    }


%>
<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<form action="/Serve_TreeURL" method="get">
    <label for="URLtitle">Title: </label>
    <br>
    <input id="URLtitle"type="text" name="title" value="<%=title%>">
    <p></p>
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
    <label for="description">What is it about:</label>
    <br>
    <textarea id="description" name="shortIntro" rows="7" cols="80"><%=shortIntro%></textarea>
    <p></p>
    <label for="URL">URL: </label>
    <input id="URL"type="text" name="URL" value="<%=URL%>">
    <p></p>
    <input type="hidden" name="URLid" value="<%=URLid%>">
    <input type="hidden" name="TreeID" value="<%=TreeID%>">
    <input type="hidden" name="URLtype" value="<%=URLtype%>">
    <input type="submit" value="Submit!!">
</form>
</body>
</html>
