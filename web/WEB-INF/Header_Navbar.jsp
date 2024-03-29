<script>
    function troll() {
        $("#searchID").val("Lol couldn't find anything");
        $("#searchID").prop('readonly', true);
    }

    $(document).ready(function () {
        $("#searchID").keyup(troll);
    });
</script>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#headerNavBar" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <img id="headerThumbnail" src="<%=sitePath%>User/<%= username%>/User_profile_picture_thumb.jpg"
                 class="img-thumbnail" alt="User Profile Picture" style="width: 44px; height: 44px;">
        </div>
        <div class="collapse navbar-collapse" id="headerNavBar">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" id="headerUser" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-user"></i> <%= username%><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<%=sitePath%>Profile.jsp">Update your profile</a></li>
                        <li><a href="<%=sitePath%>user_interface/ProfilePictureUpdate.jsp">Change profile picture</a></li>
                        <li><a href="<%=sitePath%>user_interface/changePassword.jsp">Change password</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#" onclick="signOut()">Logout</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" id="headerCollection" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-picture"></i> Collection Display<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<%=sitePath%>article_display/DisplayAllArticles.jsp">All articles</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<%=sitePath%>tree_TRIAL/TreePlanting.jsp">Plant your tree</a></li>
                        <li><a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp?author=<%=username%>">Your articles</a></li>
                        <li><a href="<%=sitePath%>article_display/CreateArticle.jsp">Create new article</a></li>
                    </ul>
                </li>
                <li>
                    <a id="headerHome" href="<%=sitePath%>user_interface/Home.jsp" role="button"><i class="glyphicon glyphicon-tree-conifer"></i> Home</a>
                </li>
            </ul>
            <form class="navbar-form navbar-right">
                <div id="headerSearch" class="form-group">
                    <input type="text" id="searchID" class="form-control" placeholder="Search" onchange="troll();">
                </div>
                <button id="headerSearchSubmit" type="submit" class="btn btn-default"><i id="headerSearchIcon" class="glyphicon glyphicon-search"></i> Search</button>
            </form>
        </div>
    </div>
</nav>
<%--Google Logout--%>
<script>
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
        window.open("<%=sitePath%>Serve_Logout", "_self");
    }
</script>