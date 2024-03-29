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
            font-family: Futura;
            src: url('<%=sitePath%>Fonts/Futura.ttc');
        }

        #cancelLink {
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: red;
        }

        h1 {
            margin-top: 0;
            margin-bottom: 10px;
            font-family: 'Plump', Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: #029f5b;
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
            font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
            color: red;
        }

        .form-control[disabled] {
            background-color: #008975;
            opacity: 1;
        }
    </style>