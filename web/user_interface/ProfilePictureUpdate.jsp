<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import="Utility.SecurityUtility" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.awt.*" %>
<%@ page import="User.UserDAO" %>
<%@ page import="User.User" %>
<%@ page import="Utility.MySQL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (!SecurityUtility.loggingStatusChecker(request)) response.sendRedirect("../login_interface/Login.jsp");
    String username = (String) session.getAttribute("username");
    String imagePath = sitePath + "User/" + username + "/User_profile_picture.jpg";

//    MySQL DB = new MySQL();
//    User user = UserDAO.getUserByUserName(DB, username);
//    String imagePath = user.getProfileImagePath();

%>

<!DOCTYPE html>
<html lang="en" class="full">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
    <title>Profile_Image Update</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>


    <script>

        <%--Function to enable JQuery UI elements--%>
        $(function () {
            $("input[type='radio']").checkboxradio();
        });

        <%--Function to only enable the submitting of a user uploaded photo--%>
        <%--if an actual photo has been specified.--%>
        function checkEmptyInput() {
           var file = $("#changePictureUploadInputID").val();

           if (file !== null) {
               $("#changePictureUploadSubmitID").prop('disabled', false);
           }
        }
    </script>

    <%--Page Specific CSS--%>
    <tags:Style_Change-Profile-Picture/>

</head>
<body>

<%@ include file="../WEB-INF/Header_Navbar.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 style="text-align: center"><i class="fa">&#xf1bb;</i> Forest Tribes</h1>
                            <h4 id="subtitle" style="text-align: center">The Beauty of Interconnectedness</h4>
                            <br>
                            <fieldset>
                                <legend><i style="font-size:24px" class="fa">&#xf03e;</i> Your Current Profile Picture:
                                </legend>
                                <a href="<%=imagePath%>"><img id="userImageID" src="<%=imagePath%>"
                                                              class="img-rounded"
                                                              alt="User Profile Picture" height="400"></a>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form id="select_default_options" action="<%=sitePath%>Serve_UpdateProfilePicture"
                                  method="GET">
                                <fieldset>
                                    <legend id="pictureChoiceDefaultID"><i style="font-size:24px"
                                                                           class="fa">&#xf046;</i> Default Choices:
                                    </legend>
                                    <div class="form-group">
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_1.jpg"><input
                                                    id="option1"
                                                    type="radio"
                                                    name="DP_option"
                                                    value="default_options/default_options_1.jpg"
                                                    autocomplete="off"/><img
                                                    src="<%=sitePath%>default_options/default_options_1.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_2.jpg"><input
                                                    id="option2"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_2.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_2.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="<%=sitePath%>default_options/default_options_3.jpg"><input
                                                    id="option3"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_3.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_3.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="<%=sitePath%>default_options/default_options_4.jpg"><input
                                                    id="option4"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_4.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_4.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_5.gif"><input
                                                    id="option5"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_5.gif"/><img
                                                    src="<%=sitePath%>default_options/default_options_5.gif"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_6.jpg"><input
                                                    id="option6"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_6.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_6.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"> <a
                                                    href="<%=sitePath%>default_options/default_options_7.jpg"><input
                                                    id="option7"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_7.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_7.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_8.jpg"><input
                                                    id="option8"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_8.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_8.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_9.jpg"><input
                                                    id="option9"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_9.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_9.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/default_options_10.jpg"><input
                                                    id="option10"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/default_options_10.jpg"/><img
                                                    src="<%=sitePath%>default_options/default_options_10.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                        <div class="col-lg-4">
                                            <label class="btn btn-primary"><a
                                                    href="<%=sitePath%>default_options/Userdefault.jpg"><input
                                                    id="default"
                                                    type="radio"
                                                    class="default_DP_Options"
                                                    name="DP_option"
                                                    value="default_options/Userdefault.jpg"
                                                    checked/><img
                                                    src="<%=sitePath%>default_options/Userdefault.jpg"
                                                    class="img-thumbnail"></a></label>
                                        </div>
                                    </div>
                                    <div id="changePictureDefaultDivID" class="col-lg-12">
                                        <input type="submit" name="changePictureDefault"
                                               id="changePictureDefaultSubmitID"
                                               class="form-control btn btn-register"
                                               value="Change profile picture">
                                    </div>
                                </fieldset>
                            </form>
                            <br>
                            <form id="upload_own_photo" action="<%=sitePath%>Serve_UpdateProfilePicture" method="post"
                                  enctype="multipart/form-data">
                                <fieldset>
                                    <legend><i style="font-size:24px" class="fa">&#xf0ee;</i> Upload your own
                                        Photo:
                                    </legend>
                                    <div id="changePictureUploadDivID" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-file"></i></span>
                                        <input class="btn btn-primary" type="file" name="pic" id="changePictureUploadInputID"
                                               accept="image/*" onchange="checkEmptyInput()">
                                    </div>
                                    <br>
                                    <div class="col-lg-12">
                                        <input type="submit" name="changePictureUpload" id="changePictureUploadSubmitID"
                                               class="form-control btn btn-register"
                                               value="Change profile picture" disabled>
                                    </div>
                                </fieldset>
                                <br>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
