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

        #headerUser, #headerHome, #headerCollection {
            font-family: Plump;
            color: white;
        }

        #cancelLink {
            font-family: Plump;
            color: red;
        }

        h1 {
            margin-top: 0;
            margin-bottom: 10px;
            font-family: 'Plump';
            color: #029f5b;
        }

        h4 {
            margin-bottom: 10px;
            font-family: 'Amperzand';
        }

        .btn-login {
            background-color: #029f5b;
            outline: none;
            color: white;
            font-size: 14px;
            height: auto;
            font-weight: normal;
            padding: 14px 0;
            text-transform: uppercase;
            border-color: #029f5b;
        }

        .container-fluid {
            background-color: #029f5b;
        }

        .panel {
            margin-top: 2%;
        }

        .input-group {
            margin-bottom: 10px;
        }

        legend {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 11pt;
            color: #333;
            margin-bottom: 0;
        }

        #changePasswordMessageID {
            font-family: Plump;
            color: red;
        }

        .form-control[disabled] {
            background-color: #029f5b;
            opacity: 1;
        }
    </style>