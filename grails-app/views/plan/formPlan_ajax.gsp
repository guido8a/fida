<%@ page import="planes.GrupoActividad; parametros.proyectos.TipoElemento" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/20
  Time: 13:50
--%>

<div class="modal-contenido row">
    <g:form class="form-horizontal" name="frmPlan" role="form" action="savePlan_ajax" method="POST">
        <g:hiddenField name="plan" value="${plan?.id}"/>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Plan de Negocios Solidario
                    </label>
                </div>
                <div class="col-md-7">
                    <g:hiddenField name="plns" value="${plns?.id}"/>
                    <strong style="font-size: 14px; color: #5596ff">${plns?.nombre}</strong>
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
                    <g:select name="componente" class="form-control"
                              from="${planes.GrupoActividad.findAllByPlanesNegocioAndPadreIsNull(plns)}"
                              optionKey="id" optionValue="descripcion" value="${plan?.grupoActividad?.descripcion}"/>
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
                    <g:select name="unidadComprasPublicas"
                              from="${convenio.UnidadComprasPublicas.list().sort{it.descripcion}}"
                              optionKey="id" optionValue="descripcion" class="form-control" value="${plan?.unidadComprasPublicas?.id}"/>
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
                    <g:select name="tipoProcesoComprasPublicas"
                              from="${convenio.TipoProcesoComprasPublicas.list().sort{it.descripcion}}"
                              optionKey="id" optionValue="descripcion" class="form-control" value="${plan?.tipoProcesoComprasPublicas?.id}"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label for="codigoComprasPublicas" class="control-label">
                        Código CPC
                    </label>
                </div>
                <div class="col-md-5">
                    <g:hiddenField name="codigoComprasPublicas" value="${plan?.codigoComprasPublicas?.id}"/>
                    <g:textField name="codigoComprasPublicasNombre" readonly=""
                                 class="form-control" value="${plan?.codigoComprasPublicas ? (plan?.codigoComprasPublicas?.numero + " - " + plan?.codigoComprasPublicas?.descripcion) : ''}"/>
                </div>
                <div class="col-md-2">
                    <a href="#" class="btn btn-info btnBuscarCPC">
                        Buscar CPC
                    </a>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Descripción
                    </label>
                </div>
                <div class="col-md-7">
                    <g:textArea name="descripcion" value="${plan?.descripcion}" class="form-control required" style="resize: none; height: 100px" maxlength="255"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Cantidad
                    </label>
                    <g:textField name="cantidad" class="form-control number required" value="${plan?.cantidad}"/>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-4">
                    <label>
                        Costo
                    </label>
                    <g:textField name="costo" class="form-control number required" value="${plan?.costo}"/>
                </div>
            </span>
            <span class="grupo">
                <div class="col-md-3">
                    <label>
                        Ejecutado
                    </label>
                    <g:textField name="ejecutado" class="form-control number" value="${plan?.ejecutado}"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether">
            <span class="grupo">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <label>
                        Estado
                    </label>
                </div>
                <div class="col-md-4">
                    <g:select name="estado" from="${[1:'Activo',0:'Inactivo']}" optionValue="value" optionKey="key" class="form-control" value="${plan?.estado}"/>
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
                id: id,
                plan: '${plan?.id}'
            },
            success: function (msg) {
                $("#divActividad").html(msg)
            }

        });
    }

    var cd;
    var dg;

    $(document).ready(function() {

        $(".btnBuscarCPC").click(function () {
            dg= cargarLoader("Cargando...");
            cargarBuscarCodigo(1)
        });


        function cargarBuscarCodigo(tipo) {
            dg.modal('hide');
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'codigoComprasPublicas', action:'buscarCodigo')}",
                data: {
                    tipo: tipo
                },
                success: function (msg) {
                    cd = bootbox.dialog({
                        id: 'dlgTablaCPC',
                        title: "Buscar código de compras públicas",
                        class: "modal-lg",
                        message: msg,
                        buttons: {
                            cancelar: {
                                label: "Cancelar",
                                className: "btn-primary",
                                callback: function () {
                                }
                            }
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        }
    });

    function cerrarDialogoBusquedaCPC(){
        cd.dialog().dialog('open');
        cd.modal("hide");
    }

    var validator = $("#frmPlan").validate({
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


</script>
