<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/09/20
  Time: 15:36
--%>

<%@ page import="parametros.proyectos.Fuente" %>

<div class="alert alert-success">
    <form class="form-inline" id="frmFinanciamientoPlan">
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
    <h4>Total del proyecto: <g:formatNumber number="${plan?.monto?.toDouble()}" type="currency" currencySymbol=""/></h4>
</div>


<script type="text/javascript">
    var total = parseFloat("${plan?.monto}");
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

    function reloadTablaFinanPlanNegocio() {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'planesNegocio', action:'tablaFinanciamientoPlan_ajax')}",
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
        reloadTablaFinanPlanNegocio();
        var $frm = $("#frmFinanciamientoPlan");
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
                    $('<label id="fuente-error" class="help-block text-danger" for="fuente">' +
                        'Por favor ingrese fuente no seleccionada aún' +
                        '</label>').insertAfter($(this));
                } else {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'planesNegocio', action:'saveFinanciamientoPlanNegocio_ajax')}",
                        data    : {
                            id     : "${plan.id}",
                            fuente : fuenteId,
                            monto  : monto
                        },
                        success : function (msg) {
                            if (msg == 'ok') {
                                log("Fuente agregada correctamente","success")
                                reloadTablaFinanPlanNegocio();
                            }else{
                                log("Error al agregar la fuente","error")
                            }
                        }
                    });
                }
            }
            return false;
        });
    });
</script>