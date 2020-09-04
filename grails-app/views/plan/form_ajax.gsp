<%@ page import="poa.Presupuesto" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!grupoAc}">
    <elm:notFound elem="grupoActividad" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmGrupoAc" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${grupoAc?.id}"/>
            <g:hiddenField name="padre.id" value="${grupoAc?.padreId}"/>
            <g:hiddenField name="plns" value="${plns}"/>

            <div class="form-group keeptogether ${hasErrors(bean: grupoAc, field: 'padre', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label">
                        Padre
                    </label>

                    <div class="col-md-10">
                        <p class="form-control-static">
                            ${grupoAc?.padre?.toString()}
                        </p>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: grupoAc, field: 'numero', 'error')} ">
                <span class="grupo">
                    <label for="numero" class="col-md-2 control-label">
                        Número
                    </label>

                    <div class="col-md-6">
                        <g:if test="${grupoAc.id}">
                            <p class="form-control-static">
                                ${grupoAc?.numero}
                            </p>
                        </g:if>
                        <g:else>
                            <g:textField name="numero" maxlength="15" class="form-control input-sm"
                                         value="${grupoAc?.numero}"/>
                        </g:else>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: grupoAc, field: 'descripcion', 'error')} ">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>

                    <div class="col-md-10">
                        <g:textArea name="descripcion" cols="40" rows="3" maxlength="255" class="form-control input-sm"
                                    value="${grupoAc?.descripcion}"/>
                    </div>
                </span>
            </div>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmPresupuesto").validate({
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
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormPresupuesto();
                return false;
            }
            return true;
        });
    </script>

</g:else>