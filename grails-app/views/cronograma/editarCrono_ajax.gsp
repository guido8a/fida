<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 07/07/20
  Time: 9:37
--%>

%{--<div class="modal-dialog">--}%
%{--    <div class="modal-content">--}%
%{--        <div class="modal-header">--}%
%{--            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>--}%
%{--            </button>--}%
%{--            <h4 class="modal-title" id="modalTitle">Cronograma</h4>--}%
%{--        </div>--}%

<div>
    <div id="noFuentes" class="alert alert-danger ${fuentes.size() == 0 ? '' : 'hidden'}">
        <span class="fa-stack fa-lg">
            <i class="fa fa-money text-success fa-stack-1x"></i>
            <i class="fa fa-ban fa-stack-2x"></i>
        </span> No se encontraron fuentes! Debe asignar al menos una para poder modificar el cronograma.
    </div>

    <div id="divOk" class="${fuentes.size() == 0 ? 'hidden' : ''}">
        <div class="alert alert-info" style="height: 80px">
            <div id="divActividad">
                <h4> Actividad: ${actividad} </h4>
            </div>
            <div id="divInfo" class="text-warning" style="font-size: 14px">
                <div class="col-md-12">
                    <div class="col-md-4">
                        <strong style="color: #5596ff">Monto total:</strong> $  <g:formatNumber number="${total}" format="#,##0" maxFractionDigits="2"/>
                    </div>
                    <div class="col-md-4">
                        <strong style="color: #5596ff">Asignado:</strong> $  <g:formatNumber number="${asignado}" format="#,##0" maxFractionDigits="2"/>
                    </div>
                    <div class="col-md-4">
                        <strong style="color: #5596ff">Por asignar:</strong> $  <g:formatNumber number="${sinAsignar}" format="#,##0" maxFractionDigits="2"/>
                    </div>
                </div>
            </div>
        </div>
        <g:form action="save_ajax" class="form-horizontal frmCrono" style="height: 300px; overflow:auto;">
            <g:hiddenField name="id" value="${cronograma?.id}"/>
            <elm:fieldRapido label="Presupuesto (1)" claseLabel="col-md-3" claseField="col-md-4">
                <div class="input-group input-group-sm">
                    <g:textField name="presupuesto1" class="form-control required number money" value="${cronograma?.valor ?: ''}"/>
                    <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
                </div>
            </elm:fieldRapido>
            <elm:fieldRapido label="Partida (1)" claseLabel="col-md-3" claseField="col-md-4">
                <g:hiddenField name="partida1" value="${cronograma?.presupuesto?.id}"/>
                <span class="grupo">
                    <div class="input-group input-group-sm" style="width:294px;">
                        <input type="text" class="form-control buscarPartida" name="partidaName" id="partida1Texto" data-tipo="1" value="${cronograma?.presupuesto}">
                        <span class="input-group-btn">
                            <a href="#" id="btn-abrir-1" class="btn btn-info buscarPartida" data-tipo="1" title="Buscar"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </a>
                        </span>
                    </div>
                </span>
            </elm:fieldRapido>
            <elm:fieldRapido label="Fuente (1)" claseLabel="col-md-3" claseField="col-md-7">
                <elm:select name="fuente1" from="${fuentes}" id="fuente1"
                            optionKey="${{ it.fuente.id }}"
                            optionValue="${{
                                it.fuente.descripcion + ' (' + g.formatNumber(number: it.monto, type: 'currency') + ')'
                            }}"
                            optionClass="${{
                                g.formatNumber(number: it.monto, minFractionDigits: 2, maxFractionDigits: 8)
                            }}"
                            class="form-control input-sm" value="${cronograma?.fuente?.id}"/>
            </elm:fieldRapido>
            <hr/>
            <elm:fieldRapido label="Presupuesto (2)" claseLabel="col-md-3" claseField="col-md-4">
                <div class="input-group input-group-sm">
                    <g:textField name="presupuesto2" class="form-control number money" value="${cronograma?.valor2 ?: ''}"/>
                    <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
                </div>
            </elm:fieldRapido>
            <elm:fieldRapido label="Partida (2)" claseLabel="col-md-3" claseField="col-md-4">
                <g:hiddenField name="partida2" value="${cronograma?.presupuesto2?.id}"/>
                <span class="grupo">
                    <div class="input-group input-group-sm" style="width:294px;">
                        <input type="text" class="form-control buscarPartida2" name="partidaName2" id="partida2Texto" data-tipo="2" value="${cronograma?.presupuesto2}">
                        <span class="input-group-btn">
                            <a href="#" id="btn-abrir-2" class="btn btn-info buscarPartida2" data-tipo="2" title="Buscar"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </a>
                        </span>
                    </div>
                </span>
            </elm:fieldRapido>
            <elm:fieldRapido label="Fuente (2)" claseLabel="col-md-3" claseField="col-md-7">
                <elm:select name="fuente2" from="${fuentes}" id="fuente2"
                            optionKey="${{ it.fuente.id }}"
                            optionValue="${{
                                it.fuente.descripcion + ' (' + g.formatNumber(number: it.monto, type: 'currency') + ')'
                            }}"
                            optionClass="${{
                                g.formatNumber(number: it.monto, minFractionDigits: 2, maxFractionDigits: 8)
                            }}"
                            class="form-control input-sm" value="${cronograma?.fuente2?.id}"/>
            </elm:fieldRapido>
        </g:form>
    </div>
</div>

<script type="text/javascript">

    var bp
    var bp2

    $(document).ready(function() {

        $(".buscarPartida").click(function () {
            var tipo = $(this).data("tipo");
            if($("#presupuesto1").val() != ''){
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
            }else{
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Ingrese un presupuesto (1)" + '</strong>');
                return false;
            }

        });


        $(".buscarPartida2").click(function () {
            var tipo = $(this).data("tipo");
            if($("#presupuesto2").val() != ''){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'cronograma', action: 'buscarPartida_ajax')}',
                    data:{
                        tipo: tipo
                    },
                    success:function (msg) {
                        bp2 = bootbox.dialog({
                            id    : "dlgBuscarPartida2",
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
            }else{
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Ingrese un presupuesto (2)" + '</strong>');
                return false;
            }
         });
    });

    function cerrarDialogo(){
        bp.dialog().dialog('open');
        bp.modal("hide");
    }

    function cerrarDialogo2(){
        bp2.dialog().dialog('open');
        bp2.modal("hide")
    }
</script>
