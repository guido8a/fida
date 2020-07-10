<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/07/20
  Time: 13:20
--%>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmMeta" role="form" action="saveMeta_ajax" method="POST">
        <g:hiddenField name="id" value="${meta?.id}"/>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'parroquia', 'error')} ">
            <span class="grupo">
                <label for="parroquia" class="col-md-3 control-label">
                    Parroquia
                </label>
                <div class="col-md-7">
                    <g:hiddenField name="parroquia" value="${meta?.parroquia?.id}"/>
                    <span class="grupo">
                        <div class="input-group input-group-sm" >
                            <input type="text" class="form-control buscarParroquia required" name="parrroquiaName" id="parroquiaTexto" value="${meta?.parroquia?.nombre}">
                            <span class="input-group-btn">
                                <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                </a>
                            </span>
                        </div>
                    </span>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'marcoLogico', 'error')} ">
            <span class="grupo">
                <label for="marcoLogico" class="col-md-3 control-label">
                    Actividad (Marco lógico)
                </label>
                <div class="col-md-7">
                    <g:select name="marcoLogico" from="${actividades}" optionKey="id" optionValue="objeto" value="${meta?.marcoLogico?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'unidad', 'error')} ">
            <span class="grupo">
                <label for="unidad" class="col-md-3 control-label">
                    Unidad
                </label>
                <div class="col-md-7">
                    <g:select name="unidad" from="${parametros.proyectos.Unidad.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" value="${meta?.unidad?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'indicadorOrms', 'error')} ">
            <span class="grupo">
                <label for="indicadorOrms" class="col-md-3 control-label">
                    Indicador ORMS
                </label>
                <div class="col-md-7">
                    <g:select name="indicadorOrms" from="${parametros.proyectos.IndicadorOrms.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" value="${meta?.indicadorOrms?.id}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label">
                    Descripción
                </label>
                <div class="col-md-7">
                    <g:textArea name="descripcion" style="height: 100px; resize: none;" maxlength="255" value="${meta?.descripcion}" class="many-to-one form-control input-sm required"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="valor" class="col-md-3 control-label">
                    Valor
                </label>
                <div class="col-md-7">
                    <g:textField name="valor" value="${meta?.valor}" class="many-to-one form-control input-sm"/>
                </div>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    var bp

    $(document).ready(function() {

        $(".buscarParroquia").click(function () {
            var dialog = cargarLoader("Cargando...");
            $(this).attr('disabled','disabled');
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
                data:{
                },
                success:function (msg) {
                    dialog.modal('hide');
                    // $(".buscarParroquia").removeAttr('disabled');
                    bp = bootbox.dialog({
                        id    : "dlgBuscarParroquia",
                        title : "Buscar Parroquia",
                        class : "modal-lg",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                    $(".buscarParroquia").removeAttr('disabled');
                                }
                            }
                        } //buttons
                    }); //dialog
                }
            });
        });
    });

    function cerrarDialogoParroquia(){
        bp.dialog().dialog('open');
        bp.modal("hide");
    }
</script>