<%@ page import="java.util.List" %>
<%@ page import="Tree.InfoTree" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Tree.TreeDAO" %>
<%@ page import="Utility.MySQL" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <base target="_parent">
    <meta charset="UTF-8">
    <title>Title</title>

    <%--Importing all necessary libraries, frameworks etc.--%>
    <%@include file="../WEB-INF/Head_Scripts.jsp" %>
    <script>













        $(document).ready(function () {
            $(document).mousemove(function (event) {
                $("#X").val(event.pageY);
                $("#Y").val(event.pageX);
                $("span").text("X: " + event.pageX + ", Y: " + event.pageY);
            });
        });



        $(".slider").css("margin","10px").css("width","400px");
        $("#zoom-control").slider({
            value: 100,
            min: 20,
            max: 200,
            step: 10,
            slide: function (event, ui) {
                var zoom = ui.value+ "%" ;
                $("body").css("zoom", zoom)
            }
        });



        function revealDiv(id) {
            var search = id.search(/\d/);
            var idNumber = id.substring(search);

            var divID = "#infoContainerID" + idNumber;

            $(divID).css("zIndex", 999);
            $(divID).show();
        }

        function hideDiv(id) {
            var search = id.search(/\d/);
            var idNumber = id.substring(search);

            var divID = "#infoContainerID" + idNumber;

            $(divID).hide();
            $(divID).css("zIndex", 1);
        }
    </script>
    <style>
        body {
            background-image: url("Tree_Material/Mars.jpg");
            zoom: 100%;
        }
    </style>
</head>
<body>
<div id="map" style=" width: 10000px; height: 10000px;">




    <form>
        <input type="hidden" value="0" id="X">
        <input type="hidden" value="0" id="Y">
    </form>
    <div style="position:fixed; color: seashell; top: 0px; font-size: xx-large; font-family: 'Californian FB'">
        <p>The Current position is : <span></span></p>
    </div>

    <form>
        <div slider container style="position:fixed; top: 0%; left: 35%;">
            <label for="zoom-control" style="color: seashell;font-size: xx-large; font-family: 'Californian FB';">Zoom Control:</label>
            <div class="slider" id="zoom-control"></div>
        </div>
    </form>

    <a href="#top_right_portal" target="iframe_a"><img id="top_left_portal"
                                                       src="<%=sitePath%>tree_TRIAL/Tree_Material/Portal.png"
                                                       height="400px" width="400px" style="position: absolute;"></a>
    <a href="#bottom_right_portal" target="iframe_a"><img id="top_right_portal"
                                                          src="<%=sitePath%>tree_TRIAL/Tree_Material/Portal.png"
                                                          height="400px" width="400px"
                                                          style="position: absolute;left: 9600px"></a>
    <a href="#top_left_portal" target="iframe_a"><img id="bottom_left_portal"
                                                      src="<%=sitePath%>tree_TRIAL/Tree_Material/Portal.png"
                                                      height="400px" width="400px"
                                                      style="position: absolute;left: 0px; top: 9600px;"></a>
    <a href="#bottom_left_portal" target="iframe_a"><img id="bottom_right_portal"
                                                         src="<%=sitePath%>tree_TRIAL/Tree_Material/Portal.png"
                                                         height="400px" width="400px"
                                                         style="position: absolute;left: 9600px; top: 9600px;"></a>
    <a href="www.google.co.nz"><img
            src="http://vignette2.wikia.nocookie.net/pokemon/images/3/32/007Squirtle_AG_anime.png/revision/latest?cb=20140916184312"
            style="position:absolute;top:1000px; left: 2000px;"></a>
    <a href="www.google.co.nz"><img
            src="http://vignette2.wikia.nocookie.net/pokemon/images/3/32/007Squirtle_AG_anime.png/revision/latest?cb=20140916184312"
            style="position:absolute; top: 2000px; left: 3000px"></a>
    <a href="http://girlwithacamera.co.uk/"> <img
            src="http://img03.deviantart.net/b415/i/2011/253/b/4/tree_48_png_by_gd08-d49eqww.png"
            style="position:absolute; top: 3000px; left: 2500px"></a>
    <a href="http://girlwithacamera.co.uk/"> <img id="hello"
                                                  src="http://img03.deviantart.net/b415/i/2011/253/b/4/tree_48_png_by_gd08-d49eqww.png"
                                                  style="position:absolute; top: 3500px; left: 3000px"></a>
    <a href="https://www.smashingmagazine.com/2014/02/making-embedded-content-work-in-responsive-design/"></a> <img
        src="https://s-media-cache-ak0.pinimg.com/originals/a2/5e/70/a25e702c21e995b7794d1cada0ae5c81.png"
        style="position:absolute; top: 4000px; left: 1500px"></a>
    <img src="https://s-media-cache-ak0.pinimg.com/originals/a2/5e/70/a25e702c21e995b7794d1cada0ae5c81.png"
         style="position:absolute; top: 500px; left: 1000px">
    <img src="https://s-media-cache-ak0.pinimg.com/originals/a2/5e/70/a25e702c21e995b7794d1cada0ae5c81.png"
         style="position:absolute; top: 4000px; left: 4000px">

    <%
        MySQL DB = new MySQL();
        List<InfoTree> trees = new ArrayList<>();
        Map<Integer, Integer> userTreesID = new HashMap<>();
        String username = (String)session.getAttribute("username");
        trees = TreeDAO.geAllInfoTrees(DB);


        for (InfoTree tree : trees) {

            /*private String title;
    private List<T_URL> factual;
    private List<T_URL> commentary;
    private List<T_Reaction> reactoin;
    private int stage;
    private int size;
    private int exp;
    private int coordinX;
    private int coordinY;
    private int leaves;


    /* protected int id;
    protected String author;
    protected String dateCreated;
    protected String dateLastEdited;
    protected int likes;
    protected String text;
    protected int views;*/

            String title = tree.getTitle();
            String author = tree.getAuthor();
            int stage = tree.getStage();
            double size = ((double)tree.getSize()/125);
            System.out.println(size);
            int X = tree.getCoordinX();
            int Y = tree.getCoordinY();
            int likes = tree.getLikes();
            int views = tree.getViews();
            int ID = tree.getId();
            if(username.equals(author)){
                userTreesID.put(ID, stage);
            }

    %>
    <div class="container" id="treeContainerID<%= ID%>" style="position: absolute; top: <%=Y%>px; left: <%=X%>px;">
        <div id="imageContainerID<%= ID%>">
            <a href="/Serve_FullTree?TreeID=<%=ID%>"><img id="treeImageID<%= ID%>" onmouseover="revealDiv(this.id);" onmouseout="hideDiv(this.id);"
                    src="<%= sitePath%>tree_TRIAL/Tree_Material/stage_0<%=stage%>.png" style="-webkit-transform: scale(<%=size%>);-moz-transform: scale(<%=size%>);-ms-transform: scale(<%=size%>);-o-transform: scale(<%=size%>);transform: scale(<%=size%>);"></a>
        </div>
        <div class="panel panel-default" id="infoContainerID<%= ID%>" style="display: none; width: 200px; border-color: #008975;">
            <div class="panel-heading" style="background-color: #008975; border-color: #00AA8D; color: white;">
                <p style="font-family: Futura; word-wrap: break-word;"><%=title%></p>
            </div>
            <div class="panel-footer">
                <p style="display: inline-block; padding-right: 1%;"><i class="fa">&#xf2bd;</i>
                    Author: <%= author%></p>
                <p style="display: inline-block; padding-right: 1%;"><img src="<%= sitePath%>tree_TRIAL/Tree_Material/flower.png" style="width: 30px">
                    Likes: <%= likes%></p>
                <p style="display: inline-block; padding-right: 1%;"><img src="<%= sitePath%>tree_TRIAL/Tree_Material/leaf.png" style="width: 30px">
                    Views: <%= views%></p>
            </div>
        </div>
    </div>
    <%}



    if (userTreesID.size() != 0){
    %>
    <div id="userTressBar" style="position: fixed; left:0%; top:10%; width:200px;">
        <% for(Map.Entry<Integer, Integer> tree : userTreesID.entrySet()){ %>
        <div class=" small_tree_container">
            <a href="#treeContainerID<%=tree.getKey()%>"><img src="<%= sitePath%>tree_TRIAL/Tree_Material/stage_0<%=tree.getValue()%>.png" width="75px"></a>
        </div>
        <%}
        }%>
    </div>
</div>
</body>
</html>


