<%--
  Created by IntelliJ IDEA.
  User: Barns
  Date: 5/06/17
  Time: 11:24 AM
  To change this template use File | Settings | File Templates.
--%>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <style>
        .full {
            background: url('lake-baikal-9.jpg') no-repeat center center fixed;
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
            src: url('Plumpfull.ttf');
        }

        @font-face {
            font-family: Amperzand;
            src: url('Amperzand.ttf');
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
                            <form id="profileFormID" action="" method="post" role="form" style="display: block">
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
                                        <div id="radioBtn" class="btn-group-justified btn-group-md">
                                            <a class="btn btn-primary btn-sm active" data-toggle="profileGender"
                                               data-title="Male">Male</a>
                                            <a class="btn btn-primary btn-sm notActive" data-toggle="profileGender"
                                               data-title="Female">Female</a>
                                            <a class="btn btn-primary btn-sm notActive" data-toggle="profileGender"
                                               data-title="Else">Else</a>
                                        </div>
                                        <input type="hidden" name="profileGender" id="profileGenderID">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-pencil"></i></span>
                                        <input type="text" name="profileOccupation" id="profileOccupationID"
                                               tabindex="1" class="form-control" placeholder="Occupation" value="">
                                    </div>

                                    <h5>Education Level:</h5>
                                    <p><em>Please select the highest applicable level</em></p>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profileEducation" id="profileEduPrimaryID"
                                               value="Primary">
                                        <label for="profileEduPrimaryID">Primary</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profileEducation" id="profileEduSecondaryID"
                                               value="Secondary">
                                        <label for="profileEduSecondaryID">Secondary</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profileEducation" id="profileEduTertiaryID"
                                               value="Tertiary">
                                        <label for="profileEduTertiaryID">Tertiary</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profileEducation" id="profileEduPostID"
                                               value="Postgraduate">
                                        <label for="profileEduPostID">Postgraduate</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profileEducation" id="profileEduDoctorateID"
                                               value="Doctorate">
                                        <label for="profileEduDoctorateID">Doctorate or above</label>
                                    </div>

                                    <h5>Political Orientation:</h5>
                                    <p><em>Please select the most applicable orientation</em></p>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalExLibID"
                                               value="Extremely Liberal">
                                        <label for="profilePoliticalExLibID">Extremely Liberal</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalLibID"
                                               value="Liberal">
                                        <label for="profilePoliticalLibID">Liberal</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalSliLibID"
                                               value="Slightly Liberal">
                                        <label for="profilePoliticalSliLibID">Slightly Liberal</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalNeutralID"
                                               value="Neutral">
                                        <label for="profilePoliticalNeutralID">Neutral</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalSliConID"
                                               value="Slightly Conservative">
                                        <label for="profilePoliticalSliConID">Slightly Conservative</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalConID"
                                               value="Conservative">
                                        <label for="profilePoliticalConID">Conservative</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" name="profilePolitical" id="profilePoliticalExConID"
                                               value="Extremely Conservative">
                                        <label for="profilePoliticalExConID">Extremely Conservative</label>
                                    </div>
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
    $('#radioBtn a').on('click', function () {
        var sel = $(this).data('title');
        var tog = $(this).data('toggle');
        $('#' + tog).prop('value', sel);

        $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
        $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');
    })
</script>
</body>
</html>
