


%{--//origen--}%
<form id="frmAsignacion">

    <div class="row">
        <div class="col-md-2">
            <label>Año: </label>
        </div>
        <div  class="col-md-8">
            <g:select from="${anios}" value="${actual.anio}" optionKey="id" optionValue="anio" name="anio"
                      class="form-control input-sm required requiredCombo" id="anioPro"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Proyecto: </label>
        </div>
        <div  class="col-md-8" id="divProy">

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

        <div  class="col-md-5">
            <div class="input-group">
                <g:textField type="text" name="monto" style="float: right" class="form-control required input-sm number money" value="${detalle?.valor}"/>
                <span class="input-group-addon"><i class="fa fa-dollar-sign"></i></span>
            </div>
        </div>

        <div class="col-md-2">
            <label>Saldo:</label>
        </div>

        <div id="max">

        </div>
    </div>
</form>

<script type="text/javascript">

    cargarAnio($("#anioPro").val());

    function cargarAnio(anio) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reforma', action:'asignacionOrigenProcesar_ajax')}",
            data    : {
                id: '${detalle?.id}',
                // anio   : $("#anioPro").val()
                anio   : anio
            },
            success : function (msg) {
                $("#divProy").html(msg);
                $("#divComp").html("");
                $("#divAct").html("");
                $("#divAsg").html("");
            }
        });
    }


    $("#anioPro").change(function () {
        $("#divProy").html(spinner);
        cargarAnio($(this).val());
    });


    <g:if test="${detalle}">
    $("#anioPro").val(${detalle?.anio?.id}).change();
    setTimeout(function () {
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
    }, 500);
    </g:if>

    function getMaximo(asg) {
        if ($("#asignacion").val() != "-1") {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'getMaximoAsg', controller: 'avales')}",
                data    : {
                    id : asg
                },
                success : function (msg) {
                    var valor = parseFloat(msg);
//                    console.log("valor " + valor)
                    var tot = 0;
                    $(".tableReformaNueva").each(function () {
                        var d = $(this).children().children().data("cod")
                        var parId = $(this).children().children().data("par")
                        var valorP = $(this).children().children().data("val")
                    });
//                    console.log("total " + tot)
                    var ok = valor - tot;
                    $("#max").html("$" + number_format(ok, 2, ".", ","))
                            .attr("valor", ok);
                    $("#monto").attr("tdnMax", ok);
                }
            });
        }
    }

    $("#frmAsignacion").validate({
        errorClass: "help-block",
        onfocusout: false,
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success: function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }
    });



</script>