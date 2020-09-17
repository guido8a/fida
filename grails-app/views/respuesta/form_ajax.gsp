
<g:if test="${!respuestaInstance}">
    <elm:notFound elem="Tipo de Institución" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmRespuesta" role="form" action="save_ajax" method="POST" useToken="true">
        <g:hiddenField name="id" value="${respuestaInstance?.id}" />
        

        <div class="form-group ${hasErrors(bean: respuestaInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-4">
                    <g:select name="tipo" from="${['M': 'Selección Múltiple', 'N':'Numérico', 'T':'Texto']}"
                              optionValue="value" optionKey="key" class="form-control" value="${respuestaInstance?.tipo}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: respuestaInstance, field: 'opcion', 'error')} ">
            <span class="grupo">
                <label for="opcion" class="col-md-2 control-label text-info">
                    Opción
                </label>
                <div class="col-md-8">
                    <g:textArea name="opcion" maxlength="63" class="form-control required"
                                value="${respuestaInstance?.opcion}" style="height: 75px; resize: none"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTpin").validate({
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
            }
        });

        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>