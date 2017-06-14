<%@ page import="java.util.List" %>
<%@ page import="Tree.InfoTree" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Tree.TreeDAO" %>
<%@ page import="Utility.MySQL" %>

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

        function revealDiv(id) {
            var search = id.search(/\d/);
            var idNumber = id.substring(search);

            var divID = "#infoContainerID" + idNumber;

            $(divID).show();
        }

        function hideDiv(id) {
            var search = id.search(/\d/);
            var idNumber = id.substring(search);

            var divID = "#infoContainerID" + idNumber;

            $(divID).hide();
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
    <div style="position:fixed; color: gold; top: 0px; background-color: white; font-size: xx-large">
        <p>The mouse pointer position is at: <span></span></p>
    </div>

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
            double size = tree.getSize() / 100;
            int X = tree.getCoordinX();
            int Y = tree.getCoordinY();
            int likes = tree.getLikes();
            int views = tree.getViews();
            int ID = tree.getId();
    %>
    <div class="container" id="treeContainerID<%= ID%>" style="position: absolute; top: <%=Y%>px; left: <%=X%>px;">
        <div id="imageContainerID<%= ID%>">
            <a href="/Serve_FullTree?TreeID=<%=ID%>"><img id="treeImageID<%= ID%>" onmouseover="revealDiv(this.id);" onmouseout="hideDiv(this.id);"
                    src="<%= sitePath%>tree_TRIAL/Tree_Material/Venusaur_stage_<%=stage%>.png"></a>
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
    <%}%>

</div>
</body>
</html>


