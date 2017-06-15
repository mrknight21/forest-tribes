<%@include file="../Rootpath_Toggle.jsp"%>
<style>
        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
        }

        #headerUser, #headerHome, #headerCollection {
            font-family: Futura;
            color: white;
        }

        .container-fluid {
            background-color: #008975;
        }

        .navbar-default .navbar-nav > .open > a, .navbar-default .navbar-nav > .open > a:focus, .navbar-default .navbar-nav > .open > a:hover {
            background-color: #008975;
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
            background-color: #008975;
        }

        .navbar-default {
            border-color: #008975;
        }

        #headerSearchSubmit {
            font-family: Futura;
            color: #008975;
        }

        #headerThumbnail {
            margin: 3px;
            height: 44px;
        }

        #headerSearchIcon {
            color: #008975;
        }
    </style>