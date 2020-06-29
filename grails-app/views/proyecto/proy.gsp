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


    .nav-tabs > li > a{
        border: medium none;

    }
    .nav-tabs > li > a:hover{
        background-color: #475563 !important;
        border: medium none;
        border-radius: 0;
        color:#fff;
    }

    .progress-bar-svt {
        border     : 1px solid #e5e5e5;
        width      : 100%;
        height     : 25px;
        background : #F5F5F5;
        padding    : 0;
        margin-top : 10px;
    }

    .progress-svt {
        width            : 0;
        height           : 23px;
        padding-top      : 5px;
        padding-bottom   : 2px;
        background-color : #428BCA;
        text-align       : center;
        line-height      : 100%;
        font-size        : 14px;
        font-weight      : bold;

    }

    .background-image {
        background-image  : -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 10%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
        background-image  : linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
        -webkit-animation : progress-bar-stripes-svt 2s linear infinite;
        background-size   : 60px 60px;
        animation         : progress-bar-stripes-svt 2s linear infinite;
    }

    @-webkit-keyframes progress-bar-stripes-svt {
        /*el x del from tiene que ser multiplo del x del background size...... mientas mas grande mas rapida es la animacion*/
        from {
            background-position : 120px 0;
        }
        to {
            background-position : 0 0;
        }
    }

    @keyframes progress-bar-stripes-svt {
        from {
            background-position : 120px 0;
        }
        to {
            background-position : 0 0;
        }
    }
    </style>

</head>

<body>

<h3>Proyecto FAREPS</h3>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading" style="height: 36px; padding: 2px; margin-top: 2px">

%{--
        <h3 class="panel-title" style="margin-left: 420px" title="${proy?.problema ?: ''}">
            <i class="fa fa-pen"></i> Artículo:
        "${proy?.problema?.size() < 65 ? proy?.problema : proy?.problema[0..64]+"..."}"
        </h3>
--}%

        <a href="${createLink(controller: 'buscarBase', action: 'busquedaBase')}" id="btnConsultar"
           class="btn btn-sm btn-info sobrepuesto" title="Consultar artículo">
            <i class="fas fa-book-reader"></i> Biblioteca
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success sobrepuesto" style="margin-left: 105px"
           title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <a href="#" id="btnBase" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 195px" title="Crear nuevo registro">
            <i class="fa fa-check"></i> Financiamiento
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 335px" title="Ver registro">
            <i class="fa fa-search"></i> Estado
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 423px" title="Ver registro">
            <i class="fa fa-search"></i> Ver Marco Lógico
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 575px" title="Ver registro">
            <i class="fa fa-search"></i> Editar Marco Lógico
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 745px" title="Ver registro">
            <i class="fa fa-search"></i> Ver Cronograma
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 890px" title="Ver registro">
            <i class="fa fa-search"></i> Editar Cronograma
        </a>
    </div>


%{--    <div class="panel-group" style="height: 730px">--}%
%{--        <div class="col-md-12" style="margin-top: 10px">--}%
%{--            <div style="height: 3px; background-color: #CEDDE6"></div>--}%

            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">

                    <g:form name="frmProblema" role="form" action="guardarProblema_ajax" method="POST">
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Código Esigef</span>
                                <div class="col-md-3">
                                    <g:textField name="codigoEsigef" id="clve" class="form-control required"
                                                 maxlength="20"  value="${proy?.codigoEsigef}" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Nombre</span>
                                <div class="col-md-10">
                                    <span class="grupo">
                                        <g:textField name="nombre" id="nombre" class="form-control required"
                                                     maxlength="255"  value="${proy?.nombre}" />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Productos</span>
                                <div>
                                    <div class="col-md-10">
                                        <span class="grupo">
                                            <g:textField name="producto" id="producto" class="form-control required"
                                                         maxlength="127"  value="${proy?.producto}" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Descripción</span>
                                <div class="col-md-10">
                                    <span class="grupo">
                                        <g:textArea name="descripcion" id="descripcion" class="form-control required" maxlength="1023"
                                                    style="height: 80px; resize: none" value="${proy?.descripcion}"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Problema</span>
                                <div class="col-md-10">
                                    <g:textArea name="problema" id="problema" class="form-control required" maxlength="1023"
                                                style="height: 80px; resize: none" value="${proy?.problema}"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Justificación</span>
                                <div class="col-md-10">
                                    <g:textArea name="justificacion" id="justificacion" class="form-control required" maxlength="1023"
                                                style="height: 80px; resize: none" value="${proy?.justificacion}"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                        <div class="col-md-12">
                            <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>
                            <span class="grupo">
                                <div class="col-md-2">
                                    <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                           value="${proy?.fechaInicio?.format("dd-MM-yyyy")}"/>
                                    <p class="help-block ui-helper-hidden"></p>
                                </div>
                            </span>
                            <span class="col-md-2 mediano"> </span>
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
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Informar cada (meses)</span>
                                <div class="col-md-1">
                                    <g:textField name="mes" id="mes" class="form-control" maxlength="5" value="${proy?.mes}"/>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </div>
                %{--//tab imágenes--}%
                <div id="imagenes" class="tab-pane fade">

                    <g:if test="${proy?.id}">
                        <div class="row">
                            <div class="col-md-12">
                                <label class="control-label text-info" style="font-size: 14px">
                                    Cargue imágenes referentes al tema: <strong>'${proy?.problema}"</strong>
                                </label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4"></div>
                            <div class="col-md-6">
                                %{--                                    <span class="btn btn-success fileinput-button" style="position: relative;height: 40px;margin-top: 10px">--}%
                                %{--                                        <i class="glyphicon glyphicon-plus"></i>--}%
                                %{--                                        <span>Seleccionar archivos</span>--}%
                                <input type="file" name="file" id="file" title="Buscar Archivo" class="file btn btn-success" multiple accept=".jpeg, .jpg, .png">
                                %{--                                    </span>--}%
                            </div>
                        </div>
                    </g:if>

                    <div style="margin-top:15px;margin-bottom: 20px" class="vertical-container" id="files">
                        <p class="css-vertical-text" id="titulo-arch" style="display: none">Imagen</p>

                        <div class="linea" id="linea-arch" style="display: none"></div>
                    </div>


                    <div id="divCarrusel"></div>
                </div>

                <div id="archivos" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label text-info" style="font-size: 14px">
                                Archivos referentes al tema: <strong>'${proy?.problema}"</strong>
                            </label>
                        </div>
                    </div>
                    <g:if test="${proy?.id}">
                        <g:uploadForm controller="proyecto" action="subirArchivo">
                            <g:hiddenField name="idBase" value="${proy?.id}"/>
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-6">
                                    <input type="file" name="archivo" id="archivo" title="Buscar pdf" class="file btn btn-info" multiple accept=".pdf, .xls">
                                </div>
                               <input type="submit" class="btn btn-success" value="Subir Archivo"/>
                            </div>
                        </g:uploadForm>
                    </g:if>

                    <div id="tablaArchivos" style="margin-top: 40px"></div>

                </div>
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                Problema y Solución
            </div>

            <div class="modal-body" id="dialog-body" style="padding: 15px">

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


<script type="text/javascript">

    $("#btnBase").click(function () {
        location.href="${createLink(controller: 'proyecto', action: 'proy')}"
    });

    $("#btnGuardar").click(function () {

        var $form = $("#frmProblema");
        var base_id = '${proy?.id}';

        if($form.valid()){
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'proyecto', action: 'guardarProblema_ajax')}",
                data:  {
                    id: base_id,
                    algoritmo: texto,
                    tema: $("#temaId").val(),
                    problema: $("#prbl").val(),
                    clave: $("#clve").val(),
                    solucion: $("#slcn").val(),
                    referencia: $("#refe").val(),
                    observacion: $("#obsr").val()
                },
                success: function (msg) {
                    var parte = msg.split("_");
                    if(parte[0] == 'ok'){
                        log("Problema guardado correctamente","success");
                        dialog.modal('hide');
                        // setTimeout(function () {
                        //     reCargar(parte[1]);
                        // }, 500);
                    }else{
                        dialog.modal('hide');
                        log("Error al guardar el problema","error")
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

    var validator = $("#frmProblema").validate({
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
        },
        rules         : {
            problema : {
                remote: {
                    url : "${createLink(action: 'validarProblema_ajax')}",
                    type: "post",
                    data: {
                        id: $("#pr").val()
                    }
                }
            },
            clave: {
                remote: {
                    url : "${createLink(action: 'validarClave_ajax')}",
                    type: "post",
                    data: {
                        id: $("#cl").val()
                    }
                }
            }
        },
        messages      : {
            problema : {
                remote: "El número mínimo de caracteres debe ser de 25"
            },
            clave: {
                remote: "El número mínimo de caracteres debe ser de 3"
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
        // inline: true,
        sideBySide: true,
        // showClose: true,
        icons: {
            // close: 'closeText'
        }
    });

    $('#fechaFin').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        sideBySide: true,
        // showClose: true,
        icons: {
            // close: 'closeText'
        }
    });


</script>




</body>
</html>