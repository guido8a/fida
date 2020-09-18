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

    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-warning" id="btnEncuesta">
            <i class="fa fa-user-edit"></i> Aplicar Encuesta
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
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    // function submitFormPregunta() {
    //     var $form = $("#frmPregunta");
    //     var $btn = $("#dlgCreateEdit").find("#btnSave");
    //     if ($form.valid()) {
    //         $btn.replaceWith(spinner);
    //         var formData = new FormData($form[0]);
    //         var dialog = cargarLoader("Guardando...");
    //         $.ajax({
    //             url         : $form.attr("action"),
    //             type        : 'POST',
    //             data        : formData,
    //             async       : false,
    //             cache       : false,
    //             contentType : false,
    //             processData : false,
    //             success     : function (msg) {
    //                 dialog.modal('hide');
    //                 var parts = msg.split("*");
    //                 if (parts[0] == "SUCCESS") {
    //                     log(parts[1],"success");
    //                     reloadTablaPregunta();
    //                     bm.modal("hide");
    //                 } else {
    //                     if(parts[0] == 'er'){
    //                         bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + parts[1])
    //                         // return false;
    //                     }else{
    //                         spinner.replaceWith($btn);
    //                         log(parts[1],"error");
    //                         return false;
    //                     }
    //                 }
    //             }
    //         });
    //     } else {
    //         return false;
    //     } //else
    //     return false;
    // }

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
                bm = bootbox.dialog({
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
                    bm.find(".form-control").first().focus()
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