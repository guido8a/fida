<html>
<head >

    <title>Detalle</title>

    %{--    <asset:stylesheet src="tableHandler.css"/>--}%
    %{--    <asset:javascript src="/apli/tableHandler.js"/>--}%
    %{--    <asset:javascript src="/apli/tableHandlerBody.js"/>--}%

    %{--    <style type="text/css">--}%
    %{--    .alineacion {--}%
    %{--        text-align : right !important--}%
    %{--    }--}%
    %{--    .gris {--}%
    %{--        background-color: #efefef;--}%
    %{--        color: #a0a0a0;--}%
    %{--    }--}%

    %{--    </style>--}%

</head>

<body>


    <table class="table table-bordered table-striped table-hover table-condensed" style="width: 100% ;background-color: #a39e9e">        %{--<thead style="background-color:#0074cc;">--}%
        <thead>
        <tr style="align-items: center">
            <th style="width: 4%">C.</th>
            <th style="width: 23%">Actividad</th>
            <th style="width: 27%">Planificado</th>
            <th style="width: 6%">Costo</th>
            <th style="width: 6%">Ejecutado</th>
            <th style="width: 6%">Cantidad</th>
            <th style="width: 6%">Acumulado</th>
            <th style="width: 6%">Ap. Extra</th>
            <th style="width: 6%">Multas</th>
            <th style="width: 6%">Intereses</th>
            <th style="width: 7%">Actual</th>
            <th style="width: 6%">Observaciones</th>
        </tr>
        </thead>
    </table>



%{--    <tbody>--}%
<div class=""  style="width: 99.7%;height: 585px; overflow-y: auto;float: right; margin-top: -20px">
    <table id="tablaB" class="table-bordered table-condensed table-hover" style="width: 100%">
    <g:each in="${avance}" var="avnc" status="i">
        <tr style="align-items: flex-end" data-avance="${avnc?.avnc__id}" data-plan="${avnc?.plan__id}">
            <td style="align-items: flex-start; width: 3%" >${avnc?.compnmro}</td>
            <td style="align-items: flex-start; width: 22%">${avnc?.actvnmro} ${avnc?.actvdscr}</td>
            <td style="align-items: flex-start; width: 25%">${avnc?.plandscr}</td>
            <td style="align-items: flex-start; width: 6%">${avnc?.plancsto}</td>
            <td style="align-items: flex-start; width: 6%">${avnc?.plancntd}</td>
            <td style="align-items: flex-start; width: 6%">${avnc?.planejec}</td>
            <td style="align-items: flex-start; width: 6%">${avnc?.planejec}</td>
            <td class="editarExtra" style="width: 6%">
                <g:formatNumber number="${avnc?.avncextr ?: 0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
            </td>
            <td class="editarMulta" style="width:6%">
                <g:formatNumber number="${avnc?.avncmlta ?: 0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
            </td>
            <td class="editarInteres" style="width:6%">
                <g:formatNumber number="${avnc?.avncintr ?: 0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
            </td>
            <td class="editarValor" style="width:6%">
                <g:formatNumber number="${avnc?.avncvlor ?: 0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>
            </td>
            %{--                <td class="editable" id="${avnc?.plan__id}"--}%
            %{--                    data-original="${avnc?.avncvlor}" data-valor="${avnc?.avncvlor}"  data-plan="${avnc?.plan__id}"--}%
            %{--                    data-obsrog="${avnc?.avncdscr}"--}%
            %{--                    style="width:8%" title="Ingrese el valor y presione Enter para aceptarlo">--}%
            %{--                    <g:formatNumber number="${avnc?.avncvlor?:0}" minFractionDigits="2" maxFractionDigits="2" format="##,##0" locale="ec"/>--}%
            %{--                </td>--}%

            %{--                <td class="observaciones">--}%
            %{--                        <g:textField name="avncdscr" class="ingrobsr form-control-sm required" value="${avnc?.avncdscr}"--}%
            %{--                                     style="width: 100%"/>--}%
            %{--                </td>--}%

            <td style="width:10%">
                ${avnc?.avncdscr}
            </td>
        </tr>
    </g:each>
%{--    </tbody>--}%
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
                            if(msg === 'ok'){
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
                            if(msg === 'ok'){
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
            if(cc === 'on'){
                $(".seleccion").prop('checked',true);
            }else{
                $(".seleccion").prop('checked',false)
            }
        });


        function enviar(pag) {

            // var reg = "RN";

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

            function editarValores(plan, avance) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'avance', action:'formValores_ajax')}",
                    data    : {
                        plan: plan,
                        informe: '${informe}',
                        avance: avance
                    },
                    success : function (msg) {
                        bm = bootbox.dialog({
                            id      : "dlgEditarValores",
                            title   : "Guardar Valores",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        return submitFormValores();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                    } //success
                }); //ajax
            } //createEdit

            function submitFormValores() {
                var $form = $("#frmAvance");
                $.ajax({
                    type: "POST",
                    url: $form.attr("action"),
                    data: $form.serialize(),
                    success: function (msg) {
                        if (msg === 'ok') {
                            log("Valores guardados correctamente", "success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 500);
                        } else {
                            log("Error al guardar los valores", "error")
                        }
                    }
                })
            }

            $("tbody>tr").contextMenu({
                items: {
                    header: {
                        label: "Acciones",
                        header: true
                    },
                    editar: {
                        label: "Editar valores",
                        icon: "fa fa-edit",
                        action: function ($element) {
                            var plan = $element.data("plan");
                            var avance = $element.data("avance");
                            editarValores(plan, avance);
                        }
                    }
                },
                onShow: function ($element) {
                    $element.addClass("success");
                },
                onHide: function ($element) {
                    $(".success").removeClass("success");
                }
            });
        });

    </script>
</body>
</html>