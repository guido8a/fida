%{--<%@ page import="vesta.proyectos.MarcoLogico; vesta.proyectos.Cronograma; vesta.parametros.poaPac.Mes; vesta.parametros.poaPac.Anio" contentType="text/html;charset=UTF-8" %>--}%
<html>
<head>

    <meta name="layout" content="main">
    <title>Cronograma del proyecto</title>

    <style type="text/css">
    table {
        font-size : 9pt;
    }

    td, th {
        vertical-align : middle !important;
    }

    .divTabla {
        max-height : 550px;
        overflow-y : auto;
        overflow-x : auto;
    }

    tfoot {
        font-size : larger;
    }
    </style>

</head>

<body>
%{--        ${anio.estado} proy: ${proyecto.aprobado}--}%
%{--        <g:set var="editable" value="${anio.estado == 0 && proyecto.aprobado != 'a'}"/>--}%
%{--     --}%
%{--        <g:if test="${params.list != 'list'}">--}%
%{--            <g:set var="editable" value="${false}"/>--}%
%{--        </g:if>--}%


<g:set var="editable" value="${true}"/>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="proyecto" action="${params.list}" params="${params}" class="btn btn-sm btn-default">
            <i class="fa fa-list"></i> Lista de proyectos
        </g:link>
    </div>
    <g:if test="${editable}">
        <div class="btn-group">
            <g:link controller="cronograma" action="form" params="${params}" class="btn btn-sm btn-info btn-edit">
                <i class="fa fa-edit"></i> Editar
            </g:link>
        </div>
    </g:if>
    <div class="btn-group">
        <g:link controller="asignacion" action="asignacionProyectov2" id="${proyecto.id}" class="btn btn-sm btn-default">
            <i class="fa fa-dollar-sign"></i> Asignaciones
        </g:link>
    </div>
    <g:if test="${params.act}">
        <div class="btn-group">
            <g:link controller="marcoLogico" action="marcoLogicoProyecto" id="${proyecto.id}" class="btn btn-sm btn-default"
                    params="[list: params.list]">
                <i class="fa fa-calendar"></i> Plan de proyecto
            </g:link>
        </div>
    </g:if>
</div>

<g:if test="${proyecto.aprobado == 'a'}">
    <div class="alert alert-info">
        El proyecto está aprobado, no puede modificar el cronograma
    </div>
</g:if>

<div class="panel panel-primary " style="text-align: center; font-size: 14px;">
    <strong>PROYECTO: </strong> <strong style="color: #5596ff; "> ${proyecto?.nombre}</strong>
</div>

%{--        <elm:container tipo="vertical" titulo="Cronograma del proyecto ${proyecto?.toStringMedio()}, para el año ${anio}" color="black">--}%
<elm:container tipo="vertical" titulo="Cronograma" color="black">
    <g:if test="${!params.act}">
        <div class="divIndice ">
            <g:each in="${componentes}" var="comp">
                <a href="#comp${comp.id}" class="scrollComp ">
                    <strong>Componente ${comp.numero}</strong>:
                ${(comp.objeto.length() > 100) ? comp.objeto.substring(0, 100) + "..." : comp.objeto}
                </a>
            </g:each>
        </div>
    </g:if>


    <table class="table table-condensed table-bordered table-hover table-striped" id="tblCrono">
        <thead>
        <tr>
            <th>Año</th>
            <th colspan="16">
                <g:select from="${parametros.Anio.list([sort: 'anio'])}" optionKey="id" optionValue="anio" class="form-control input-sm"
                          style="width: 100px; display: inline" name="anio" id="anio" value="${anio.id}"/>
            </th>
        </tr>

        <tr id="trMeses">
            <th colspan="2" style="width:300px;">Componentes/Rubros</th>
            <g:each in="${parametros.Mes.list()}" var="mes">
                <th style="width:100px;" data-id="${mes.id}" title="${mes.descripcion} ${anio.anio}">
                    ${mes.descripcion[0..2]}.
                </th>
            </g:each>
            <th>Total<br/>Año</th>
            <th>Sin<br/>asignar</th>
            <th>Total<br/>Asignado</th>
        </tr>
        </thead>
    </table>
    <div class="divTabla" style="margin-top: -20px">

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

    cargarTablaCronograma('${anio?.id}');

    function cargarTablaCronograma(anio){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'cronograma', action: 'tablaCronograma_ajax')}',
            data:{
                anio: anio,
                proyecto: '${proyecto?.id}',
                actSel: '${actSel?.id}'
            },
            success: function (msg) {
                $(".divTabla").html(msg)
            }

        });
    }

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

    var $container = $(".divTabla");
    $container.scrollTop(0 - $container.offset().top + $container.scrollTop());
    $(function () {
        $(".comp").each(function () {
            var id = $(this).attr("id");
            var actividades = $(".act." + id);
            if (actividades.length == 0) {
                $(this).hide();
                $(".total." + id).hide();
            }
        });

        /* *************** PARA LA TABLA ********************/

//                $("#tblCrono").fixedHeaderTable({
//                    height     : 320,
//                    autoResize : true,
//                    footer     : true
//                });

//                var $tbl = $("#tblCrono");
//                var $thead = $tbl.find("thead");
//                var $tbody = $tbl.find("tbody");
//                var $tfoot = $tbl.find("tfoot");
//
//                var width = $thead.width();
//                var tableHeight = $tbl.height();
//                var headHeight = $thead.height();
//                var bodyHeight = tableHeight - headHeight;
//
//                var $divAll = $("<div>");
//                var $divHead = $("<div>");
//                var $divBody = $("<div>");
//
//                $divAll.css({
////                    background : "green"
//                });
//                $divHead.css({
////                    background : "red"
//                });
//                $divBody.css({
////                    background : "blue",
//                    maxHeight : 300,
//                    overflow  : "auto"
//                });
//
//                $divHead.width(width);
//                $divHead.height(headHeight);
//
//                $divBody.width(width);
//
//                var $tblHead = $("<table class='table table-condensed table-bordered'>");
//                $tblHead.append("<thead>");
//                $thead.find("tr").each(function () {
//                    var $tr = $(this);
//                    var $ntr = $("<tr>");
//                    $tr.find("th").each(function () {
//                        var $th = $(this);
//                        var $nth = $th.clone(true);
//                        $nth.outerWidth($th.outerWidth());
//                        $ntr.append($nth);
//                    });
//                    $tblHead.append($ntr);
//                });
//
//                var $tblBody = $("<table class='table table-condensed table-bordered'>");
//                $tblBody.append("<tbody>");
//                $tbody.find("tr").each(function () {
//                    var $tr = $(this);
//                    var $ntr = $("<tr>");
//                    $tr.find("th, td").each(function () {
//                        var $th = $(this);
//                        var $nth = $th.clone(true);
//                        $nth.outerWidth($th.outerWidth() + 2);
//                        $ntr.append($nth);
//                    });
//                    $tblBody.append($ntr);
//                });
//
//                var $tblFoot = $("<tfoot>");
//                $tfoot.find("tr").each(function () {
//                    var $tr = $(this);
//                    var $ntr = $("<tr>");
//                    $tr.find("th, td").each(function () {
//                        var $th = $(this);
//                        var $nth = $th.clone(true);
//                        $nth.outerWidth($th.outerWidth());
//                        $ntr.append($nth);
//                    });
//                    $tblFoot.append($ntr);
//                });
//                $tblBody.append($tblFoot);
//
//                $divHead.append($tblHead);
//                $divBody.append($tblBody);
//
//                $divAll.append($divHead).append($divBody);
//
//                $tbl.before($divAll);
//
//                $tbl.hide();

        /* *************** PARA LA TABLA ********************/

        $(".btn-edit").click(function () {
            openLoader();
        });
        %{--$("#anio").val(${anio.id}).change(function () {--}%
        $("#anio").change(function () {
            var a = $("#anio option:selected").val();
            %{--openLoader();--}%
            %{--location.href = "${createLink(controller: 'cronograma', action: 'show', id: proyecto.id)}?anio=" +--}%
            %{--    $("#anio").val() + armaParams() + "&act=${actSel?.id}&list=${params.list}";--}%

            cargarTablaCronograma(a)

        });

        $(".scrollComp").click(function () {
            var $scrollTo = $($(this).attr("href"));
            $container.animate({
                scrollTop : $scrollTo.offset().top - $container.offset().top + $container.scrollTop()
            });
            return false;
        });

        $("#btnModalCancelVer").click(function () {
            $('#modalCronoVer').modal("hide");
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
                header : {
                    label  : "Acciones",
                    header : true
                },
                ver    : {
                    label  : "Ver",
                    icon   : "fa fa-search",
                    action : function ($element) {
                        var id = $element.data("id");
                        var $tr = $element.parents("tr");
                        var index = $element.index();

                        var $mes = $("#trMeses").children().eq(index-1);
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
                }
            },
            onShow : function ($element) {
                $element.addClass("success");
            },
            onHide : function ($element) {
                $(".success").removeClass("success");
            }
        });

    });
</script>

</body>
</html>