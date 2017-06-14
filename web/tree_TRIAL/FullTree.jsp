<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 13/06/2017
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="Utility.SecurityUtility" %>
<%@ page import="Tree.InfoTree" %>

<html>
<head>
    <title>Full InfoTree</title>
    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>
    <%--Page Specific CSS--%>
    <tags:Style_Display-Full-Article/>
</head>
<body>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
    /*
        private String title;
    private List<T_URL> factual;
    private List<T_URL> commentary;
    private List<T_Reaction> reactoin;
    private int stage;
    private int size;
    private int exp;
    private int coordinX;
    private int coordinY;
    private int leaves;


    /* protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;*/

%>


<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<h1>${tree.title}</h1>
<P></P>
<h2>Author: ${tree.author}     created on: ${tree.dateCreated}  last edited: ${tree.dateLastEdited}</h2>
<h3> Likes: ${tree.likes} Views: ${tree.views} Stage: ${tree.stage} Exp: ${tree.exp} Coordinate: (${tree.coordinX}, ${tree.coordinY})</h3>
<p></p>
<p></p>
<div class="image continer">
    <img src="<%=sitePath%>tree_TRIAL/Tree_Material/Venusaur_stage_${tree.stage}.png" >
</div>

<h1>Facts</h1>
<div id="FacturalURLS">
    <table>
        <tr>
            <th>For:         </th>
            <th>Against:     </th>
        </tr>
        <tbody>
        <tr>
            <td>
                <ul>
                    <c:forEach var="URLS" items="${fact_for}">
                        <a href="${URLS.URL}"><li>${URLS.title}</li></a>
                        <form class="URL_editor" action="/tree_TRIAL/URL_editor.jsp" method="get">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="hidden" value="$factual" name="type">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="hidden" value="for" name="support">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="URL_deleter">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach var="URLS" items="${fact_against}">
                        <a href="${URLS.URL}"><li>${URLS.title}</li></a>
                        <form class="URL_editor" action="/tree_TRIAL/URL_editor.jsp" method="get">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="hidden" value="factual" name="type">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="hidden" value="against" name="support">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="URL_deleter">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<p></p>
<p></p>
<p></p>
<form class="URL_Adder" action="/tree_TRIAL/URL_editor.jsp" method="get">
    <input type="hidden" value="${tree.id}" name="TreeID">
    <input type="hidden" value="factual" name="type">
    <input type="submit" value="Add" name="request">
</form>
<h1>Commentary</h1>
<div id="CommentaryURLS">
    <table>
        <tr>
            <th>For:         </th>
            <th>Against:     </th>
        </tr>
        <tbody>
        <tr>
            <td>
                <ul>
                    <c:forEach var="URLS" items="${commentary_for}">
                        <a href="${URLS.URL}"><li>${URLS.title}</li></a>
                        <form class="URL_editor" action="/tree_TRIAL/URL_editor.jsp" method="get">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="hidden" value="commentary" name="type">
                            <input type="hidden" value="for" name="support">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="URL_deleter">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach var="URLS" items="${commentary_against}">
                        <a href="${URLS.URL}"><li>${URLS.title}</li></a>
                        <form class="URL_editor" action="/tree_TRIAL/URL_editor.jsp" method="get">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="hidden" value="commentary" name="type">
                            <input type="hidden" value="against" name="support">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="URL_deleter">
                            <input type="hidden" value="${URLS.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </table>
    <form class="URL_Adder" action="/tree_TRIAL/URL_editor.jsp" method="get">
        <input type="hidden" value="${tree.id}" name="TreeID">
        <input type="hidden" value="commentary" name="type">
        <input type="submit" value="Add" name="request">
    </form>
</div>
<h1>Reactions</h1>
<div id="Reactions">
    <table>
        <tr>
            <th>For:         </th>
            <th>Against:     </th>
        </tr>
        <tbody>
        <tr>
            <td>
                <ul>
                    <c:forEach var="reaction" items="${reaction_for}">
                        <<li>${reaction.text}</li>
                        <form class="reaction_editor" action="/" method="get">
                            <input type="hidden" value="${reaction.id}" name="id">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="hidden" value="for" name="support">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="reaction_deleter">
                            <input type="hidden" value="${reaction.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach var="reaction" items="${reaction_against}">
                        <<li>${reaction.text}</li>
                        <form class="reaction_editor" action="/" method="get">
                            <input type="hidden" value="${reaction.id}" name="id">
                            <input type="hidden" value="${tree.id}" name="TreeID">
                            <input type="hidden" value="against" name="support">
                            <input type="submit" value="Update" name="request">
                        </form>
                        <form class="reaction_deleter">
                            <input type="hidden" value="${reaction.id}" name="id">
                            <input type="submit" value="Delete">
                        </form>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </table>
    <form class="Reaction_Adder">
        <input type="hidden" value="${tree.id}" name="TreeID">
        <input type="submit" value="Add new reaction" name="request">
    </form>
</div>


</body>
</html>
