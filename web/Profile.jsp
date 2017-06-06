<%@ page import="Utility.SecurityUtility" %>
<%@ page import="User.UserDAO" %>
<%@ page import="User.User" %>
<%@ page import="Utility.MySQL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
            $("input[type='radio']").checkboxradio();
            $(".form-group").controlgroup();
        });
    </script>
    <style>
        .full {
            background: url('login_interface/lake-baikal-9.jpg') no-repeat center center fixed;
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
            src: url('Fonts/Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('Fonts/Amperzand.ttf');
        }

        .radio-inline {
            margin-top: 0px;
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

        #profileRadioExConID {
            color: darkred;
        }

        #profileRadioConID {
            color: red;
        }

        #profileRadioSliConID {
            color: orangered;
        }

        #profileRadioCentID {
            color: gray;
        }

        #profileRadioSliLibID {
            color: lightblue;
        }

        #profileRadioLibID {
            color: blue;
        }

        #profileRadioExLibID {
            color: darkblue;
        }
    </style>
</head>
<body>
<%--<% if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("/login_interface/Login.jsp");--%>

<%--final MySQL DB = new MySQL();--%>

<%--HttpSession httpSession = request.getSession();--%>
<%--String username = (String) httpSession.getAttribute("username");--%>

<%--User user = UserDAO.getUser(DB, username);--%>
<%--String email = user.getEmail();--%>
%>
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-login">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center">Forest Tribes</h1>
                            <h4 id="subtitle" style="text-align: center">The Beauty of Interconnectedness</h4>
                            <form id="profileFormID" action="/Serve_Profile" method="post" role="form"
                                  style="display: block">
                                <fieldset class="span4">
                                    <legend>Membership Information</legend>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" name="profileUsername" id="profileUsernameID" tabindex="1"
                                               value="" class="form-control" readonly>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-envelope"></i></span>
                                        <input type="email" name="profileEmail" id="profileEmailID" tabindex="1"
                                               class="form-control" value="" readonly>
                                    </div>
                                    <form action="" method="post"><input type="submit" value="Change Password"
                                                                         class="form-control btn btn-register"></form>
                                    <%--<img src="/User/<%= username%>/User_profile_picture.jpg">--%>
                                </fieldset>
                                <br>
                                <fieldset>
                                    <legend>Personal Information</legend>
                                    <fieldset>
                                        <legend>Gender:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioMaleID">Male</label>
                                            <input type="radio" name="male" id="profileRadioMaleID">
                                            <label for="profileRadioFemaleID">Female</label>
                                            <input type="radio" name="female" id="profileRadioFemaleID">
                                            <label for="profileRadioOtherID">Other</label>
                                            <input type="radio" name="other" id="profileRadioOtherID">
                                        </div>
                                    </fieldset>
                                    <fieldset>
                                        <legend>Occupation:</legend>
                                        <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-pencil"></i></span>
                                            <input type="text" name="occupation" id="profileOccupationID"
                                                   tabindex="1" class="form-control" placeholder="Occupation" value="">
                                        </div>
                                    </fieldset>
                                    <fieldset>
                                        <legend>Education:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioPrimaryID">Primary</label>
                                            <input type="radio" name="primary" id="profileRadioPrimaryID">
                                            <label for="profileRadioSecondaryID">Secondary</label>
                                            <input type="radio" name="secondary" id="profileRadioSecondaryID">
                                            <label for="profileRadioTertiaryID">Tertiary</label>
                                            <input type="radio" name="tertiary" id="profileRadioTertiaryID">
                                            <label for="profileRadioPostgraduateID">Postgraduate</label>
                                            <input type="radio" name="postgraduate" id="profileRadioPostgraduateID">
                                            <label for="profileRadioDoctorateID">Doctorate</label>
                                            <input type="radio" name="doctorate" id="profileRadioDoctorateID">
                                        </div>
                                    </fieldset>
                                    <fieldset>
                                        <legend>Political Orientation:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioExLibID">Extremely Liberal</label>
                                            <input type="radio" name="extremely_liberal" id="profileRadioExLibID">
                                            <label for="profileRadioLibID">Liberal</label>
                                            <input type="radio" name="liberal" id="profileRadioLibID">
                                            <label for="profileRadioSliLibID">Slightly Liberal</label>
                                            <input type="radio" name="slightly_liberal" id="profileRadioSliLibID">
                                            <label for="profileRadioCentID">Centrist</label>
                                            <input type="radio" name="centrist" id="profileRadioCentID">
                                            <label for="profileRadioSliConID">Slightly Conservative</label>
                                            <input type="radio" name="slightly_conservative" id="profileRadioSliConID">
                                            <label for="profileRadioConID">Conservative</label>
                                            <input type="radio" name="conservative" id="profileRadioConID">
                                            <label for="profileRadioExConID">Extremely Conservative</label>
                                            <input type="radio" name="extremely_conservative" id="profileRadioExConID">
                                        </div>
                                    </fieldset>
                                </fieldset>
                                <br>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="profileSubmit" id="profileSubmitID"
                                                   tabindex="7" class="form-control btn btn-register"
                                                   value="Update your Profile">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function toggleEnabler(element) {
        element.on('click', function () {
            var sel = $(this).data('title');
            var tog = $(this).data('toggle');
            $('#' + tog).prop('value', sel);

            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');
        });
    }

    var gender = $("#profileGenderButtons a");
    toggleEnabler(gender);

    var education = $("#profileEducationButtons a");
    toggleEnabler(education);
</script>
</body>
</html>


<%--<div class="input-group">--%>
<%--<span class="input-group-addon"><i--%>
<%--class="glyphicon glyphicon-user"></i></span>--%>
<%--<div id="profileGenderButtons" class="btn-group-justified btn-group-md">--%>
<%--<a class="btn btn-primary btn-md active" data-toggle="profileGender"--%>
<%--data-title="Male">Male</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileGender"--%>
<%--data-title="Female">Female</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileGender"--%>
<%--data-title="Other">Other</a>--%>
<%--</div>--%>
<%--<input type="hidden" name="profileGender" id="profileGenderID">--%>
<%--</div>--%>

<%--<div class="input-group">--%>
<%--<span class="input-group-addon"><i--%>
<%--class="glyphicon glyphicon-user"></i></span>--%>
<%--<div id="profileEducationButtons" class="btn-group-justified btn-group-md">--%>
<%--<a class="btn btn-primary btn-md active" data-toggle="profileEducation"--%>
<%--data-title="primary">Primary</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"--%>
<%--data-title="secondary">Secondary</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"--%>
<%--data-title="tertiary">Tertiary</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"--%>
<%--data-title="postgraduate">Postgraduate</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"--%>
<%--data-title="doctorate">Doctorate</a>--%>
<%--</div>--%>
<%--<input type="hidden" name="profileGender" id="profileEducationID">--%>
<%--</div>--%>

<%--<div class="input-group">--%>
<%--<span class="input-group-addon"><i--%>
<%--class="glyphicon glyphicon-user"></i></span>--%>
<%--<div class="btn-group-md">--%>
<%--<a class="btn btn-primary btn-md active" data-toggle="profilePolitical"--%>
<%--data-title="extremely_liberal">Extremely Liberal</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="liberal">Liberal</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="slightly_liberal">Slightly Liberal</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="neutral">Neutral</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="slightly_conservative">Slightly Conservative</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="conservative">Conservative</a>--%>
<%--<a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"--%>
<%--data-title="extremely_conservative">Extremely Conservative</a>--%>
<%--</div>--%>
<%--<input type="hidden" name="profilePolitical" id="profilePoliticalID">--%>
<%--</div>--%>