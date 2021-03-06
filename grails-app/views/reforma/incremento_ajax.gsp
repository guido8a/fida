<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/12/15
  Time: 10:40 AM
--%>
<form id="frmIncremento">
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
        <label>Asignación:</label>
    </div>
    <div  class="col-md-5" id="divAsg">

    </div>
</div>

<div class="row">
    <div class="col-md-2">
        <label>Monto:</label>
    </div>

    <div  class="col-md-3">
        <div class="input-group">
        <g:textField type="text" name="monto" style="float: right" class="form-control required input-sm number money" value="${detalle?.valor}"/>
        <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
        </div>
    </div>
</div>
</form>


<script type="text/javascript">

    $("#proyecto").change(function () {
        $("#divComp").html(spinner);
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'modificacionesPoa', action:'componentesProyectoAjuste_ajax')}",
            data    : {
                id   : $("#proyecto").val(),
                anio : ${anio?.id}
            },
            success : function (msg) {
                $("#divComp").html(msg);
                $("#divAct").html("");
                $("#divAsg").html("");
            }
        });
    });

    <g:if test="${detalle}">
    $("#proyecto").val("${detalle?.componente?.proyecto?.id}").change();
    setTimeout(function () {
        $("#comp").val("${detalle?.componente?.id}").change();
        setTimeout(function () {
            $("#actividadRf").val("${ detalle?.asignacionOrigen?.marcoLogicoId}").change();
            setTimeout(function () {
                $("#asignacion").val("${detalle?.asignacionOrigenId}").change();
            }, 500);
        }, 500);
    }, 500);
    </g:if>

</script>