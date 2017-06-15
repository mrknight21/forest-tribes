<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Tree.TreeDAO" %>
<%@ page import="java.util.function.DoubleBinaryOperator" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="Tree.T_URL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Your contribution</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>

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
    String URLtype = request.getParameter("type");

    int TreeID = Integer.parseInt(request.getParameter("TreeID"));
    boolean isfactual = (URLtype.equals("factual"));
    String title = "";
    String shortIntro = "";
    String URL = "";
    boolean support = true;
    String lastEdit = "";
    int URLid = -1;

    if (requestType.equals("Update")) {
        URLid = Integer.parseInt(request.getParameter("id"));
        System.out.println(isfactual);
        System.out.println(URLid);
        T_URL url = TreeDAO.getURLbyId(DB, URLid, isfactual);
        title = url.getTitle();
        shortIntro = url.getText();
        URL = url.getURL();
        lastEdit = url.getDateLastEdited();
        support = url.isSupportForArgument();
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
                                <h3><%= username%>'s Contribution</h3>

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
                                <form action="<%= sitePath%>Serve_TreeURL" method="get" id="contributionFormID">
                                    <fieldset>
                                        <legend><i class="fa">&#xf02b;</i> Title:</legend>
                                        <div class="form-group">
                                            <input id="urltitleID" type="text" name="title" value="<%=title%>" style="width: 100%" required>
                                        </div>
                                        <legend><i class="fa">&#xf24e;</i> For or against the tree ?</legend>
                                        <div class="form-group" id="stanceRadioID">
                                            <label for="forID">For</label>
                                            <input id="forID" type="radio" class="supportRadio" name="support" value="for"/>
                                            <label for="againstID"> Against</label>
                                            <input id="againstID" type="radio" name="support" class="supportRadio" value="against">
                                        </div>
                                        <legend><i class="fa">&#xf0e5;</i> Have your say:</legend>
                                        <div class="form-group">
                                            <textarea id="descriptionID" name="shortIntro" rows="7" cols="90" required><%=shortIntro%></textarea>
                                        </div>
                                        <legend><i class="fa">&#xf08e;</i> URL:</legend>
                                        <div class="form-group">
                                            <input id="urlID" type="text" name="URL" value="<%=URL%>" style="width: 100%" required>
                                            <input type="hidden" name="URLid" value="<%=URLid%>">
                                            <input type="hidden" name="TreeID" value="<%=TreeID%>">
                                            <input type="hidden" name="URLtype" value="<%=URLtype%>">
                                            <button type="submit" form="contributionFormID" value="Submit"
                                                    class="btn btn-block btn-success" style="margin-top: 2%;">Submit
                                            </button>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
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
