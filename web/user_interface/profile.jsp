<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 3/06/2017
  Time: 2:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Editing_profile</title>
</head>
<body>
<h1>Editing profile</h1>
<form action="/Serve_Registration" method="post">

    <fieldset>
        <legend>membership information</legend>
        <p>User: ${username}</p>
        <p></p>
        <p>Password: <form action="" method="post"><input type="submit" value="Change pass word"></form></p>
        <label for="dateOfBirthID">Your date of birth:</label>
        <input type="text" id="dateOfBirthID" name="DateOfBirth" placeholder="DD/MM/YYYY"/>
        <p></p>
        <label for="emailID">Email: </label>
        <input type="email" id="emailID" name="email" placeholder="Email" value="${email}"/>
        <p></p>


    </fieldset>
    <fieldset>
        <legend>Personal profile</legend>
        <p></p>
        <p>Gender: </p>
        <label for="gender1">Male</label>
        <input id="gender1" type="radio"  class= "genderRadio" name="gender" value="male"/>
        <label for="gender2"> Female</label>
        <input id="gender2" type="radio" name="gender" class= "genderRadio" value="female">
        <label for="gender3"> Else</label>
        <input id="gender3" type="radio" name="gender" class= "genderRadio" value="else">
        <p></p>

        <p></p>
        <label for="occupationId">Occupation: </label>
        <input type="text" id="occupationId" name="occupation" placeholder="occupation"/>
        <p></p>

        <p></p>
        <label for="educationId">Education level: </label>
        <input type="text" id="educationId" name="education_level" placeholder="education" list="educationLevels"/>
        <datalist id="educationLevels">
            <option value="Primary school"></option>
            <option value="Secondary education"></option>
            <option value="Tertiary education"></option>
            <option value="Postgraduates"></option>
            <option value="Doctorate or above"></option>
        </datalist>
        <p></p>
        <p>Political Orientation:</p>
        <label for="extreme_liberal"> extreme liberal</label>
        <input id="extreme_liberal" type="radio"  class= "politicalOriRadio" name="politicalOri" value="extreme_liberal"/>
        <label for="liberal"> liberal</label>
        <input id="liberal" type="radio" name="politicalOri" class= "politicalOriRadio" value="liberal">
        <label for="gender3"> slightly_liberal</label>
        <input id="slightly_liberal" type="radio" name="politicalOri" class= "politicalOriRadio" value="slightly_liberal">
        <label for="neutral">neutral</label>
        <input id="neutral" type="radio"  class= "politicalOriRadio" name="politicalOri" value="neutral"/>
        <label for="gender2"> slightly conservative</label>
        <input id="slightly_conservative" type="radio" name="politicalOri" class= "politicalOriRadio" value="slightly_conservative">
        <label for="conservative"> conservative</label>
        <input id="conservative" type="radio" name="politicalOri" class= "politicalOriRadio" value="conservative">
        <label for="extremely_conservative"> extremely conservative</label>
        <input id="extremely_conservative" type="radio" name="politicalOri" class= "politicalOriRadio" value="extremely_conservative">
        <p></p>
        <label for="thingsLoved">Things you love:  </label>
        <input type="text" name="thingsLoves" id="thingsLoved"/>
        <p></p>
    </fieldset>

    <fieldset>
        <legend>The issues you care:  </legend>
        <input type="checkbox" name="issuesCared" value="poverty" id="poverty">
        <label for="poverty"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-01.png" width="100" height="100"></label>



        <input type="checkbox" name="issuesCared" value="hunger" id="hunger">
        <label for="hunger"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-02.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="health And wellbeing" id="health and wellbeing">
        <label for="health and wellbeing"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-03.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="education" id="education">
        <label for="education"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-04.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="gender equality" id="gender equality">
        <label for="gender equality"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-05.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="clean water" id="water">
        <label for="water"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-06.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="sustainable energy" id="sustainable energy">
        <label for="sustainable energy"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-07.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="word And Economy" id="word And Economy">
        <label for="word And Economy"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-08.png" width="120" height="120"></label>


        <input type="checkbox" name="issuesCared" value="Innovation and Infrastructure" id="Innovation and Infrastructure">
        <label for="Innovation and Infrastructure"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-09.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="reduce inequality" id="reduce inequality">
        <label for="reduce inequality"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-10.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="community development" id="community development">
        <label for="community development"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-11.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="consumption and production" id="consumption and production">
        <label for="consumption and production"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-12.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="climate" id="climate">
        <label for="climate"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-13.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="water life" id="water life">
        <label for="water life"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-14.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="life on land" id="life on land">
        <label for="life on land"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-15.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="peace and justice" id="peace and justice">
        <label for="peace and justice"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-16.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="cooperation" id="cooperation">
        <label for="cooperation"><img src="../images_material/E%20Icons_WEB/E%20Inverted%20Icons_RGB/E_INVERTED%20SDG%20goals_icons-individual-RGB-17.png" width="120" height="120"></label>

        <input type="checkbox" name="issuesCared" value="else" id="else">
        <label for="else"><img src="../images_material/Default/question-mark_318-52837.jpg" width="120" height="120"></label>

    </fieldset>
    <p></p>
    <fieldset>
        <legend>About you:    </legend>
        <textarea id="additionalComment ID" name="profile_text_area" rows="6" cols="80"></textarea>
    </fieldset>
    <p></p>
    <input type="submit" value="Create an Account"/>
    <input type="reset" value="Clear"/>
</form>

</body>
</html>
