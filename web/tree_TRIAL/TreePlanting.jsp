<%--
  Created by IntelliJ IDEA.
  User: mche618
  Date: 13/06/2017
  Time: 8:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Plant your tree</title>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script>
        $( function() {
            $("#seed").click(function () {
                console.log("click");
                $("body").css("cursor", "url(\"Tree_Material/sprout_hand.png\"), default");
                $("#myiframe").contents().find("#map").css("cursor", "url(\"Tree_Material/sprout_hand.png\"), default");
                $("#seed").css("display", "none");
                $(this).css("pointer-events", "none");
                $("#myiframe").contents().find("#map").click(function () {

                    var X = $("#myiframe").contents().find("#X").val();
                    var Y = $("#myiframe").contents().find("#Y").val();
                    var Xcoor = X + "px";
                    var Ycoor = Y + "px";
                    $("#myiframe").contents().find("#map").append("<img src='Tree_Material/Venusaur_stage_1.png' id='new_seed'>")
                    $("#myiframe").contents().find("#new_seed").css("top", Xcoor).css("left", Ycoor).css("position", "absolute");
                    $("#Xcoordinate").val(Y);
                    $("#Ycoordinate").val(X);
                    $(this).off("click");
                    $("body").css("cursor", "");
                    $("#myiframe").contents().find("#map").css("cursor", "");
                });
            });


           /* $("#myiframe").keydown(function(event){
                //up
                if (event.keyCode == 38){
                    $("#myiframe").contentWindow.scrollTo( ,ycoord)
                }
                //right
                if (event.keyCode == 39){

                }
                //left
                if (event.keyCode == 37){

                }
                //down
                if (event.keyCode == 40){

                }

            });*/


            $("#restart").click(function () {
                $("#myiframe").contents().find("#new_seed").remove();
                $("#seed").css("display", "initial");
                $("#seed").css("pointer-events", "auto");
            })
        });
        // $("#myiframe").contents().find("#myContent")
    </script>
</head>
<body>
<h1>Plant your BIG ISSUE!!</h1>

<p></p>
<form action="/">
    <label for="title">The name of your Big issue:</label>
    <input id="title" type="text" name="title" width="250px">
    <p></p>
    <label for="description">Tell use more about it:</label>
    <br>
    <textarea id="description" name="shortIntro" rows="6" cols="80">Please tell more about your tree...</textarea>
    <p></p>
    <div id="seed" >
        <p>click me to plant your tree!!</p>
        <img  src="Tree_Material/sprout.png">
    </div>
    <p></p>
    <label for>Coordinate: </label>
    <input type="number" value="0" id="Xcoordinate" name="X" readonly>
    <input type="number" value="0" id="Ycoordinate" name="Y" readonly>
    <input type="submit" value="Confirm location, and go further tree editing">
    <input id="restart" type="reset" value="Click to restart planting">
</form>
<p></p>
<iframe class="whole"  name="iframe_a" id="myiframe" src="ForestTribe.jsp" frameborder=0 height="750px" width="1000px" scrolling="auto">
    <p>Your browser does not support iframes.</p>
</iframe>


</body>
</html>
