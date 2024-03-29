<%@include file="../Rootpath_Toggle.jsp"%>
<style>
    /* ---------- Media Rules ---------- */

    /* --- iPhone 5 --- */

    /* --- Landscape --- */
    @media only screen
    and (min-device-width: 320px)
    and (max-device-width: 568px)
    and (-webkit-min-device-pixel-ratio: 2)
    and (orientation: landscape) {
        .panel {
            margin-right: 0;
            margin-left: 17%;
            width: 70%;
        }

        .container {
            padding: 0;
        }

        #loginHidePanelLink {
            padding-left: 2%;
        }
    }

    /* --- Portrait --- */
    @media only screen
    and (min-device-width: 320px)
    and (max-device-width: 568px)
    and (-webkit-min-device-pixel-ratio: 2)
    and (orientation: portrait) {
        .panel {
            margin-top: 10%;
        }

        .col-lg-4 {
            padding-right: 5%;
        }

        #loginHidePanelLink {
            padding-left: 2%;
        }
    }

    /* --- iPhone 6 --- */

    /* --- Landscape --- */
    @media only screen
    and (min-device-width: 375px)
    and (max-device-width: 667px)
    and (-webkit-min-device-pixel-ratio: 2)
    and (orientation: landscape) {
        .panel {
            margin-top: 5%;
            margin-left: 10%;
            width: 80%;
        }
    }

    /* --- Portrait --- */
    @media only screen
    and (min-device-width: 375px)
    and (max-device-width: 667px)
    and (-webkit-min-device-pixel-ratio: 2)
    and (orientation: portrait) {
        .panel {
            margin-top: 20%;
        }
    }

    /* --- iPhone 6+ --- */

    /* --- Landscape --- */
    @media only screen
    and (min-device-width: 414px)
    and (max-device-width: 736px)
    and (-webkit-min-device-pixel-ratio: 3)
    and (orientation: landscape) {
        .panel {
            margin-top: 5%;
            margin-left: 10%;
            width: 80%;
        }
    }

    /* --- Portrait --- */
    @media only screen
    and (min-device-width: 414px)
    and (max-device-width: 736px)
    and (-webkit-min-device-pixel-ratio: 3)
    and (orientation: portrait) {
        .panel {
            margin-top: 20%;
            margin-left: 1%;
        }
    }

    /* --- iPad --- */

    /* --- Landscape --- */
    @media only screen
    and (min-device-width: 768px)
    and (max-device-width: 1024px)
    and (orientation: landscape)
    and (-webkit-min-device-pixel-ratio: 2) {
        .panel {
            margin-top: 10%;
            margin-left: 10%;
            width: 80%;
        }
    }

    /* --- Portrait --- */
    @media only screen
    and (min-device-width: 768px)
    and (max-device-width: 1024px)
    and (orientation: portrait)
    and (-webkit-min-device-pixel-ratio: 2) {
        .panel {
            margin-top: 30%;
            margin-left: 4%;
            width: 90%;
        }
    }

    /* --- iPad Pro --- */

    /* --- Landscape --- */
    @media only screen
    and (min-device-width: 1024px)
    and (max-device-width: 1366px)
    and (orientation: landscape)
    and (-webkit-min-device-pixel-ratio: 2) {
        .panel {
            margin-top: 40%;
        }
    }

    /* --- Portrait --- */
    @media only screen
    and (min-device-width: 1024px)
    and (max-device-width: 1366px)
    and (orientation: portrait)
    and (-webkit-min-device-pixel-ratio: 2) {
        .panel {
            margin-top: 35%;
            margin-left: 15%;
            width: 70%;
        }
    }

    /* --- Desktops and Laptops --- */

    /* --- All Orientations --- */
    @media only screen
    and (min-device-width: 1200px) {
        .panel {
            margin-top: 20%;
        }
    }

    /* ---------- Styling Rules ---------- */

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

    @font-face {
        font-family: Futura;
        src: url('<%=sitePath%>Fonts/Futura.ttc');
    }

    h1 {
        margin-top: 0;
        margin-bottom: 10px;
        font-family: 'Plump', Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
        color: #029f5b;
    }

    h4, h5 {
        font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;;
    }

    #loginFormLink, #registrationFormLink {
        font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    .panel-body {
        padding-top: 0px;
    }

    .panel-heading {
        padding-bottom: 0px;
    }

    .btn-login, .btn-register {
        background-color: #008975;
        outline: none;
        color: white;
        font-size: 14px;
        height: auto;
        font-weight: normal;
        padding: 14px 0;
        text-transform: uppercase;
        border-color: #008975;
    }

    .btn-primary.active, .btn-primary.active:hover, .btn-primary.active:focus {
        background-color: transparent;
        border-color: transparent;
        outline: none;
        color: white;
        height: auto;
        font-weight: normal;
        text-decoration: none;
    }

    .btn-primary, .btn-primary:hover, .btn-primary:focus {
        background-color: transparent;
        border-color: transparent;
        outline: none;
        color: white;
        height: auto;
        font-weight: normal;
        text-decoration: none;
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

    .panel-login > .panel-heading a.active {
        color: #008975;
        font-size: 18px;
    }

    @font-face {
        font-family: Plump;
        src: url('<%=sitePath%>Fonts/Plumpfull.ttf');
    }

    .input-group {
        margin-bottom: 10px;
    }

    #messageLogin, #registrationMessageID, #usernameExistsID, #usernameAvailableID {
        color: red;
        font-family: Futura, "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    #usernameAvailableID {
        color: green;
    }

    .form-control[disabled] {
        background-color: #008975;
        opacity: 1;
    }

    .container {
        width: 100%
    }

    #loginHideRow {
        padding-left: 2%;
        padding-top: 2%;
    }

    #loginGoogle, #status {
        display: inline-block;
    }
</style>