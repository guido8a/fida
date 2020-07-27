<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/12/15
  Time: 10:12 AM
--%>

<form id="frmPartida">


    <div class="row">
        <div class="col-md-2">
            <label>Proyecto:</label>
        </div>
        <div  class="col-md-8">
            <g:select from="${proyectos}" optionKey="id" optionValue="nombre" name="proyecto" class="form-control input-sm required requiredCombo"
                      noSelection="['-1': 'Seleccione...']"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Componente:</label>
        </div>
        <div  class="col-md-8" id="divComp">

        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Actividad:</label>
        </div>
        <div  class="col-md-8" id="divAct">

        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Partida</label>
        </div>

        <div class="col-md-4">
            %{--            <g:hiddenField name="partidaHide" id="prsp_hide" value="${detalle?.presupuesto?.id}"/>--}%
            %{--            <g:textField name="partida" id="prsp_id" class="fuente many-to-one form-control input-sm required" value="${detalle ? (detalle?.presupuesto?.numero + " - " + detalle?.presupuesto?.descripcion) : " "}"/>--}%

            <g:hiddenField name="partida1" value="${detalle?.presupuesto?.id}"/>
            <span class="grupo">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control buscarPartida" name="partidaName" id="partida1Texto" data-tipo="1" value="${detalle ? (detalle?.presupuesto?.numero + " - " + detalle?.presupuesto?.descripcion) : " "}">
                    <span class="input-group-btn">
                        <a href="#" id="btn-abrir-1" class="btn btn-info buscarPartida" data-tipo="1" title="Buscar"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                        </a>
                    </span>
                </div>
            </span>
        </div>

        <div class="col-md-1">
            <label>Fuente</label>
        </div>

        <div class="col-md-4">
            <g:select from="${parametros.proyectos.Fuente.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion"
                      name="fuente" class="form-control input-sm required requiredCmb" value="${detalle?.fuente?.id}"/>
        </div>
    </div>

    <div class="row">

        <div class="col-md-2">
            <label for="monto">Monto a aumentar</label>
        </div>

        <div class="col-md-3">
            <div class="input-group">
                <g:textField type="text" name="monto"
                             class="form-control required input-sm number money" value="${detalle?.valor}"/>
                <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Reponsable</label>
        </div>

        <div class="col-md-6 grupo">
            <g:select name="responsable" from="${ seguridad.UnidadEjecutora.list([sort: 'nombre'])}"
                      optionKey="id" value="${detalle?.responsable?.id}"
                      class="form-control required" noSelection="['': 'Seleccione...']"/>
        </div>
    </div>
</form>

<script type="text/javascript">

    var bp

    $(document).ready(function() {
        $(".buscarPartida").click(function () {
            var tipo = $(this).data("tipo");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'cronograma', action: 'buscarPartida_ajax')}',
                data:{
                    tipo: tipo
                },
                success:function (msg) {
                    bp = bootbox.dialog({
                        id    : "dlgBuscarPartida",
                        title : "Buscar Partida",
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

    function cerrarDialogo(){
        bp.dialog().dialog('open');
        bp.modal("hide");
    }


    %{--$("#prsp_id").click(function(){--}%

    %{--    $.ajax({type : "POST", url : "${g.createLink(controller: 'asignacion',action:'buscadorPartidasFiltradas')}",--}%
    %{--        data     : {--}%

    %{--        },--}%
    %{--        success  : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id: "dlgPartidas",--}%
    %{--                title: "Buscador Partidas",--}%
    %{--                class   : "modal-lg",--}%
    %{--                message: msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            })--}%
    %{--        }--}%
    %{--    });--}%
    %{--});--}%

    $("#proyecto").change(function () {
        $("#divComp").html(spinner);
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'modificacionesPoa', action:'componentesProyectoAjuste_ajax')}",
            data    : {
                id   : $("#proyecto").val(),
//            anio : $("#anio").val()
                anio : ${anio?.id}
            },
            success : function (msg) {
                $("#divComp").html(msg);
                $("#divAct").html("");
//            $("#divAsg").html("");
            }
        });
    });

    <g:if test="${detalle}">
    $("#proyecto").val("${detalle?.componente?.proyecto?.id}").change();
    setTimeout(function () {
        $("#comp").val("${detalle?.componente?.marcoLogico?.id}").change();
        setTimeout(function () {
            $("#actividadRf").val("${ detalle?.componente?.id}").change();
        }, 500);
    }, 500);
    </g:if>




</script>