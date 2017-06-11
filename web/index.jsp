<%@ page import="Utility.SecurityUtility" %><%--
  Created by IntelliJ IDEA.
  User: Barns
  Date: 3/06/17
  Time: 12:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="WEB-INF/Head_Scripts.jsp"%>
<%
    if (SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("user_interface/Home.jsp");
    else response.sendRedirect("login_interface/Login.jsp");
%>