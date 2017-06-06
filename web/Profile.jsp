<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src="/Frameworks/jquery.min.js"></script>
    <script src="/Frameworks/jquery-ui.min.js"></script>
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

        #profileGenderButtons .btn-primary.notActive {
            background-color: #029f5b;
            border-color: #0C9636;
        }

        #profileGenderButtons .btn-primary.active {
            background-color: #1B7F3A;
            border-color: #176E32;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-login">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center">Forest Tribes</h1>
                            <h4 id="subtitle" style="text-align: center">The Beauty of Interconnectedness</h4>
                            <form id="profileFormID" action="/Serve_Profile" method="post" role="form" style="display: block">
                                <fieldset class="span4">
                                    <legend>Membership Information:</legend>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" name="profileUsername" id="profileUsernameID" tabindex="1"
                                               value="${Username}" class="form-control" readonly>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-envelope"></i></span>
                                        <input type="email" name="profileEmail" id="profileEmailID" tabindex="1"
                                               class="form-control" value="${Email}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-bell"></i></span>
                                        <input type="date" name="profileDOB" id="profileDOBID" tabindex="1"
                                               class="form-control" value="">
                                    </div>
                                    <form action="" method="post"><input type="submit" value="Change Password"
                                                                         class="form-control btn btn-register"></form>
                                </fieldset>
                                <br>
                                <fieldset>
                                    <legend>Personal Information:</legend>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-user"></i></span>
                                        <div id="profileGenderButtons" class="btn-group-justified btn-group-md">
                                            <a class="btn btn-primary btn-md active" data-toggle="profileGender"
                                               data-title="Male">Male</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileGender"
                                               data-title="Female">Female</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileGender"
                                               data-title="Other">Other</a>
                                        </div>
                                        <input type="hidden" name="profileGender" id="profileGenderID">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-pencil"></i></span>
                                        <input type="text" name="profileOccupation" id="profileOccupationID"
                                               tabindex="1" class="form-control" placeholder="Occupation" value="">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-user"></i></span>
                                        <div id="profileEducationButtons" class="btn-group-justified btn-group-md">
                                            <a class="btn btn-primary btn-md active" data-toggle="profileEducation"
                                               data-title="primary">Primary</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"
                                               data-title="secondary">Secondary</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"
                                               data-title="tertiary">Tertiary</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"
                                               data-title="postgraduate">Postgraduate</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profileEducation"
                                               data-title="doctorate">Doctorate</a>
                                        </div>
                                        <input type="hidden" name="profileGender" id="profileEducationID">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-user"></i></span>
                                        <div class="btn-group-md">
                                            <a class="btn btn-primary btn-md active" data-toggle="profilePolitical"
                                               data-title="extremely_liberal">Extremely Liberal</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="liberal">Liberal</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="slightly_liberal">Slightly Liberal</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="neutral">Neutral</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="slightly_conservative">Slightly Conservative</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="conservative">Conservative</a>
                                            <a class="btn btn-primary btn-md notActive" data-toggle="profilePolitical"
                                               data-title="extremely_conservative">Extremely Conservative</a>
                                        </div>
                                        <input type="hidden" name="profilePolitical" id="profilePoliticalID">
                                    </div>
                                    <input data-slider-id="ex19" type="text"
                                           data-provide="slider"
                                           data-slider-ticks="[1, 2, 3]"
                                           data-slider-ticks-labels='["short", "medium", "long"]'
                                           data-slider-min="1"
                                           data-slider-max="3"
                                           data-slider-step="1"
                                           data-slider-value="3"
                                           data-slider-tooltip="hide">

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
