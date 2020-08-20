<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 20/08/20
  Time: 9:41
--%>

<%@ page import="parametros.Anio; parametros.proyectos.Fuente" %>


<div class="alert alert-success">
    <form class="form-inline" id="frmFuentePlan">
        <div class="form-group">
            <label for="fuente">Fuente</label>
            <g:select name="fuente" from="${parametros.proyectos.Fuente.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion"
                      class="form-control input-sm" style="width:250px;"/>
        </div>

        <div class="form-group">
            <label for="montoFin">Monto</label>
            <div class="input-group input-group-sm">
                <g:textField name="montoFin" class="form-control input-sm required number money" style="width:150px;"/>
                <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
            </div>
        </div>

        <a href="#" class="btn btn-sm btn-success" id="btnAddFin"><i class="fa fa-plus"></i> Guardar</a>
    </form>
</div>

<div id="tabla"></div>


<div class="col-md-6 alert alert-success" id="divResto"  style="height: 40px"></div>

<div class="col-md-6 alert alert-info" style="height: 40px">
    <h4>Total del proyecto: <g:formatNumber number="${plan?.costo}" type="currency" currencySymbol=""/></h4>
</div>

<script type="text/javascript">
    var total = parseFloat("${plan?.costo}");
    var suma = 0;
    var restante = 0;

    function setSuma(val) {
        suma = val;
        var totalPorc = (100 * suma) / total;
        $("#tfSuma").text("$" + number_format(suma, 2, ".", ","));
        $("#tfPorc").text(number_format(totalPorc, 2, ".", ",") + "%");
    }
    function setRestante(val) {
        restante = val;
        $("#divResto").html('<h4>' + "Restante: $" + number_format(restante, 2, ".", ",") + '</h4>');
    }

    function reloadTabla() {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'plan', action:'tablaFuente_ajax')}",
            data    : {
                id : "${plan.id}"
            },
            success : function (msg) {
                $("#tabla").html(msg);
                $("#fuente").find("option").first().attr("selected", true);
                $("#montoFin").val("");
            }
        });
    }

    $(function () {
        reloadTabla();
        var $frm = $("#frmFuentePlan");
        $frm.validate({
            errorClass     : "help-block text-danger",
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
            },
            rules          : {
                monto : {
                    tdnMax : function () {
                        return parseFloat(number_format(restante, 2, ".", ""));
                    }
                }
            },
            messages       : {
                monto : {
                    tdnMax : "Por favor ingrese un valor inferior al restante"
                }
            }
        });

        $("#btnAddFin").click(function () {
            if ($frm.valid()) {
                var $tbody = $("#tbFin");
                var $selFuente = $("#fuente");
                var fuenteId = $selFuente.val();
                var monto = $.trim($("#montoFin").val());
                monto = parseFloat(str_replace(",", "", monto));
                var existe = false;
                $tbody.children("tr").each(function () {
                    var $this = $(this);
                    var fuente = $this.data("fuente");
                    if (fuente.toString() == fuenteId) {
                        existe = true;
                    }
                });
                if (existe) {
                    // $('<label id="fuente-error" class="help-block text-danger" for="fuente" style="font-size: 14px">' +
                    //     'Por favor ingrese una fuente no seleccionada aún' +
                    //     '</label>').insertAfter($(this));
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Por favor ingrese una fuente no seleccionada aún" + '</strong>');
                } else {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'plan', action:'saveFuente_ajax')}",
                        data    : {
                            id     : "${plan.id}",
                            fuente : fuenteId,
                            monto  : monto
                        },
                        success : function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] == 'ok'){
                                log("Fuente agregada correctamente","success");
                                reloadTabla();
                            }else{
                                if(parts[0] == 'er'){
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                    return false;
                                }else{
                                    log("Error al agregar la fuente","error")
                                }
                            }
                        }
                    });
                }
            }
            return false;
        });
    });
</script>