<%@ page import="Utility.SecurityUtility" %>

<%
    if (SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("user_interface/Home.jsp");
    else response.sendRedirect("login_interface/Login.jsp");
%>