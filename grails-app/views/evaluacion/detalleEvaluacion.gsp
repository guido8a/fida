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

<h3>Detalle de la Evaluación: ${evaluacion.descripcion} - ${evaluacion.planesNegocio.unidadEjecutora.nombre} </h3>

<fieldset class="borde">
    <div class="row" style="margin-bottom: 20px;">
        <div class="col-sm-2" align="center" style="margin-top: 20px">
            <a href="${createLink(controller: "planesNegocio", action: "evaluaciones")}/?id=${plns.id}"  class="btn btn-primary">
                <i class="fa fa-arrow-left"></i> Regresar a Evaluaciones
            </a>
        </div>

        <div class="btn-group col-sm-1" style="margin-top: 20px; margin-left: -20px; width: 150px">
            <a href="#" class="btn btn-azul" id="btn-consultar"><i class="fa fa-search"></i> Desplegar Indicadores</a>
        </div>
        <div class="btn-group col-sm-3" style="margin-top: 20px; margin-left: -0px; width: 300px;">
            <a href="#" class="btn btn-success btn-actualizar"><i class="fa fa-save"></i> Guardar</a>
%{--            <a href="#" class="btn btn-warning btn-generar" style="margin-left: 5px"><i class="fa fa-users"></i> Generar Alíc.</a>--}%
        </div>

    </div>

</fieldset>


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
        var oblg = $("#obligaciones").val();

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'tabla')}",
            data    : {
                oblg  : oblg
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

            var fcha = $("#fechaOb").val();
            var oblg = $("#obligaciones").val();

            $(".editable").each(function () {
                var id = $(this).attr("id");
                var valor = $(this).data("valor");
                var data1 = $(this).data("original");
                var ingr = $(this).data("ingr");
                var obsrog = $(this).data("obsrog");

                console.log('valor', valor);
                var chk = $(this).siblings(".chk").children("input").is(":checked");
//                        console.log(chk);
                var obsr = $(this).siblings(".observaciones").children("input").val();

                if (chk && (obsr != obsrog) && (ingr)) {
//                            console.log('obsr:', obsr, 'obsrog:', obsrog);
                    if (data != '') {
                        data += "&"
                    }
                    data += "&obsr=" + id + "_id" + ingr + "_ob" + obsr
//                            console.log('obsr:', obsr, 'data:', data);
                }
//                        console.log('data:', data)
                if (chk && (parseFloat(valor) > 0 && parseFloat(data1) != parseFloat(valor))) {
                    if (data != "") {
                        data += "&";
                    }
                    var val = valor ? valor : data1;
                    if (obsr != obsrog) {
                        data += "&item=" + id + "_" + val + "_id" + ingr + "_ob" + obsr;// + "_" + chk;
                    } else {
                        data += "&item=" + id + "_" + val + "_id" + ingr;// + "_" + chk;
                    }

                }
            });
//                    console.log('data -->', data);
            $.ajax({
                type: "POST",
                url: "${createLink(action: 'actualizar')}",
                data: data + "&fecha=" + fcha + "&oblg=" + oblg,
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


