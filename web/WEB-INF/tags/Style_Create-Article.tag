<%@include file="../Rootpath_Toggle.jsp" %>
<style>
    .full {
        background: url('<%=sitePath%>article_display/background_04.jpg') no-repeat center center fixed;
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

    h5 {
        font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
        color: white;
    }

    .panel-default > .panel-heading {
        background-color: #008975;
        border-color: #008975;
    }

    .panel-default {
        border-color: #008975;
        margin: 2%;
    }

    .panel-login {
        margin-top: 2%;
    }

    .btn-login {
        background-color: #008975;
        border-color: #008975;
        outline: none;
        color: white;
        text-transform: uppercase;
    }

    fieldset {
        margin-top: 2%;
        margin-left: 2%;
    }

    legend {
        font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;;
        margin-bottom: 0;
    }
</style>