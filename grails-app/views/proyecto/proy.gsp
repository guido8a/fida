<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>FAREPS</title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        /*font-size: medium;*/
        text-align: right;
    }

    .sobrepuesto {
        position: absolute;
        top: 3px;
        font-size: 14px;
    }

    .negrita {
        font-weight: bold;
    }
    </style>

</head>

<body>

<h3>Proyecto FAREPS</h3>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading" style="padding: 3px; margin-top: 2px">
        <a href="${createLink(controller: 'buscarBase', action: 'busquedaBase')}" id="btnConsultar"
           class="btn btn-sm btn-info" title="Consultar artículo">
            <i class="fas fa-clipboard-check"></i> Base de Conocimiento
        </a>
        <a href="${createLink(controller: 'documento', action: 'listProyecto_ajax')}" id="btnConsultar"
           class="btn btn-sm btn-info" title="Consultar artículo">
            <i class="fas fa-book-reader"></i> Biblioteca
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <a href="#" id="btnBase" class="btn btn-sm btn-info" title="Crear nuevo registro">
            <i class="fa fa-check"></i> Financiamiento
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info" title="Ver registro">
            <i class="fa fa-search"></i> Estado
        </a>
        <a href="#" id="btnVerMarco" class="btn btn-sm btn-info" title="Ver marco lógico">
            <i class="fa fa-search"></i> Ver Marco Lógico
        </a>
        <a href="#" id="editMrlg" class="btn btn-sm btn-info" title="Ver registro">
            <i class="fa fa-search"></i> Editar Marco Lógico
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info" title="Ver registro">
            <i class="fa fa-search"></i> Ver Cronograma
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info"  title="Ver registro">
            <i class="fa fa-search"></i> Editar Cronograma
        </a>
    </div>


    %{--    <div class="panel-group" style="height: 730px">--}%
    %{--        <div class="col-md-12" style="margin-top: 10px">--}%
    %{--            <div style="height: 3px; background-color: #CEDDE6"></div>--}%

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmProyecto" controller="proyecto" action="save_ajax">
                <g:hiddenField name="id" value="${proy?.id}"/>
                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Código CUP</span>

                        <g:if test="${proy?.id}">
                            <div class="col-md-3">
                                <g:textField name="codigoProyecto" id="codigoProyecto" class="form-control required"
                                             maxlength="20" value="${proy?.codigoProyecto}" readonly=""/>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="col-md-3">
                                <g:textField name="codigoProyecto" id="codigoProyecto" class="form-control required"
                                             maxlength="20" value="${proy?.codigoProyecto}"/>
                            </div>
                        </g:else>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Nombre</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textField name="nombre" id="nombre" class="form-control required"
                                             maxlength="255" value="${proy?.nombre}"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Productos</span>

                        <div>
                            <div class="col-md-10">
                                <span class="grupo">
                                    <g:textField name="producto" id="producto" class="form-control"
                                                 maxlength="127" value="${proy?.producto}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Descripción</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textArea name="descripcion" id="descripcion" class="form-control" maxlength="1023"
                                            style="height: 80px; resize: none" value="${proy?.descripcion}"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Problema</span>

                        <div class="col-md-10">
                            <g:textArea name="problema" id="problema" class="form-control required" maxlength="1023"
                                        style="height: 80px; resize: none" value="${proy?.problema}"/>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Justificación</span>

                        <div class="col-md-10">
                            <g:textArea name="justificacion" id="justificacion" class="form-control required"
                                        maxlength="1023"
                                        style="height: 80px; resize: none" value="${proy?.justificacion}"/>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>
                        <span class="grupo">
                            <div class="col-md-2 ">
                                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                       value="${proy?.fechaInicio?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Fin</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaFin" id='fechaFin' type='text' class="form-control"
                                       value="${proy?.fechaFin?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 20px">
                    <div class="col-md-6 input-group">
                        <span class="col-md-4 label label-primary text-info mediano">Informar cada (meses)</span>

                        <div class="col-md-2">
                            <g:textField name="mes" id="mes" class="form-control" maxlength="5" value="${proy?.mes}"/>
                        </div>
                    </div>
                    <div class="col-md-6 input-group">
                        <span class="col-md-4 label label-primary text-info mediano">Monto del Proyecto</span>

                        <div class="col-md-4">
                            <g:textField name="monto" id="monto" class="form-control negrita" maxlength="16"
                                         value="${util.formatNumber(number: proy?.monto, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>



    <script type="text/javascript">

        $("#btnVerMarco").click(function () {
           location.href="${createLink(controller: 'marcoLogico', action: 'verMarco')}/${proy?.id}"
        });

        $("#btnBase").click(function () {
            location.href = "${createLink(controller: 'proyecto', action: 'proy')}"
        });

        $("#editMrlg").click(function () {
            location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto')}/${proy?.id}?list=list"
        });

        $("#btnGuardar").click(function () {

            var $form = $("#frmProyecto");
            var base_id = '${proy?.id}';
            $form.validate();
            console.log('val:', $form.validate());
            console.log('val:', $form.validate().label);
            if($form.valid()){
                var dialog = cargarLoader("Guardando...");
                console.log('ok')
                $.ajax({type: 'POST',
                        url: "${createLink(controller: 'proyecto', action: 'save_ajax')}",
                data:  $form.serialize(),
                success: function (msg) {
                    var parte = msg.split("_");
                    if(parte[0] == 'ok'){
                        // log("Problema guardado correctamente","success");
                        // dialog.modal('hide');
                        // setTimeout(function () {
                            reCargar(parte[1]);
                        // }, 500);
                    }else{
                        dialog.modal('hide');
                        log("Error al guardar el proyecto" + parte[1],"error")
                    }
                }
            });
            }
        });

        function reCargar(id) {
//        console.log('recargar', id)
            var url = "${createLink(controller: 'proyecto', action: 'proy')}" + "/" + id
//        console.log('link', url)
            location.href = url
        }

        /*
            $("#frmProyecto").validate({
                errorClass     : "help-block",
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
        */

        $("#frmProyecto").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            },
            rules: {
                nombre: {
                    remote: {
                        url: "${createLink(action: 'validarNombre_ajax')}",
                        type: "post"
                    }
                }
            },
            messages: {
                nombre: {
                    remote: "El nombre no contiene FAREPS"
                }
            }
        });

        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });

        /*
            function createContainer() {
                var file = document.getElementById("file");
                var next = $("#files").find(".fileContainer").size();
                if (isNaN(next))
                    next = 1;
                else
                    next++;
                var ar = file.files[next - 1];
                var div = $('<div class="fileContainer ui-corner-all d-' + next + '">');
                var row1 = $("<div class='row resumen'>");
                var row3 = $("<div class='row botones'  style='text-align: center'>");
                var row4 = $("<div class='row'>");
                row1.append("<div class='col-md-2 etiqueta' style='font-size: 14px'>Descripción</div>");
                row1.append("<div class='col-md-5'><textarea maxlength='254' style='resize: none' class='form-control " + next + "' required id='descripcion' name='descripcion' cols='5' rows='5'></textarea></div>");
                row3.append(" <a href='#' class='btn btn-azul subir' style='margin-left: 200px; margin-bottom: 10px' clase='" + next + "'><i class='fa fa-upload'></i> Guardar Imagen</a>");
                div.append("<div class='row' style='margin-top: 10px; font-size: 14px'><div class='titulo-archivo col-md-10'><span style='color: #327BBA'>Archivo:</span> " + ar.name + "</div></div>");
                div.append(row1);
                div.append(row3);
                $("#files").append(div);
                if ($("#files").height() * 1 > 120) {
                    $("#titulo-arch").show();
                    $("#linea-arch").show();
                } else {
                    $("#titulo-arch").hide();
                    $("#linea-arch").hide();
                }
            }
        */


        $('#fechaInicio').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

        $('#fechaFin').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

        $("input[maxlength]").maxlength({
            alwaysShow: true,
            threshold: 10,
            warningClass: "label label-success",
            limitReachedClass: "label label-danger"
        });
        $("textarea[maxlength]").maxlength();



    </script>

</body>
</html>