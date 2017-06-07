
<head>
    <title>Header</title>

    <%--JQuery JavaScript--%>
    <script
            src="https://code.jquery.com/jquery-3.2.1.js"
            integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
            crossorigin="anonymous"></script>

    <%--Bootstrap CSS--%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <%--Bootstrap JavaScript--%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <%--JQuery UI CSS--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <%--JQuery UI JavaScript--%>
    <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous"></script>

    <style>
        @font-face {
            font-family: Plump;
            src: url('Fonts/Plumpfull.ttf');
        }

        #headerUser, #headerHome, #headerCollection {
            font-family: Plump;
            color: white;
        }

        .container-fluid {
            background-color: #029f5b;
        }

        .navbar-default .navbar-nav > .open > a, .navbar-default .navbar-nav > .open > a:focus, .navbar-default .navbar-nav > .open > a:hover {
            background-color: #029f5b;
        }

        .navbar-default .navbar-toggle:focus, .navbar-default .navbar-toggle:hover {
            background-color: white;
        }

        .navbar-default .navbar-toggle {
            border-color: white;
            background-color: white;
        }

        .navbar-default .navbar-toggle .icon-bar {
            background-color: #029f5b;
        }

        #headerSearchSubmit {
            font-family: Plump;
            color: #029f5b;
        }

        #headerThumbnail {
            margin: 3px;
            height: 44px;
        }

        #headerSearchIcon {
            color: #029f5b;
        }
    </style>
</head>
<body>
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
            <img id="headerThumbnail" src="/User/<%= username%>/User_profile_picture_thumb.jpg"
                 class="img-thumbnail" alt="User Profile Picture">
        </div>
        <div class="collapse navbar-collapse" id="headerNavBar">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" id="headerUser" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-user"></i> <%= username%><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Update your account</a></li>
                        <li><a href="#">Change profile picture</a></li>
                        <li><a href="#">Change password</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Logout</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" id="headerCollection" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="glyphicon glyphicon-picture"></i> Collection Display<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                        <li><a href="#">To be UPDATED</a></li>
                    </ul>
                </li>
                <li>
                    <a id="headerHome" href="" role="button"><i class="glyphicon glyphicon-tree-conifer"></i> Home</a>
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
</body>

