<%--
  Created by IntelliJ IDEA.
  User: wasia
  Date: 5/06/2017
  Time: 2:46 PM
  To change this template use File | Settings | File Templates.
--%>

<!--Article panel-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
    <div class="panel panel-default" id="article">
        <div class="panel-heading">
            <h3 class="panel-title">${article.title}</h3>
        </div>
        <div class="panel-body">
            <p>
                ${article.text}
                ${article.image}
            </p>
        </div>
    </div>
</div>


<c:forEach var="comment" items="${commentsList}">
    <div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
        <div class="panel panel-default comment">
            <div class="panel-body">
                <p>
                        ${comment.abstract}
                </p>
            </div>
        </div>
    </div>
</c:forEach>

<%--

Inlcude article editing forms on this page -
use jquery to transform content into an editable text area to be submitted to server

Make sure there are no duplicate ids

--%>