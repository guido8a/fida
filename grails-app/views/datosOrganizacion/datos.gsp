<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 24/08/20
  Time: 12:46
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Datos de Organización</title>
</head>
<body>

<div class="panel panel-primary col-md-12">
    <h3>Datos de Organización</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <g:form class="form-horizontal" name="frmSaveDatos" controller="datosOrganizacion" action="saveDatos_ajax">
            <g:hiddenField name="id" value="${dato?.id}"/>

            <div class="form-group ${hasErrors(bean: dato, field: 'unidadEjecutora', 'error')}  ">
                <span class="grupo">
                    <label for="unidadEjecutora_nombre" class="col-md-2 control-label text-info">
                        Unidad Ejecutora
                    </label>
                    <div class="col-md-6">
                        <g:hiddenField name="unidadEjecutora" value="${unidad?.id}"/>
                        <g:select from="${seguridad.UnidadEjecutora.list().sort{it.nombre}}" name="unidadEjecutora_nombre" class="form-control input-sm"
                                  value="${unidad?.id}" optionKey="id" optionValue="nombre" disabled=""/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'cuenta', 'error')} ${hasErrors(bean: dato, field: 'financiera', 'error')} ">
                <div class="col-md-1"></div>
                <span class="grupo">
                    <div class="col-md-4">
                        <label for="financiera" class="control-label text-info">
                            Entidad Financiera
                        </label>
                        <g:textField name="financiera" value="${dato?.financiera}" maxlenght="127" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <div class="col-md-3">
                        <label for="cuenta" class="control-label text-info">
                            Número cuenta
                        </label>
                        <g:textField name="cuenta" value="${dato?.cuenta}" maxlenght="20" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <div class="col-md-3">
                        <label for="tipoCuenta" class="control-label text-info">
                            Tipo de cuenta
                        </label>
                        <g:select name="tipoCuenta" from="${[0:'Ahorros', 1:'Corriente']}" optionValue="value" optionKey="key" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'legales', 'error')} ${hasErrors(bean: dato, field: 'noLegales', 'error')}  ">
                <span class="grupo">
                    <label for="legales" class="col-md-2 control-label text-info">
                        Socios Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="legales" value="${dato?.legales}" maxlength="3" class="form-control input-sm number "/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="noLegales" class="col-md-2 control-label text-info">
                        Socios No Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="noLegales" value="${dato?.noLegales}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="totalSocios" class="col-md-2 control-label text-info">
                        Total de Socios
                    </label>
                    <div class="col-md-1">
                        <g:textField name="totalSocios" value="${(dato?.legales + dato?.noLegales) ?: 0}" readonly="" class="form-control input-sm number totalSoc"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>

            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'familiasLegales', 'error')} ${hasErrors(bean: dato, field: 'familiasNoLegales', 'error')}  ">
                <span class="grupo">
                    <label for="familiasLegales" class="col-md-2 control-label text-info">
                        Familias Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="familiasLegales" value="${dato?.familiasLegales}" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="familiasNoLegales" class="col-md-2 control-label text-info">
                        Familias No Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="familiasNoLegales" value="${dato?.familiasNoLegales}" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="totalFamilias" class="col-md-2 control-label text-info">
                        Total de Familias
                    </label>
                    <div class="col-md-1">
                        <g:textField name="totalFamilias" value="${(dato?.familiasLegales + dato?.familiasNoLegales) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>

        </g:form>
    </div>
</div>

<script type="text/javascript">

    // $("#legales, #noLegales").on("change keyup blur",function () {
    //     var totalS = 0;
    //     var l =  $("#legales").val();
    //     var nl = $("#noLegales").val();
    //     totalS += parseInt(l);
    //     totalS += parseInt(nl);
    //     $("#totalSocios").val(totalS)
    // });

    $("#legales, #noLegales").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#legales, #noLegales").on("change keyup blur",function () {
                var totalS = 0
                var l =  $("#legales").val();
                var nl = $("#noLegales").val();
                totalS += parseInt(l)
                totalS += parseInt(nl)
                // console.log("total " + totalS)
                $("#totalSocios").val(totalS)
            });
        }else{
           return false
        }
    });

    // $("#familiasLegales, #familiasNoLegales").on("change keyup blur",function () {
    //     var totalS = 0;
    //     var l =  $("#familiasLegales").val();
    //     var nl = $("#familiasNoLegales").val();
    //     totalS += parseInt(l);
    //     totalS += parseInt(nl);
    //     $("#totalSocios").val(totalS)
    // });

    $("#familiasLegales, #familiasNoLegales").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#familiasLegales, #familiasNoLegales").on("change keyup blur",function () {
                var totalF = 0
                var l2 =  $("#familiasLegales").val();
                var nl2 = $("#familiasNoLegales").val();
                totalF += parseInt(l2)
                totalF += parseInt(nl2)
                // console.log("total " + totalS)
                $("#totalFamilias").val(totalF)
            });
        }else{
            return false
        }
    });

    function validarNumero(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39);
    }


</script>

</body>
</html>