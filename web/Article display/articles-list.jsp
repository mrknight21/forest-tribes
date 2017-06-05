<%--
  Created by IntelliJ IDEA.
  User: wasia
  Date: 5/06/2017
  Time: 2:36 PM
  To change this template use File | Settings | File Templates.
--%>

<%--Include this page in user landing page--%>

<!--Article panel-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="article" items="${articleList}">
    <div class="col-sm-12 col-md-9 panel panel-default" id="article-container">
        <div class="panel panel-default" id="article">
            <div class="panel-heading">
                <h3 class="panel-title">${article.title}</h3>
            </div>
            <div class="panel-body">
                <p>
                    ${article.abstract}
                </p>
            </div>
        </div>
    </div>
</c:forEach>