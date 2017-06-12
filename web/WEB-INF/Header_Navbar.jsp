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
                 class="img-thumbnail" alt="User Profile Picture">
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
                        <li><a href="<%=sitePath%>Serve_Logout">Logout</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" id="headerCollection" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-picture"></i> Collection Display<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<%=sitePath%>article_display/DisplayAllArticles.jsp">All Articles</a></li>
                        <li><a href="<%=sitePath%>article_display/DisplayUserAllArticles.jsp">Your Articles</a></li>
                        <li><a href="<%=sitePath%>article_display/CreateArticle.jsp">Create new article</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                    </ul>
                </li>
                <li>
                    <a id="headerHome" href="<%=sitePath%>user_interface/Home.jsp" role="button"><i class="glyphicon glyphicon-tree-conifer"></i> Home</a>
                </li>
            </ul>
            <form class="navbar-form navbar-right">
                <div id="headerSearch" class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button id="headerSearchSubmit" type="submit" class="btn btn-default"><i id="headerSearchIcon" class="glyphicon glyphicon-search"></i> Search</button>
            </form>
        </div>
    </div>
</nav>