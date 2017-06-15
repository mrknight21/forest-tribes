<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="Utility.SecurityUtility" %>
<%@ page import="User.UserDAO" %>
<%@ page import="User.User" %>
<%@ page import="User.Profile" %>
<%@ page import="Utility.MySQL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");

    final MySQL DB = new MySQL();

    User user = UserDAO.getUserByUserName(DB, username);

    String email = user.getEmail();

    Profile profile = UserDAO.getProfile(DB, username);

    String gender = null;

    System.out.println(profile.getGender());

    if (profile.getGender() != null) {
        gender = profile.getGender();
    }

    String occupation = null;

    if (profile.getOccupation() != null) {
        occupation = profile.getOccupation();
    } else {
        occupation = "";
    }

    String education = null;

    if (profile.getEducation() != null) {
        education = profile.getEducation();
    }

    String political = null;

    if (profile.getPolitical() != null) {
        political = profile.getPolitical();
    }

    String issues = null;

    if (profile.getIssues() != null) {
        issues = profile.getIssues();
    }

%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Forest Tribes: Your profile</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="WEB-INF/Head_Scripts.jsp" %>

    <script>

        <%--Function to enable JQuery UI elements--%>
        $(function () {
            $("input[type='radio']").checkboxradio();
            $(".form-group").controlgroup();
        });

        <%--Function to determine whether the checkbox elements should be checked.--%>
        <%--Checkbox elements should only be checked if the user has updated their profile before.--%>
        function checkedStatus(input, id) {

            if (input !== "null") {
                if (input.indexOf(" ") > -1) {
                    input = input.replace(/ /g, "");
                    input = input.replace(/,/g, "");
                }

                var elementID = "#profile" + id + input + "ID";
                $(elementID).prop('checked', true);
                $(elementID).checkboxradio("refresh");
            }
        }

        <%--Function to check inputted passwords match each other--%>
        function checkPasswordMatch() {
            var password = $("#profileDeletePasswordID").val();
            var confirmPassword = $("#profileDeleteConfirmPasswordID").val();

            if (password !== confirmPassword) {
                $("#profileDeleteSubmitID").prop('disabled', true);
                $("#profileMessageID").show();
            } else {
                $("#profileDeleteSubmitID").prop('disabled', false);
                $("#profileMessageID").hide();
            }
        }

        $(document).ready(function () {
            $("#profileDeleteConfirmPasswordID").keyup(checkPasswordMatch);

            var gender = "<%= gender%>";
            checkedStatus(gender, "Radio");

            var education = "<%= education%>";
            checkedStatus(education, "Radio");

            var political = "<%= political%>";
            checkedStatus(political, "Radio");

            var issues = "<%= issues%>";
            console.log(issues);
            var issuesArray = issues.split(", ");

            issuesArray.forEach(function (i) {
                if (i !== "") {
                    checkedStatus(i, "Issues");
                }
            });
        });

    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Profile/>
</head>
<body>

<%@ include file="WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-6">
                            <a href="<%=sitePath%>Serve_Profile" class="active" id="profileUpdateLink"><i class="fa">&#xf044;</i>
                                Update your
                                Profile</a>
                        </div>
                        <div class="col-xs-6">
                            <a href="<%=sitePath%>Serve_DeleteUser" id="profileDeleteLink"><i class="fa">&#xf085;</i>
                                Delete your Profile</a>
                        </div>
                    </div>
                    <hr>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <p id="statusMessage" style="text-align: center">${message}</p>
                            <fieldset id="profilePictureFieldsetID" class="span4">
                                <legend><i class="fa">&#xf083;</i> Profile Picture</legend>
                                <div id="profileImageDiv" class="col-lg-10 col-lg-offset-1">
                                    <div class="thumbnail">
                                        <img id="profileImage"
                                             src="<%=sitePath%>User/<%= username%>/User_profile_picture.jpg"
                                             class="img-responsive" alt="User Profile Picture">
                                    </div>
                                </div>
                                <form id="profileChangePPFormID" action="<%=sitePath%>Serve_UpdateProfilePicture"
                                      method="post"><input type="submit"
                                                           value="Change Profile Picture"
                                                           class="btn btn-primary btn-block">
                                </form>
                            </fieldset>
                            <br>

                            <fieldset id="profileMembershipFieldsetID" class="span4">
                                <legend><i class="fa">&#xf2ba;</i> Membership Information</legend>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" name="profileUpdateUsername" id="profileUpdateUsernameID"
                                           tabindex="1"
                                           value="<%=username%>" class="form-control" readonly>
                                </div>
                                <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-envelope"></i></span>
                                    <input type="email" name="profileEmail" id="profileEmailID" tabindex="1"
                                           class="form-control" value="<%= email%>">
                                </div>
                                <form id="profileChangePWFormID" action="<%=sitePath%>Serve_Changepassword"
                                      method="post"><input type="submit"
                                                           value="Change Password"
                                                           class="btn btn-primary btn-block">
                                </form>
                            </fieldset>
                            <br>

                            <form id="profileUpdateFormID" action="<%=sitePath%>Serve_Profile" method="post" role="form"
                                  style="display: block">

                                <fieldset id="profilePersonalFieldsetID">
                                    <legend><i class="fa">&#xf2b9;</i> Personal Information</legend>

                                    <fieldset id="profileGenderFieldsetID">
                                        <legend><i class="fa">&#xf224;</i> Gender:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioMaleID">Male</label>
                                            <input type="radio" name="profileGender" id="profileRadioMaleID"
                                                   value="Male">
                                            <label for="profileRadioFemaleID">Female</label>
                                            <input type="radio" name="profileGender" id="profileRadioFemaleID"
                                                   value="Female">
                                            <label for="profileRadioOtherID">Other</label>
                                            <input type="radio" name="profileGender" id="profileRadioOtherID"
                                                   value="Other">
                                        </div>
                                    </fieldset>
                                    <fieldset id="profileOccupationFieldsetID">
                                        <legend><i class="fa">&#xf0b1;</i> Occupation:</legend>
                                        <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-pencil"></i></span>
                                            <input type="text" name="profileOccupation" id="profileOccupationID"
                                                   tabindex="1" class="form-control" placeholder="Occupation"
                                                   value="<%= occupation%>">
                                        </div>
                                    </fieldset>
                                    <fieldset id="profileEducationFieldsetID">
                                        <legend><i class="fa">&#xf19d;</i> Education:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioPrimaryID">Primary</label>
                                            <input type="radio" name="profileEducation" id="profileRadioPrimaryID"
                                                   value="Primary">
                                            <label for="profileRadioSecondaryID">Secondary</label>
                                            <input type="radio" name="profileEducation" id="profileRadioSecondaryID"
                                                   value="Secondary">
                                            <label for="profileRadioTertiaryID">Tertiary</label>
                                            <input type="radio" name="profileEducation" id="profileRadioTertiaryID"
                                                   value="Tertiary">
                                            <label for="profileRadioPostgraduateID">Postgraduate</label>
                                            <input type="radio" name="profileEducation" id="profileRadioPostgraduateID"
                                                   value="Postgraduate">
                                            <label for="profileRadioDoctorateID">Doctorate</label>
                                            <input type="radio" name="profileEducation" id="profileRadioDoctorateID"
                                                   value="Doctorate">
                                        </div>
                                    </fieldset>
                                    <fieldset id="profilePoliticalFieldsetID">
                                        <legend><i class="fa">&#xf19c;</i> Political Orientation:</legend>
                                        <div class="form-group">
                                            <label for="profileRadioExtremelyLiberalID">Extremely Liberal</label>
                                            <input type="radio" name="profilePolitical"
                                                   id="profileRadioExtremelyLiberalID"
                                                   value="Extremely Liberal">
                                            <label for="profileRadioLiberalID">Liberal</label>
                                            <input type="radio" name="profilePolitical" id="profileRadioLiberalID"
                                                   value="Liberal">
                                            <label for="profileRadioSlightlyLiberalID">Slightly Liberal</label>
                                            <input type="radio" name="profilePolitical"
                                                   id="profileRadioSlightlyLiberalID"
                                                   value="Slightly Liberal">
                                            <label for="profileRadioCentristID">Centrist</label>
                                            <input type="radio" name="profilePolitical" id="profileRadioCentristID"
                                                   value="Centrist">
                                            <label for="profileRadioSlightlyConservativeID">Slightly
                                                Conservative</label>
                                            <input type="radio" name="profilePolitical"
                                                   id="profileRadioSlightlyConservativeID"
                                                   value="Slightly Conservative">
                                            <label for="profileRadioConservativeID">Conservative</label>
                                            <input type="radio" name="profilePolitical" id="profileRadioConservativeID"
                                                   value="Conservative">
                                            <label for="profileRadioExtremelyConservativeID">Extremely
                                                Conservative</label>
                                            <input type="radio" name="profilePolitical"
                                                   id="profileRadioExtremelyConservativeID"
                                                   value="Extremely Conservative">
                                        </div>
                                    </fieldset>
                                    <fieldset id="profileIssuesFieldsetID">
                                        <legend><i class="fa">&#xf0a1;</i> The issues you care about:</legend>
                                        <div id="profileIssuesID" class="form-group">
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-01.png"
                                                    class="img-thumbnail img-check" alt="No Poverty"><input
                                                    type="checkbox"
                                                    name="profileIssuesPoverty"
                                                    id="profileIssuesNoPovertyID"
                                                    value="No Poverty"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-02.png"
                                                    class="img-thumbnail img-check" alt="Zero Hunger"><input
                                                    type="checkbox"
                                                    name="profileIssuesHunger"
                                                    id="profileIssuesZeroHungerID"
                                                    value="Zero Hunger"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-03.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Good Health and Well-Being"><input
                                                    type="checkbox"
                                                    name="profileIssuesHealth"
                                                    id="profileIssuesGoodHealthandWell-BeingID"
                                                    value="Good Health and Well-Being"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-04.png"
                                                    class="img-thumbnail img-check" alt="Quality Education"><input
                                                    type="checkbox"
                                                    name="profileIssuesEducation"
                                                    id="profileIssuesQualityEducationID"
                                                    value="Quality Education"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-05.png"
                                                    class="img-thumbnail img-check" alt="Gender Equality"><input
                                                    type="checkbox"
                                                    name="profileIssuesGender"
                                                    id="profileIssuesGenderEqualityID"
                                                    value="Gender Equality"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-06.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Clean Water and Sanitation"><input
                                                    type="checkbox"
                                                    name="profileIssuesWater"
                                                    id="profileIssuesCleanWaterandSanitationID"
                                                    value="Clean Water and Sanitation"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-07.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Affordable and Clean Energy"><input
                                                    type="checkbox"
                                                    name="profileIssuesEnergy"
                                                    id="profileIssuesAffordableandCleanEnergyID"
                                                    value="Affordable and Clean Energy"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-08.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Decent Work and Economic Growth"><input
                                                    type="checkbox"
                                                    name="profileIssuesEconomic"
                                                    id="profileIssuesDecentWorkandEconomicGrowthID"
                                                    value="Decent Work and Economic Growth"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-09.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Industry, Innovation and Infrastructure"><input
                                                    type="checkbox"
                                                    name="profileIssuesInnovation"
                                                    id="profileIssuesIndustryInnovationandInfrastructureID"
                                                    value="Industry, Innovation and Infrastructure"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-10.png"
                                                    class="img-thumbnail img-check" alt="Reduced Inequality"><input
                                                    type="checkbox"
                                                    name="profileIssuesInequality"
                                                    id="profileIssuesReducedInequalityID"
                                                    value="Reduced Inequality"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-11.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Sustainable Cities and Communities"><input
                                                    type="checkbox"
                                                    name="profileIssuesCommunity"
                                                    id="profileIssuesSustainableCitiesandCommunitiesID"
                                                    value="Sustainable Cities and Communities"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-12.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Responsible Consumption and Production"><input
                                                    type="checkbox"
                                                    name="profileIssuesConsumption"
                                                    id="profileIssuesResponsibleConsumptionandProductionID"
                                                    value="Responsible Consumption and Production"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-13.png"
                                                    class="img-thumbnail img-check" alt="Climate Action"><input
                                                    type="checkbox"
                                                    name="profileIssuesClimate"
                                                    id="profileIssuesClimateActionID"
                                                    value="Climate Action"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-14.png"
                                                    class="img-thumbnail img-check" alt="Life below Water"><input
                                                    type="checkbox"
                                                    name="profileIssuesWaterLife"
                                                    id="profileIssuesLifebelowWaterID"
                                                    value="Life below Water"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-15.png"
                                                    class="img-thumbnail img-check" alt="Life on Land"><input
                                                    type="checkbox"
                                                    name="profileIssuesLandLife"
                                                    id="profileIssuesLifeonLand"
                                                    value="Life on Land"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-16.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Peace, Justice and Strong Institutions"><input
                                                    type="checkbox"
                                                    name="profileIssuesPeace"
                                                    id="profileIssuesPeaceJusticeandStrongInstitutionsID"
                                                    value="Peace, Justice and Strong Institutions"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                            <div class="col-lg-3"><label class="btn btn-primary"><img
                                                    src="<%=sitePath%>images_material/E Icons_WEB/Square_RGB/E_SDG goals_icons-individual-rgb-17.png"
                                                    class="img-thumbnail img-check"
                                                    alt="Partnerships for the Goals"><input
                                                    type="checkbox"
                                                    name="profileIssuesPartnerships"
                                                    id="profileIssuesPartnershipsfortheGoalsID"
                                                    value="Partnerships for the Goals"
                                                    class="hidden"
                                                    autocomplete="off"></label>
                                            </div>
                                        </div>
                                    </fieldset>

                                </fieldset>
                                <br>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <input type="submit" name="profileUpdateSubmit" id="profileUpdateSubmitID"
                                               class="btn btn-primary btn-block"
                                               value="Update your Profile">
                                    </div>
                                </div>

                            </form>

                            <form id="profileDeleteFormID" action="<%=sitePath%>Serve_DeleteUser" method="GET"
                                  role="form"
                                  style="display: none;">
                                <p id="profileDeleteWarningID" style="text-align: center">Warning: This action can not
                                    be undone.</p>
                                <br>
                                <fieldset>
                                    <legend>Delete your profile:</legend>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" name="profileDeleteUsername" id="profileDeleteUsernameID"
                                               tabindex="1" required
                                               class="form-control" placeholder="Username" value="<%= username%>"
                                               readonly>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password" name="profileDeletePassword" id="profileDeletePasswordID"
                                               tabindex="2" required
                                               class="form-control" placeholder="Password">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password" name="profileDeleteConfirmPassword"
                                               id="profileDeleteConfirmPasswordID" tabindex="3"
                                               class="form-control" placeholder="Confirm Password" required
                                               onchange="checkPasswordMatch();">
                                    </div>
                                    <p id="profileMessageID" style="text-align: center; display: none">The entered-in
                                        passwords do not match. Please try again.</p>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <input type="submit" name="profileDeleteSubmit" id="profileDeleteSubmitID"
                                                   class="btn btn-block btn-danger"
                                                   value="Delete your profile">
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $('#profileUpdateLink').click(function (e) {
            $("#profilePictureFieldsetID").delay(100).fadeIn(100);
            $("#profileUpdateFormID").delay(100).fadeIn(100);
            $("#profileChangePPFormID").delay(100).fadeIn(100);
            $("#profileChangePWFormID").delay(100).fadeIn(100);
            $("#profileMembershipFieldsetID").delay(100).fadeIn(100);
            $("#profilePersonalFieldsetID").delay(100).fadeIn(100);
            $("#profileGenderFieldsetID").delay(100).fadeIn(100);
            $("#profileOccupationFieldsetID").delay(100).fadeIn(100);
            $("#profileEducationFieldsetID").delay(100).fadeIn(100);
            $("#profilePoliticalFieldsetID").delay(100).fadeIn(100);
            $("#profileIssuesFieldsetID").delay(100).fadeIn(100);
            $("#profileUpdateSubmitID").delay(100).fadeIn(100);
            $("#profileDeleteFormID").fadeOut(100);
            $('#profileDeleteLink').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
        $('#profileDeleteLink').click(function (e) {
            $("#profileDeleteFormID").delay(100).fadeIn(100);
            $("#profilePictureFieldsetID").fadeOut(100);
            $("#profileUpdateFormID").fadeOut(100);
            $("#profileChangePPFormID").fadeOut(100);
            $("#profileChangePWFormID").fadeOut(100);
            $("#profileMembershipFieldsetID").fadeOut(100);
            $("#profilePersonalFieldsetID").fadeOut(100);
            $("#profileGenderFieldsetID").fadeOut(100);
            $("#profileOccupationFieldsetID").fadeOut(100);
            $("#profileEducationFieldsetID").fadeOut(100);
            $("#profilePoliticalFieldsetID").fadeOut(100);
            $("#profileIssuesFieldsetID").fadeOut(100);
            $("#profileUpdateSubmitID").fadeOut(100);
            $('#profileUpdateLink').removeClass('active');
            $(this).addClass('active');
            e.preventDefault();
        });
    });
</script>
</body>
</html>
