<%@ page import="proyectos.MarcoLogico; proyectos.Cronograma; parametros.Mes; parametros.Anio" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Cronograma del proyecto</title>

    <script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-get-input-type', file: 'jquery.get-input-type.min.js')}"></script>

    <style type="text/css">
    table {
        font-size : 9pt;
    }

    td, th {
        vertical-align : middle !important;
    }

    .divTabla {
        max-height : 450px;
        overflow-y : auto;
        overflow-x : auto;
    }

    tr:hover .disabled {
        background : #ccc !important;
    }

    tfoot {
        font-size : larger;
    }

    .st{
        font-weight: bold;
        text-align: center;
    }

    .fnt{
        font-size: 14px;
    }

    </style>

</head>

<body>
<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="proyecto" action="list" params="${params}" class="btn btn-sm btn-default">
            <i class="fa fa-list"></i> Lista de proyectos
        </g:link>
    </div>

    <div class="btn-group">
        <g:if test="${editable}">
        <a href="#" class="btn btn-sm btn-default" id="btnGenerar">
            <i class="fa fa-briefcase"></i> Generar asignaciones del proyecto
        </a>
        </g:if>
        <g:link controller="asignacion" action="asignacionProyectov2" id="${proyecto.id}" class="btn btn-sm btn-default">
            <i class="fa fa-dollar-sign"></i> Asignaciones
        </g:link>
    </div>
    <g:if test="${params.act}">
        <div class="btn-group">
            <g:link controller="marcoLogico" action="marcoLogicoProyecto" id="${proyecto.id}" class="btn btn-sm btn-default"
                    params="[list: params.list]">
                <i class="fa fa-calendar-o"></i> Plan de proyecto
            </g:link>
        </div>
    </g:if>
</div>

<g:if test="${proyecto.aprobado == 'a'}">
    <div class="alert alert-info">
        El proyecto está aprobado, no puede modificar el cronograma
    </div>
</g:if>

<div class="panel-primary " style="text-align: center; font-size: 14px; margin-bottom: 10px">
    <strong>Editar Conograma de: </strong> <strong style="color: #5596ff; "> ${proyecto?.nombre}</strong>
</div>

<elm:container tipo="vertical" titulo="Cronograma" color="black">

%{--
        <div class="divIndice ">
            <g:each in="${componentes}" var="comp">
                <a href="#comp${comp.id}" class="scrollComp ">
                    <strong>Componente ${comp.numero}</strong>:
                ${(comp.objeto.length() > 100) ? comp.objeto.substring(0, 100) + "..." : comp.objeto}
                </a>
            </g:each>
        </div>
--}%

    <div class="divTabla">
        <g:render template="/templates/tablaCrono" model="[anio: anio, componentes: componentes, actSel: false]"/>
    </div>
</elm:container>

<div class="modal fade" id="modalCronoVer">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalTitleVer">Cronograma</h4>
            </div>

            <div class="modal-body">
                <div class="alert alert-info">
                    <div id="divActividadVer"></div>

                    <div id="divInfoVer" class="text-warning"></div>
                </div>

                <div class="row">
                    <div class="col-md-3 show-label">Presupuesto (1)</div>

                    <div class="col-md-9" id="div_presupuesto1"></div>
                </div>

                <div class="row">
                    <div class="col-md-3 show-label">Partida (1)</div>

                    <div class="col-md-9" id="div_bsc-desc-partida1"></div>
                </div>

                <div class="row">
                    <div class="col-md-3 show-label">Fuente (1)</div>

                    <div class="col-md-9" id="div_desc-fuente1"></div>
                </div>
                <hr/>

                <div class="row">
                    <div class="col-md-3 show-label">Presupuesto (2)</div>

                    <div class="col-md-9" id="div_presupuesto2"></div>
                </div>

                <div class="row">
                    <div class="col-md-3 show-label">Partida (2)</div>

                    <div class="col-md-9" id="div_bsc-desc-partida2"></div>
                </div>

                <div class="row">
                    <div class="col-md-3 show-label">Fuente (2)</div>

                    <div class="col-md-9" id="div_desc-fuente2"></div>
                </div>
            </div>

            <div class="modal-footer">
                <a href="#" class="btn btn-default" id="btnModalCancelVer">Cerrar</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    function armaParams() {
        var params = "";
        if ("${params.search_programa}" != "") {
            params += "search_programa=${params.search_programa}";
        }
        if ("${params.search_nombre}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_nombre=${params.search_nombre}";
        }
        if ("${params.search_desde}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_desde=${params.search_desde}";
        }
        if ("${params.search_hasta}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_hasta=${params.search_hasta}";
        }
        if (params != "") {
            params = "&" + params;
        }
        return params;
    }

    function enviarDos() {
        var data = "";
        openLoader();
        $(".crit").each(function () {
            data += "&campos=" + $(this).attr("campo");
            data += "&operadores=" + $(this).attr("operador");
            data += "&criterios=" + $(this).attr("criterio");
        });
        if (data.length < 2) {
            data = "tc=" + $("#tipoCampo").val() + "&campos=" + $("#campo :selected").val() + "&operadores=" + $("#operador :selected").val() + "&criterios=" + $("#criterio").val()
        }
        data += "&ordenado=" + $("#campoOrdn :selected").val() + "&orden=" + $("#orden :selected").val();
        $.ajax({
            type    : "POST", url : "${g.createLink(controller: "cronograma",action: "buscarPresupuesto")}",
            data    : data,
            success : function (msg) {
                $(".contenidoBuscador").html(msg).show("slide");
                closeLoader();
            }
        });
    }

    function resetForm() {
        $("#presupuesto1").val("");
        $("#bsc-desc-partida1").val("");
        $("#partida1").val("");
        $("#fuente1").find("option").first().attr("selected");

        $("#presupuesto2").val("");
        $("#bsc-desc-2").val("");
        $("#partida2").val("");
        $("#fuente2").find("option").first().attr("selected");
    }

    function setForm($td) {
        $.each($td.data(), function (key, val) {
            var id = key.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
            var $field = $("#" + id);
            if ($field.length > 0) {
                // var type = $field.getInputType();
                var type = $field.getInputField();
                if (type == "select") {
                    if (val == "") {
                        $field.find("option").first().prop("selected");
                    } else {
                        $field.val(val);
                    }
                } else {
                    $field.val(val);
                }
            }
        });
        var $ntd = $td;
        var partida1 = $ntd.data("partida1");
        var descPartida1 = $ntd.data("bsc-desc-partida1");
//                var partida2 = $ntd.data("partida2");
//                var descPartida2 = $ntd.data("bsc-desc-partida2");

        if (!partida1 /*&& !partida2*/) {
            var actividad = false;
            while (!partida1 && !actividad) {
                $ntd = $ntd.prev();
                actividad = $ntd.hasClass("actividad");
                partida1 = $ntd.data("partida1");
                descPartida1 = $ntd.data("bsc-desc-partida1");
//                        partida2 = $ntd.data("partida2");
//                        descPartida2 = $ntd.data("bsc-desc-partida2");
            }
            $("#partida1").val(partida1);
//                    $("#partida2").val(partida2);
            $("#bsc-desc-partida1").val(descPartida1);
//                    $("#bsc-desc-partida2").val(descPartida2);
        }
    }

    function setDivs($td) {
        $.each($td.data(), function (key, val) {
            var id = key.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
            var $div = $("#div_" + id);
            if ($div.length > 0) {
                if (id == "presupuesto1" || id == "presupuesto2") {
                    $div.text(number_format(val, 2, ".", ","));
                } else {
                    $div.text(val);
                }
            }
        });
    }

    $(function () {

        var editable = {};
        var borrable = {};
        var poneEdit = "${editable}"

        %{--console.log('editable', "${editable}", poneEdit);--}%
        if (poneEdit === 'true') {
            // console.log('define editable');
            editable = {
                label  : "Editar",
                icon   : "fa fa-edit text-info",
                action : function ($element) {
                    var id = $element.data("id");
                    var $tr = $element.parents("tr");
                    var index = $element.index() - 1;

                    var $mes = $("#trMeses").children().eq(index);
                    var mes = $mes.attr("title");
                    // $('#modalCrono').modal("show");
                    // $("#modalTitle").text("Cronograma - " + mes);

                    // if (!$("#divOk").hasClass("hidden")) {
                    var $actividad = $tr.find(".actividad");
                    var $asignado = $tr.find(".asignado");
                    var $sinAsignar = $tr.find(".sinAsignar");
                    var $total = $tr.find(".total");
                    //
                    var actividad = $actividad.attr("title");
                    var asignado = $asignado.data("val");
                    var sinAsignar = $sinAsignar.data("val");
                    var total = $total.data("val");

                    var actividadId = $actividad.parent().data("id");
                    var mesesId = $mes.data("id");

                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller: 'cronograma', action:'editarCrono_ajax')}",
                        data    : {
                            proyecto: '${proyecto?.id}',
                            anio: '${anio?.id}',
                            total: total,
                            asignado: asignado,
                            sinAsignar: sinAsignar,
                            actividad: actividad,
                            id: id
                        },
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id    : "dlgCreateEditCrono",
                                title : "Editar Cronograma",
                                class : "modal-md",
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
                                            guardarCronograma(mesesId,actividadId);
                                            return false;
                                        } //callback
                                    } //guardar
                                } //buttons
                            }); //dialog
                        } //success
                    }); //ajax
                }
            }

            borrable = {
                label            : "Eliminar",
                    icon             : "fa fa-trash text-danger",
                    separator_before : true,
                    action           : function ($element) {
                    var id = $element.data("id");

                    bootbox.dialog({
                        title   : "Alerta",
                        message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar toda la información del registro del cronograma seleccionado?<br/>" +
                            "Esta acción no se puede deshacer.</p>",
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            eliminar : {
                                label     : "<i class='fa fa-trash-o'></i> Eliminar",
                                className : "btn-danger",
                                callback  : function () {
                                    openLoader("Eliminando valores");
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(action:'deleteCrono_ajax')}',
                                        data    : {
                                            id : id
                                        },
                                        success : function (msg) {
                                            var parts = msg.split("*");
                                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                            if (parts[0] == "SUCCESS") {
                                                setTimeout(function () {
                                                    location.reload(true);
                                                }, 1000);
                                            } else {
                                                closeLoader();
                                            }
                                        },
                                        error   : function () {
                                            closeLoader();
                                            log("Ha ocurrido un error interno", "error");
                                        }
                                    });
                                }
                            }
                        }
                    });
                }
            }

        } else {
            // console.log('anula editable');
            editable = {}
            borrable = {}
        }


        $(".comp").each(function () {
            var id = $(this).attr("id");
            var actividades = $(".act." + id);
            if (actividades.length == 0) {
                $(this).hide();
                $(".total." + id).hide();
            }
        });

        var validator = $(".frmCrono").validate({
            errorClass     : "help-block",
            rules          : {
                presupuesto1 : {
//                            tdnMax     : function () {
//                                var $fuente = $("#fuente1");
//                                var id = $fuente.val();
//                                var valor = parseFloat($fuente.find("option:selected").attr("class"));
//                                var usado = 0;
//                                $(".fnte_" + id).each(function () {
//                                    usado += parseFloat($(this).data("val"));
//                                });
//                                return valor - usado;
//                            },
                    tdnMaxSuma : {
                        params : ["#presupuesto2", "#divInfo", "sinAsignar", "asignado"]
                    }
                },
                presupuesto2 : {
//                            tdnMax     : function () {
//                                var $fuente = $("#fuente2");
//                                var id = $fuente.val();
//                                var valor = parseFloat($fuente.find("option:selected").attr("class"));
//                                var usado = 0;
//                                $(".fnte_" + id).each(function () {
//                                    usado += parseFloat($(this).data("val"));
//                                });
//                                return valor - usado;
//                            },
                    required   : {
                        depends : function (element) {
                            var v1 = $.trim($("#bsc-desc-2").val());
                            return v1 != "";
                        }
                    },
                    tdnMaxSuma : {
                        params : ["#presupuesto1", "#divInfo", "sinAsignar", "asignado"]
                    }
                },
                "bsc-desc-partida2" : {
                    required : {
                        depends : function (element) {
                            var v1 = $.trim($("#presupuesto2").val());
                            return v1 != "";
                        }
                    }
                }
            },
            messages       : {
                presupuesto1 : {
                    tdnMaxSuma : "Por favor ingrese un valor inferior al por asignar"
                },
                presupuesto2 : {
                    tdnMaxSuma : "Por favor ingrese un valor inferior al por asignar"
                }
            },
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
        });

        $("#btnModalCancel").click(function () {
            validator.resetForm();
            resetForm();
            $(".has-error").removeClass("has-error");
            $('#modalCrono').modal("hide");
            return false;
        });
        $("#btnModalCancelVer").click(function () {
            $('#modalCronoVer').modal("hide");
            return false;
        });

        $("#btnModalSave").click(function () {
            var $frm = $(".frmCrono");
            if ($frm.valid()) {
                var $div = $("#divInfo");
                var data = $frm.serialize();
                data += "&id=" + $div.data("crono") + "&mes=" + $div.data("mes") + "&anio=${anio.id}" + "&act=" + $div.data("actividad");
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : $frm.attr("action"),
                    data    : data,
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        if (parts[0] == "SUCCESS") {
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
                                }
                            }, 1000);
                        } else {
                            closeLoader();
                        }
                    }
                });
            }
            return false;
        });

        $(".nop").contextMenu({
            items  : {
                header : {
                    label  : "Sin acciones",
                    header : true
                }
            },
            onShow : function ($element) {
                $element.addClass("success");
            },
            onHide : function ($element) {
                $(".success").removeClass("success");
            }
        });
        $(".clickable").contextMenu({
            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                ver      : {
                    label  : "Ver",
                    icon   : "fa fa-search",
                    action : function ($element) {
                        var id = $element.data("id");
                        var $tr = $element.parents("tr");
                        var index = $element.index() - 1;

                        var $mes = $("#trMeses").children().eq(index);
                        var mes = $mes.attr("title");
                        $('#modalCronoVer').modal("show");
                        $("#modalTitleVer").text("Cronograma - " + mes);

                        var $actividad = $tr.find(".actividad");
                        var $asignado = $tr.find(".asignado");
                        var $sinAsignar = $tr.find(".sinAsignar");
                        var $total = $tr.find(".total");

                        var actividad = $actividad.attr("title");
                        var asignado = $asignado.data("val");
                        var sinAsignar = $sinAsignar.data("val");
                        var total = $total.data("val");

                        $("#divActividadVer").text(actividad);
                        $("#divInfoVer").html("<ul>" +
                            "<li><strong>Monto total:</strong> $" + number_format(total, 2, ".", ",") + "</li>" +
                            "<li><strong>Asignado:</strong> $" + number_format(asignado, 2, ".", ",") + "</li>" +
                            "<li><strong>Por asignar:</strong> $" + number_format(sinAsignar, 2, ".", ",") + "</li>" +
                            "</ul>").data({
                            total      : total,
                            asignado   : asignado,
                            sinAsignar : sinAsignar,
                            crono      : id,
                            mes        : $mes.data("id"),
                            actividad  : $tr.data("id")
                        });
                        setDivs($element);
                    }
                },
                editar: editable,
                eliminar: borrable
             },
            onShow : function ($element) {
                $element.addClass("success");
            },
            onHide : function ($element) {
                $(".success").removeClass("success");
            }
        });

        var $container = $(".divTabla");
        $container.scrollTop(0 - $container.offset().top + $container.scrollTop());
        $("#anio").change(function () {
            openLoader();
            location.href = "${createLink(controller: 'cronograma', action: 'form', id: proyecto.id)}?anio=" + $("#anio").val() +
                armaParams() + "&act=${actSel?.id}";
        });

        $(".scrollComp").click(function () {
            var $scrollTo = $($(this).attr("href"));
            $container.animate({
                scrollTop : $scrollTo.offset().top - $container.offset().top + $container.scrollTop()
            });
            return false;
        });

        $("#btnGenerar").click(function () {
            var msg = "<i class='fa fa-exclamation-triangle fa-4x pull-left text-danger text-shadow'></i><p>" +
                "<p class='lead st fnt'>¿Está seguro que desea generar las asignaciones del P.A.I. del año señalado?</p>" +
                "</br> <p class='lead fnt'> * Las asignaciones generadas anteriormente serán <span class='text-danger'><strong>ELIMINADAS</strong></span> " +
                "así como su programación.</p>" +
                "<p class='lead fnt'> * Los datos borrados no podrán ser recuperados.</p> " +
                "<p class='lead text-warning fnt'> * Esta acción será registrada en log del sistema junto con su usuario</p>";
            bootbox.confirm(msg, function (result) {
                if (result) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'calcularAsignaciones_ajax')}",
                        data    : {
                            anio     : "${anio.id}",
                            proyecto : "${proyecto.id}"
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
//                                            if (id) {
                                    location.href = "${createLink(controller: 'asignacion', action: 'asignacionProyectov2', params:[id:proyecto.id, anio:anio.id])}";
//                                            }
                                }
                                closeLoader();
                            }, 1000);
                        }
                    });
                }
            });
        });

        /* **************** AQUI LO DEL BUSCADOR *********************************/

        var $btnDlg = $("#buscarDialog");

        $(".bsc_desc").click(function () {
            $("#" + $(this).attr("dialog")).modal("show");
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviar();
            });
        }).focus(function () {
            $("#" + $(this).attr("dialog")).modal("show");
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviar();
            });
        });
        $(".bsc_desc-2").click(function () {
            $("#" + $(this).attr("dialog")).modal("show");
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviar();
            });
        }).focus(function () {
            $("#" + $(this).attr("dialog")).modal("show");
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviarDos();
            });
        });
        $("#btn-abrir-partida1").unbind("click").bind("click", function () {
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviar();
            });
            $("#modal-partida1").modal("show")
        });

        $(".buscador-2").click(function () {
            $(".contenidoBuscador").html("");
            $btnDlg.unbind("click");
            $btnDlg.bind("click", function () {
                enviarDos();
            });
            $(".modal-search").modal("show")
        });

        function guardarCronograma(mes, actividad) {
            var $frm = $(".frmCrono");
            if ($frm.valid()) {
                var $div = $("#divInfo");
                var data = $frm.serialize();
                data += "&anio=" + '${anio?.id}' + "&act=" + actividad + "&mes=" + mes;
                var dialog = cargarLoader("Guardando...");
                $.ajax({
                    type    : "POST",
                    url     : $frm.attr("action"),
                    data    : data,
                    success : function (msg) {

                        var parts = msg.split("*");
                        if (parts[0] == "SUCCESS") {
                            dialog.modal("hide");
                            log(parts[1], "success");
                            setTimeout(function () {
                                    location.reload(true);
                            }, 1000);
                        }else{
                            dialog.modal("hide");
                            if(parts[0] == 'er'){
                                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                return false;
                            }else{
                                log(parts[1], "error");
                            }
                        }
                    }
                });
            }
            // return false;
        }
    });
</script>

</body>
</html>