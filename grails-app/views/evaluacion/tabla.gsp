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
            <th width="40%">Indicador</th>
            <th>Valor</th>
            <th>Aplicar <g:checkBox name="ck_name" style="margin-left: 10px" class="todosCk" /></th>
            <th>Observaciones</th>
%{--            <th>Borrar</th>--}%
        </tr>
        </thead>
        <tbody>

        <g:each in="${indicadores}" var="indicador" status="i">
            <tr align="right">
                <td align="left" width="11%">
                    ${indicador?.inordscr}
                </td>
                <td class="editable" id="${indicador?.inpn__id}"
                    data-original="${indicador?.original}" data-valor="100"  data-ingr="${indicador?.inpn__id}"
                    data-obsrog="${indicador?.obsr}"
                    style="width:12%" title="Ingrese el valor y presione Enter para aceptarlo">
                    <g:formatNumber number="100" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
                </td>
                <td style="text-align: center;" class="chk">
%{--                    <g:if test="${!Pago.findAllByIngreso(condominio.Ingreso.get(indicador?.ingr__id))?.estadoAdministrador?.contains("S")}">--}%
%{--                        <g:if test="${!Pago.findAllByIngreso(Ingreso.get(indicador.ingr__id))}">--}%
                            <g:checkBox name="ckl" class="seleccion"/>
%{--                        </g:if>--}%
%{--                    </g:if>--}%
                </td>
                <td class="observaciones">
%{--                    <g:if test="${!Pago.findAllByIngreso(condominio.Ingreso.get(indicador?.ingr__id))?.estadoAdministrador?.contains("S")}">--}%
                        <g:textField name="obsr" class="ingrobsr form-control-sm" value="${indicador?.obsr}" style="width: 100%"/>
%{--                    </g:if>--}%
%{--                    <g:else>--}%
%{--                        <g:textField name="obsr" class="ingrobsr form-control-sm" value="${indicador?.ingrobsr}" style="width: 100%" readonly=""/>--}%
%{--                    </g:else>--}%
                </td>
%{--
                <td style="text-align: center">
                    <g:if test="${indicador?.ingrvlor}">
                        <g:if test="${!Pago.findAllByIngreso(condominio.Ingreso.get(indicador?.ingr__id))?.estadoAdministrador?.contains("S")}">
                            <g:if test="${!Pago.findAllByIngreso(Ingreso.get(indicador.ingr__id))}">
                                <a href="#" class="btn btn-danger btn-xs btnBorrarRegistro" data-id="${indicador?.prsn__id}" data-obl="${oblg.id}" title="Eliminar registro"><i class="fa fa-trash"></i> </a>
                            </g:if>
                            <g:if test="${indicador.ingretdo != 'B'}">
                                <g:if test="${band}">
                                    <a href="#" class="btn btn-success btn-xs btnCambiarEstado" data-id="${indicador?.ingr__id}" title="Cambiar estado"><i class="fa fa-check"></i> </a>
                                </g:if>
                            </g:if>
                        </g:if>
                    </g:if>
                </td>
--}%
            </tr>
        </g:each>
        </tbody>
    </table>

    Total de registros visualizados: ${params.totalRows}<br/>

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
//                    if ($("#reg").hasClass("active")) {
//                        reg += "R";
//                    }
//                    if ($("#nreg").hasClass("active")) {
//                        reg += "N";
//                    }
//
//                    if (reg == "") {
//                        $("#reg").addClass("active");
//                        $("#nreg").addClass("active");
//                        reg = "RN";
//                    }

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