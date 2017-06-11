<%@include file="../rootpath_toggle.jsp"%>

<style>
        .full {
            background: url('<%=sitePath%>login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            background-size: cover;
            -o-background-size: cover;
        }

        body {
            background-color: transparent;
        }

        .panel {
            margin-top: 25%;
        }

        h1 {
            margin-top: 0px;
            margin-bottom: 10px;
            font-family: 'Plump';
            color: #029f5b;
        }

        h4 {
            margin-bottom: 10px;
            font-family: 'Amperzand';
        }

        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('<%=sitePath%>Fonts/Amperzand.ttf');
        }

        legend {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 1.42857143;
            color: #333;
            font-weight: 700;
        }

        h5 {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            line-height: 1.42857143;
            color: #333;
            font-weight: 700;
        }

        .btn-register {
            background-color: #029f5b;
            outline: none;
            color: #fff;
            font-size: 14px;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
        }

        .control-label {
            margin-bottom: 0px;
        }

        .input-group {
            margin-bottom: 10px;
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

        #profileImage {
            width: 50%;
        }

        .thumbnail {
            border-color: transparent;
        }

        #profileIssuesFieldset img {
            padding-right: 0;
            padding-left: 0;
        }

        .btn-primary {
            padding-right: 24px;
            padding-left: 24px;
        }

        .panel-login > .panel-heading a {
            text-decoration: none;
            color: #029f5b;
            font-weight: bold;
            font-size: 15px;
            -webkit-transition: all 0.1s linear;
            -moz-transition: all 0.1s linear;
            transition: all 0.1s linear;
        }

        #profileDeleteWarningID, #profileMessageID {
            font-family: Plump;
            color: red;
        }

        .form-control[disabled] {
            background-color: #029f5b;
            opacity: 1;
        }
    </style>