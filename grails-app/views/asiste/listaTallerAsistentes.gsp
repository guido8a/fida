<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 16/02/22
  Time: 15:08
--%>

<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Asistentes</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Asistentes al Taller "${taller.nombre}"</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <div class="btn-toolbar toolbar">

            <div class="btn-group">
                <g:link controller="taller" action="listTaller" id="${unidad?.id}" class="btn btn-sm btn-default">
                    <i class="fa fa-arrow-left"></i> Regresar a taller
                </g:link>
            </div>

            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-success" id="btnPrtl">
                    <i class="fa fa-plus"></i> Agregar Asistentes
                </a>
            </div>

            <div class="btn-group col-md-3 pull-right">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control input-sm " id="searchDoc" placeholder="Buscar"/>
                    <span class="input-group-btn">
                        <a href="#" class="btn btn-default" id="btnSearchDoc"><i class="fa fa-search"></i></a>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>
    </div>
    <div id="tabla"></div>
</div>



<script type="text/javascript">

    var bpt

    function reloadTablaTaller(search) {
        var data = {
            id : "${taller.id}"
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'asiste', action:'tablaAsistentes_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tabla").html(msg);
            }
        });
    }


    function createEditPersonaTaller() {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'asiste', action:'listaBeneficiarios_ajax')}",
            data    : {
                taller: '${taller?.id}'
            },
            success : function (msg) {
                bpt = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : " Beneficiarios del Taller",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Salir",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    bpt.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit


    reloadTablaTaller();

    $("#btnSearchDoc").click(function () {
        reloadTablaTaller($.trim($("#searchDoc").val()));
    });
    $("#searchDoc").keyup(function (ev) {
        if (ev.keyCode == 13) {
            reloadTablaTaller($.trim($("#searchDoc").val()));
        }
    });
    $("#btnPrtl").click(function () {
        createEditPersonaTaller();
    });


</script>
</html>