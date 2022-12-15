<html>
<head>

    <asset:stylesheet src="tableHandler.css"/>
    <asset:javascript src="/apli/tableHandler.js"/>
    <asset:javascript src="/apli/tableHandlerBody.js"/>


    <style type="text/css">
    .alineacion {
        text-align : right !important
    }
    .gris {
        background-color: #efefef;
        color: #a0a0a0;
    }

    </style>

</head>

<body>

<div id="tabla">

    %{--<table class="table table-bordered table-striped table-hover table-condensed" id="tablaPrecios">--}%
    <table class="table table-bordered table-hover table-condensed">
        %{--<thead style="background-color:#0074cc;">--}%
        <thead>
        <tr align="center">
            <th>C.</th>
            <th>Actividad</th>
            <th>Planificado</th>
            <th>Costo</th>
            <th>Ejecutado</th>
            <th>Cantidad</th>
            <th>Acumulado</th>
            <th>Ap. Extra</th>
            <th>Multas</th>
            <th>Intereses</th>
            <th>Actual</th>
            <th>Observaciones</th>
        </tr>
        </thead>
        <tbody>

        <g:each in="${avance}" var="avnc" status="i">
            <tr align="right">
                <td align="left" width="3%">${avnc?.compnmro}</td>
                <td align="left" width="22%">${avnc?.actvnmro} ${avnc?.actvdscr}</td>
                <td align="left" width="25%">${avnc?.plandscr}</td>
                <td align="left" width="6%">${avnc?.plancsto}</td>
                <td align="left" width="6%">${avnc?.plancntd}</td>
                <td align="left" width="6%">${avnc?.planejec}</td>
                <td align="left" width="6%">${avnc?.planejec}</td>
                <td align="left" width="6%">${avnc?.planejec}</td>
                <td align="left" width="6%">${avnc?.planejec}</td>
                <td align="left" width="6%">${avnc?.planejec}</td>
                <td class="editable" id="${avnc?.plan__id}"
                    data-original="${avnc?.avncvlor}" data-valor="${avnc?.avncvlor}"  data-plan="${avnc?.plan__id}"
                    data-obsrog="${avnc?.avncdscr}"
                    style="width:8%" title="Ingrese el valor y presione Enter para aceptarlo">
                    <g:formatNumber number="${avnc?.avncvlor?:0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
                </td>
                <td class="observaciones">
                        <g:textField name="avncdscr" class="ingrobsr form-control-sm required" value="${avnc?.avncdscr}"
                                     style="width: 100%"/>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    Total de registros visualizados: ${cuenta}<br/>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'tableHandler.js')}"></script>

    <script type="text/javascript">

        $(".btnCambiarEstado").click(function () {
            var id = $(this).data("id");
            bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-warning'></i>" + "<strong>" +  "Está seguro que desea cambiar el estado?" + "</strong>", function (res) {
                if (res) {
                    openLoader("Guardando...");
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'vivienda', action: 'cambiarEstado_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg){
                            closeLoader();
                            if(msg == 'ok'){
                                log("Estado cambiado correctamente","success");
                                setTimeout(function() {
                                    location.reload(true);
                                }, 1000);
                            }else{
                                log("Error al cambiar el estado","error");
                            }
                        }
                    });
                }
            });
        });

        $(".btnBorrarRegistro").click(function () {
            var persona = $(this).data("id");
            var obligacion = $(this).data("obl");
            bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i> Está seguro que desea poner en cero este registro?", function (res) {
                if (res) {
                    openLoader("Guardando Registro...");
                    $.ajax({
                        type    : "POST",
                        url : "${createLink(controller:'vivienda', action:'borrarRegistro_ajax')}",
                        data    : {
                            persona: persona,
                            obligacion: obligacion
                        },
                        success : function (msg) {
                            if(msg == 'ok'){
                                closeLoader();
                                log("Registro modificado correctamente","success");
                                setTimeout(function() {
                                    location.reload(true);
                                }, 1000);
                            }else{
                                closeLoader();
                                log("No se puede modificar este registro","error")
                            }
                        }
                    });
                }
            });
        });


        $(".todosCk").click(function () {
            var cc = $(".todosCk:checked").val();
            if(cc == 'on'){
                $(".seleccion").prop('checked',true);
            }else{
                $(".seleccion").prop('checked',false)
            }
        });


        function enviar(pag) {

            var reg = "RN";

            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'tabla')}",
                data    : {
                    oblg  : "${params.oblg}",
                    tipo  : "${params.tipo}"
                },
                success : function (msg) {
                    $("#divTabla").html(msg);
                }
            });

        }

        $(function () {
            $(".editable").first().addClass("selected");

            $(".num").click(function () {
                var num = $(this).attr("href");
                enviar(num);
                return false;
            });

        });


    </script>
</body>
</html>