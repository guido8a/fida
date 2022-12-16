<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/09/20
  Time: 12:19
--%>
<html>
<head>
    <meta name="layout" content="main">
    <title>Detalle de Evaluaciones</title>
</head>
<body>

<h3>Detalle del Avance del Informe: ${informe.informeAvance.size() > 40? informe?.informeAvance[0..39] + '..' : informe?.informeAvance} </h3>

<fieldset class="borde">
    <div class="row" style="margin-bottom: 20px;">
        <div class="col-sm-2" align="center" style="margin-top: 20px">
            <a href="${createLink(controller: "informeAvance", action: "informe")}/?id=${informe?.administradorConvenio?.convenio?.id}"  class="btn btn-primary">
                <i class="fa fa-arrow-left"></i> Regresar al Informe
            </a>
        </div>

        <div class="btn-group col-sm-1" style="margin-top: 20px; margin-left: -20px; width: 150px">
            <a href="#" class="btn btn-azul" id="btn-consultar"><i class="fa fa-search"></i> Recargar Detalle</a>
        </div>
        <div class="btn-group col-sm-3" style="margin-top: 20px; margin-left: -0px; width: 300px;">
%{--            <a href="#" class="btn btn-success btn-actualizar"><i class="fa fa-save"></i> Guardar</a>--}%
        </div>

    </div>

</fieldset>

<input class="hidden" id="informe" value="${informe?.id}">

<fieldset class="borde" %{--style="width: 1170px"--}%>

    <div id="divTabla" style="height: 760px; overflow-y:auto; overflow-x: hidden;">

    </div>


    <fieldset class="borde hide" style="width: 1170px; height: 58px" id="error">

        <div class="alert alert-error">

            <h4 style="margin-left: 450px">No existen datos!!</h4>

            <div style="margin-left: 420px">
                Ingrese los parámetros de búsqueda!

            </div>
        </div>

    </fieldset>

</fieldset>


<script type="text/javascript">

    function consultar() {
        var info = "${informe?.id}";

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'tabla')}",
            data    : {
                info  : info
            },
            success : function (msg) {
                $("#divTabla").html(msg);
            }
        });
    }


    $(function () {

        consultar();

        $("#btn-consultar").click(function () {
            var lgar = $("#listaPrecio").val();
            if (lgar != -1) {
                $("#error").hide();
                consultar();
                $("#divTabla").show();
            } else {
                $("#divTabla").html("").hide();
                $("#error").show();
            }
        });

        $(".btn-actualizar").click(function () {
//                    $("#dlgLoad").dialog("open");
            var data = "";
            var info = "${informe?.id}";

            $(".editable").each(function () {
                var id = $(this).attr("id");
                var valor = $(this).data("valor");
                var data1 = $(this).data("original");
                var plan = $(this).data("plan");
                var obsrog = $(this).data("obsrog");

                var chk = $(this).siblings(".chk").children("input").is(":checked");
//                        console.log(chk);
                var obsr = $(this).siblings(".observaciones").children("input").val();

/*
                if (chk && (obsr != obsrog) && (inor)) {
                    if (data != '') {
                        data += "&"
                    }
                    data += "&obsr=" + id + "_inor" + inor + "_ob" + obsr
                }
*/
                console.log('obsr:',obsr !== '');
                if ((parseFloat(valor) > 0 && obsr !== '' && parseFloat(data1) !== parseFloat(valor) || (obsr !== obsrog) )) {
                    if (data !== "") {
                        data += "&";
                    }
                    var val = valor ? valor : data1;
                    // inpn__id  val  inor__id  ob
                    data += "&item=" + id + "_" + val + "_plan" + plan + "_ob" + obsr;// + "_" + chk;

                }
            });
//                    console.log('data -->', data);
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'avance', action: 'actualizar')}",
                data: data + "&info=" + info,
                success: function (msg) {
//                            $("#dlgLoad").dialog("close");
                    var parts = msg.split("_");
                    var ok = parts[0];
                    var no = parts[1];

                    $(ok).each(function () {
                        var fec = $(this).siblings(".fecha");
                        fec.text($("#fecha").val());
                        var $tdChk = $(this).siblings(".chk");
                        var chk = $tdChk.children("input").is(":checked");
                        if (chk) {
                            $tdChk.html('<i class="icon-ok"></i>');
                        }
                    });

                    doHighlight({elem: $(ok), clase: "ok"});
                    doHighlight({elem: $(no), clase: "no"});
                    $(ok).removeClass('gris');

                }
            });
        });
    });
</script>
</body>
</html>


