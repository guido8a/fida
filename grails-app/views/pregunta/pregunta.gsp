<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
<meta name="layout" content="main">
<title>Preguntas</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Preguntas para los Indicadores del Marco Lógico</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
    <div class="btn-toolbar toolbar">

    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-success" id="btnAddPreg">
            <i class="fa fa-plus"></i> Nueva Pregunta
        </a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-primary" id="btnRespuesta">
            <i class="fa fa-book"></i> Banco de Respuestas Posibles
        </a>
    </div>

%{--
    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-warning" id="btnEncuesta">
            <i class="fa fa-user-edit"></i> Aplicar Encuesta
        </a>
    </div>
--}%

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
    var bm;

    function reloadTablaPregunta(search) {
        var data = {
            %{--id : "${convenio?.id}"--}%
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'pregunta', action:'tablaPregunta_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tabla").html(msg);
            }
        });
    }

    function submitFormPregunta() {
        var $form = $("#frmPregunta");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'pregunta', action:'savePregunta_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg == 'ok') {
                        log("Pregunta agregada correctamente","success");
                        reloadTablaPregunta();
                    } else {
                        if(msg == 'er'){
                            bootbox.alert({
                                size: "small",
                                title: "Alerta!!!",
                                message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  El número ingresado ya se encuentra asignado a otra pregunta!",
                                callback: function(){
                                }
                            });
                        }else{
                            log("Error al agregar la pregunta","error")
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function createEditPregunta(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'pregunta', action:'formPregunta_ajax')}",
            data    : {
                id: id ? id : ''
                // ,
                %{--convenio: '${convenio?.id}'--}%
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Pregunta",
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
                                return submitFormPregunta();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    reloadTablaPregunta();

    $("#btnSearchDoc").click(function () {
        reloadTablaPregunta($.trim($("#searchDoc").val()));
    });
    $("#searchDoc").keyup(function (ev) {
        if (ev.keyCode == 13) {
            reloadTablaPregunta($.trim($("#searchDoc").val()));
        }
    });
    $("#btnAddPreg").click(function () {
        createEditPregunta();
    });

    $("#btnRespuesta").click(function () {
        location.href="${createLink(controller: 'respuesta', action: 'list')}"
    });

    $("#btnEncuesta").click(function () {
        location.href="${createLink(controller: 'encuesta', action: 'index')}"
    });


</script>
</html>