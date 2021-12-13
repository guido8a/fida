<%@ page import="proyectos.Indicador" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/07/20
  Time: 13:20
--%>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmMeta" role="form" action="saveMeta_ajax" method="POST">
        <g:hiddenField name="id" value="${meta?.id}"/>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'indicadorOrms', 'error')} ">
            <span class="grupo">
                <label for="indicadorOrms" class="col-md-3 control-label">
                    Indicador ORMS
                </label>
                <div class="col-md-9">
                    <g:select name="indicadorOrms" from="${parametros.proyectos.IndicadorOrms.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" value="${meta?.indicadorOrms?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'indicadorOrms', 'error')} ">
            <span class="grupo">
                <label for="indicador" class="col-md-3 control-label">
                    Indicador
                </label>
                <div class="col-md-9">
                    <g:select name="indicador" from="${indicadores}" optionKey="id" optionValue="descripcion" value="${meta?.indicador?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'unidad', 'error')} ">
            <span class="grupo">
                <label for="unidad" class="col-md-3 control-label">
                    Unidad
                </label>
                <div class="col-md-9">
                    <g:select name="unidad" from="${parametros.proyectos.Unidad.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" value="${meta?.unidad?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label">
                    Descripción
                </label>
                <div class="col-md-9">
                    <g:textArea name="descripcion" style="height: 100px; resize: none;" maxlength="255" value="${meta?.descripcion}" class="many-to-one form-control input-sm required"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'lineaBase', 'error')} ">
            <span class="grupo">
                <label for="lineaBase" class="col-md-2 control-label">
                    Línea Base
                </label>
                <div class="col-md-2">
                    <g:textField name="lineaBase" value="${meta?.lineaBase}" class="digits many-to-one form-control input-sm required"/>
                </div>
            </span>
            <span class="grupo">
                <label for="disenio" class="col-md-2 control-label">
                    Diseño
                </label>
                <div class="col-md-2">
                    <g:textField name="disenio" value="${meta?.disenio}" class="digits many-to-one form-control input-sm required"/>
                </div>
            </span>
            <span class="grupo">
                <label for="restructuracion" class="col-md-2 control-label">
                    Restructuración
                </label>
                <div class="col-md-2">
                    <g:textField name="restructuracion" value="${meta?.restructuracion}" class="digits many-to-one form-control input-sm required" />
                </div>
            </span>
        </div>
%{--        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'disenio', 'error')} ">--}%
%{--            <span class="grupo">--}%
%{--                <label for="disenio" class="col-md-3 control-label">--}%
%{--                    Diseño--}%
%{--                </label>--}%
%{--                <div class="col-md-4">--}%
%{--                    <g:textField name="disenio" value="${meta?.disenio}" class="number many-to-one form-control input-sm"/>--}%
%{--                </div>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'restructuracion', 'error')} ">--}%
%{--            <span class="grupo">--}%
%{--                <label for="restructuracion" class="col-md-3 control-label">--}%
%{--                    Restructuración--}%
%{--                </label>--}%
%{--                <div class="col-md-4">--}%
%{--                    <g:textField name="restructuracion" value="${meta?.restructuracion}" class="number many-to-one form-control input-sm"/>--}%
%{--                </div>--}%
%{--            </span>--}%
%{--        </div>--}%
    </g:form>
</div>

<script type="text/javascript">

    // var bp

    %{--$(document).ready(function() {--}%

    %{--    $(".buscarParroquia").click(function () {--}%
    %{--        var dialog = cargarLoader("Cargando...");--}%
    %{--        $(this).attr('disabled','disabled');--}%
    %{--        $.ajax({--}%
    %{--            type: 'POST',--}%
    %{--            url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',--}%
    %{--            data:{--}%
    %{--            },--}%
    %{--            success:function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                bp = bootbox.dialog({--}%
    %{--                    id    : "dlgBuscarParroquia",--}%
    %{--                    title : "Buscar Parroquia",--}%
    %{--                    class : "modal-lg",--}%
    %{--                    message : msg,--}%
    %{--                    buttons : {--}%
    %{--                        cancelar : {--}%
    %{--                            label     : "Cancelar",--}%
    %{--                            className : "btn-primary",--}%
    %{--                            callback  : function () {--}%
    %{--                                $(".buscarParroquia").removeAttr('disabled');--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    } //buttons--}%
    %{--                }); //dialog--}%
    %{--            }--}%
    %{--        });--}%
    %{--    });--}%
    %{--});--}%

    // function cerrarDialogoParroquia(){
    //     bp.dialog().dialog('open');
    //     bp.modal("hide");
    // }
</script>