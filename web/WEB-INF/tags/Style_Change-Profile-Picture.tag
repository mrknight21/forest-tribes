<%@include file="../Rootpath_Toggle.jsp"%>
<style>
        .full {
            background: url('<%=sitePath%>user_interface/background_03.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }

        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('<%=sitePath%>Fonts/Amperzand.ttf');
        }

        h1 {
            margin-top: 0px;
            margin-bottom: 10px;
            font-family: 'Plump';
            color: #029f5b;
        }

        h4 {
            font-family: 'Amperzand';
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
            border-color: #029f5b;
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
            width: 44px;
        }

        #headerSearchIcon {
            color: #029f5b;
        }

        legend {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            color: #333;
        }

        #userImageID {
            display: block;
            margin: auto;
            width: 250px;
        }

        .img-thumbnail {
            height: 140px;
            width: 140px;
            border-color: transparent;
        }

        .btn-register {
            background-color: #029f5b;
            outline: none;
            color: white;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
        }

        .form-control[disabled] {
            background-color: #029f5b;
            opacity: 1;
        }

        #pictureChoiceDefaultID {
            padding-right: 0;
            padding-left: 0;
        }

        label.btn.btn-primary {
            width: 180px;
            height: 160px;
        }

        input.btn.btn-primary {
            max-width: 190px;
        }

        label {
            max-width: none;
        }

        .btn-primary {
            color: black;
            background-color: #f6f6f6;
            border: 1px solid #c5c5c5;
        }

        .btn-primary:hover {
            background-color: #ccc;
            border: 1px solid #c5c5c5;;
        }

        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            background-color: #029f5b;
            border-color: #1A9B42;
        }

        .ui-icon-background, .ui-state-active .ui-icon-background {
            border: white;
            background-color: #ffffff;
        }

        .ui-visual-focus {
            box-shadow: none;
        }

        .ui-checkboxradio-radio-label.ui-checkboxradio-checked .ui-icon, .ui-checkboxradio-radio-label.ui-checkboxradio-checked:hover .ui-icon {
            width: 16px;
            height: 16px;
            box-shadow: none;
            background-color: #ccc;
        }

        .panel-login {
            margin-top: 2%;
        }

        .form-group {
            margin-bottom: 0;
        }

        #changePictureUploadDivID {
            padding-left: 15px;
        }

        #changePictureDefaultDivID {
            margin-top: 20px;
        }
    </style>