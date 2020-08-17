<%@ page import="parametros.proyectos.TipoElemento" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/20
  Time: 13:50
--%>

<div class="modal-contenido row">
    <g:form class="form-horizontal" name="frmPlan" role="form" action="savePlan_ajax" method="POST">
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Convenio
                    </label>
                </div>
                <div class="col-md-7">
                    <g:hiddenField name="convenio" value="${convenio?.id}"/>
                    <strong style="font-size: 14px; color: #5596ff">${convenio?.nombre}</strong>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Componente
                    </label>
                </div>
                <div class="col-md-7">
                    <g:select name="componente" class="form-control" from="${proyectos.MarcoLogico.findAllByTipoElemento(parametros.proyectos.TipoElemento.get(3))}" optionKey="id" optionValue="objeto"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Actividad
                    </label>
                </div>
                <div class="col-md-7" id="divActividad">
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Unidad de compras públicas
                    </label>
                </div>
                <div class="col-md-7">
                    <g:select name="unidadComprasPublicas" from="${convenio.UnidadComprasPublicas.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Tipo de proceso
                    </label>
                </div>
                <div class="col-md-7">
                    <g:select name="tipoProcesoComprasPublicas" from="${convenio.TipoProcesoComprasPublicas.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control"/>
                </div>
            </span>
        </div>
        <div class="form-group">
            <span class="grupo">
                <div class="col-md-1"></div>
                <label for="codigoComprasPublicas" class="col-md-3 control-label text-info">
                    Código CPC
                </label>
                <div class="row">
                    <div class="col-md-6">
                        <g:hiddenField name="codigoComprasPublicas" value="${''}"/>
                        <g:textField name="codigoComprasPublicasNombre" class="form-control required text-uppercase" value="${''}"/>
                    </div>
                    <div class="col-md-2">
                        <a href="#" class="btn btn-info" id="btnBuscarCPC" >
                            Buscar CPC
                        </a>
                    </div>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    cargarActividad($("#componente option:selected").val());

    $("#componente").change(function () {
       var id = $(this).val();
       cargarActividad(id)
    });

    function cargarActividad(id){
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'plan', action: 'actividad_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                $("#divActividad").html(msg)
            }

        });
    }

    $("#btnBuscarCPC").click(function () {
        cargarBuscarCodigo(1)
    });

    function cargarBuscarCodigo(tipo) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'codigoComprasPublicas', action:'buscarCodigo')}",
            data    : {
                tipo: tipo
            },
            success : function (msg) {
                bootbox.dialog({
                    id    : 'dlgTablaCPC',
                    title : "Buscar código de compras públicas",
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
            } //success
        }); //ajax
    }

</script>
