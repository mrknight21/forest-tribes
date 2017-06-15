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

        h1 {
            margin-top: 0px;
            margin-bottom: 10px;
            font-family: 'Plump', Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
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

        .form-control[disabled] {
            background-color: #008975;
            opacity: 1;
        }

        #pictureChoiceDefaultID {
            padding-right: 0;
            padding-left: 0;
        }

        label {
            max-width: none;
        }

        .btn-primary:hover {
            background-color: #ccc;
            border: 1px solid #c5c5c5;;
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