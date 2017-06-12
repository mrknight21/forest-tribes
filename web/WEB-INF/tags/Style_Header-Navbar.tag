<%@include file="../Rootpath_Toggle.jsp"%>
<style>
        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
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

        .navbar-default {
            margin-bottom: 0;
        }

        .navbar-default .navbar-toggle {
            border-color: white;
            background-color: white;
        }

        .navbar-default .navbar-toggle .icon-bar {
            background-color: #029f5b;
        }

        .navbar-default {
            border-color: #029f5b;
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