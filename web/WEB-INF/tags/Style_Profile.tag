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
            font-family: Futura;
            src: url('<%=sitePath%>Fonts/Futura.ttc');
        }

        .panel {
            margin-top: 2%;
        }

        h1 {
            margin-top: 0px;
            margin-bottom: 10px;
            font-family: 'Plump', Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: #029f5b;
        }

        @font-face {
            font-family: Plump;
            src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
        }

        legend {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            color: #333;
        }

        h5 {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            line-height: 1.42857143;
            color: #333;
            font-weight: 700;
        }

        .control-label {
            margin-bottom: 0px;
        }

        .input-group {
            margin-bottom: 10px;
        }

        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            background-color: #008975;
            border-color: #008975;
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

        #profileUpdateLink, #profileDeleteLink {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
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
            color: #008975;
            font-weight: bold;
            font-size: 15px;
            -webkit-transition: all 0.1s linear;
            -moz-transition: all 0.1s linear;
            transition: all 0.1s linear;
        }

        #profileDeleteWarningID, #profileMessageID, #statusMessage {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: red;
        }

        .form-control[disabled] {
            background-color: #008975;
            opacity: 1;
        }
    </style>