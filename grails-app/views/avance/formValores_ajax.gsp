

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmAvance" controller="avance" action="saveValores_ajax" method="POST">

        <g:hiddenField name="id" value="${avance?.id}"/>
        <g:hiddenField name="plan" value="${plan?.id}"/>
        <g:hiddenField name="informeAvance" value="${informe?.id}"/>

        <div class="form-group keeptogether ${hasErrors(bean: avance, field: 'extra', 'error')} ">
            <span class="grupo">
                <label for="extra" class="col-md-3 control-label">
                    Extra
                </label>
                <span class="col-md-4">
                    <g:textField name="extra"  class="form-control input-sm number"
                                 value="${avance?.extra ?: 0}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: avance, field: 'multa', 'error')} ">
            <span class="grupo">
                <label for="multa" class="col-md-3 control-label">
                    Multa
                </label>
                <span class="col-md-4">
                    <g:textField name="multa"  class="form-control input-sm number"
                                 value="${avance?.multa ?: 0}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: avance, field: 'interes', 'error')} ">
            <span class="grupo">
                <label for="interes" class="col-md-3 control-label">
                    Intereses
                </label>
                <span class="col-md-4">
                    <g:textField name="interes"  class="form-control input-sm number"
                                 value="${avance?.interes ?: 0}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: avance, field: 'valor', 'error')} ">
            <span class="grupo">
                <label for="valor" class="col-md-3 control-label">
                    Actual
                </label>
                <span class="col-md-4">
                    <g:textField name="valor"  class="form-control input-sm number"
                                 value="${avance?.valor ?: 0}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: avance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label">
                    Descripción
                </label>

                <span class="col-md-8">
                    <g:textArea name="descripcion" style="resize: none;" cols="40" rows="5" required="true" maxlength="1024" class="form-control input-sm required"
                                value="${avance?.descripcion ?: ''}"/>
                </span>
            </span>
        </div>

    </g:form>
</div>

<script type="text/javascript">

    $("#valor, #interes, #multa, #extra").keydown(function (ev) {
        return validarNumero(ev)
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
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39 ||
            ev.keyCode === 190 || ev.keyCode === 110
        );
    }



</script>

