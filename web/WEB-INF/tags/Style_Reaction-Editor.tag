<%@include file="../Rootpath_Toggle.jsp" %>
<style>
        .full {
            background: url('<%=sitePath%>tree_TRIAL/background_02.jpg') no-repeat center center fixed;
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

        h3, h4 {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;;
            color: white;
        }

        legend {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            color: #333;
        }

        .panel-login {
            margin-top: 2%;
            padding-left: 2%;
            padding-right: 2%;
            padding-top: 2%;
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
    </style>