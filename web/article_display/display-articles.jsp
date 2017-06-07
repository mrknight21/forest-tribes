<%--
  Created by IntelliJ IDEA.
  User: wasia
  Date: 5/06/2017
  Time: 2:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--Article panel-->

<%
    String displayType = (String) request.getAttribute("display-type");
    if (displayType.equals("list")) {%>
<c:forEach var="article" items="${articles}">
    <%}%>

    <div class="col-sm-12 col-md-9 panel panel-default article-container">
        <div class="panel panel-default" id="article">
            <div class="panel-heading">
                <h3 class="panel-title">${article.title}</h3>
            </div>
            <div class="panel-body">
                <p>
                        ${article.text}
                </p>
                <p>
                        ${article.likes}
                        ${article.commentCount}
                </p>
            </div>
        </div>
    </div>



    <%if (!displayType.equals("list")) {%>
    <div id="comments-${article.id}">
    <c:forEach var="comment" items="${comments}">
        <div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
            <div class="panel panel-default comment">
                <div class="panel-body">
                    <p>
                            ${comment.text}
                    </p>
                    <p>
                            ${comment.likes}
                            ${comment.replyCount}
                    </p>
                </div>
                <div id="replies-${comment.id}">
                    <c:forEach var="reply" items="${comment.replies}">
                        <div class="panel-body">
                            <p>
                                    ${reply.text}
                            </p>
                            <p>
                                    ${reply.likes}
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:forEach>
    </div>
    <%}>

    <%if (displayType.equals("list")) {%>
</c:forEach>
<%}%>

<%--

Inlcude article editing forms on this page -
use jquery to transform content into an editable text area to be submitted to server

Make sure there are no duplicate ids

--%>