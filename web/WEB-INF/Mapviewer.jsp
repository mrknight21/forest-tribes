<script>

    $(document).ready(function () {

$(".slider").css("margin","10px").css("width","400px");
$("#zoom-control").slider({
value: 100,
min: 20,
max: 200,
step: 10,
slide: function (event, ui) {
var zoom = ui.value+ "%" ;
$("#myiframe").contents().find("body").css("zoom", zoom);
$("#zoom-control-lable").html(zoom);
}
});

});

function StopLoader() {
$("#loader").remove();
console.log("finish loading!!")
}
</script>


<style>
    /* Center the loader */
    #loader {
        position: fixed;
        left: 50%;
        top: 50%;
        z-index: 1;
        width: 150px;
        height: 150px;
        margin: -75px 0 0 -75px;
        border: 16px solid #f3f3f3;
        border-radius: 50%;
        border-top: 16px solid #3498db;
        width: 120px;
        height: 120px;
        -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
    }

    @-webkit-keyframes spin {
        0% { -webkit-transform: rotate(0deg); }
        100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Add animation to "page content" */
    .animate-bottom {
        position: relative;
        -webkit-animation-name: animatebottom;
        -webkit-animation-duration: 1s;
        animation-name: animatebottom;
        animation-duration: 1s
    }
</style>