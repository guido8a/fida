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
                            <input type="text" class="form-control buscarParroquia" name="parrroquiaName" id="parroquiaTexto" value="${meta?.parroquia?.nombre}">
                            <span class="input-group-btn">
                                <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                </a>
                            </span>
                        </div>
                    </span>
                </div>
            </span>
        </div>
%{--        <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'marcoLogico', 'error')} ">--}%
%{--            <span class="grupo">--}%
%{--                <label for="marcoLogico" class="col-md-3 control-label">--}%
%{--                    Actividad (Marco lógico)--}%
%{--                </label>--}%
%{--                <div class="col-md-7">--}%
%{--                    <g:hiddenField name="parroquia" value="${meta?.parroquia?.id}"/>--}%
%{--                    <span class="grupo">--}%
%{--                        <div class="input-group input-group-sm" >--}%
%{--                            <input type="text" class="form-control buscarParroquia" name="parrroquiaName" id="parroquiaTexto" value="${meta?.parroquia?.nombre}">--}%
%{--                            <span class="input-group-btn">--}%
%{--                                <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>--}%
%{--                                </a>--}%
%{--                            </span>--}%
%{--                        </div>--}%
%{--                    </span>--}%
%{--                </div>--}%
%{--            </span>--}%
%{--        </div>--}%
    </g:form>
</div>

<script type="text/javascript">

    var bp

    $(document).ready(function() {

        $(".buscarParroquia").click(function () {
            var dialog = cargarLoader("Cargando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
                data:{
                },
                success:function (msg) {
                    dialog.modal('hide');
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