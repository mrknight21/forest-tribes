<script>

    $(document).ready(function () {

        $(".slider").css("margin", "10px").css("width", "400px");
        $("#zoom-control").slider({
            value: 100,
            min: 20,
            max: 200,
            step: 10,
            slide: function (event, ui) {
                var zoom = ui.value + "%";
                $("#myiframe").contents().find("body").css("zoom", zoom);
                $("#zoom-control-lable").html(zoom);
            }
        });

        $("#background_selector").change(function () {
            var background = $("#background_selector").val();
            var url = "url('Tree_Material/" + background + "\')";
            $("#myiframe").contents().find("#map").css("background-image", url);
        });

    })


function StopLoader() {
$("#loader").remove();
console.log("finish loading!!")
}
</script>


<style>
   #background_selector{

   }
</style>