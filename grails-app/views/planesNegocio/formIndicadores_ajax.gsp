<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/20
  Time: 13:21
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 12:01
--%>

<g:form class="form-horizontal" name="fmrNecesidad">
    <div class="form-group">
        <span class="grupo">
            <label for="planesNegocio" class="col-md-2 control-label text-info">
                Plan
            </label>
            <div class="col-md-8">
                <g:select from="${planes.PlanesNegocio.list().sort{it.nombre}}" name="planesNegocio" class="form-control input-sm"
                          value="${plan?.id}" optionKey="id" optionValue="nombre" disabled=""/>
            </div>
        </span>
    </div>
    <div class="form-group">
        <span class="grupo">
            <label for="indicadores" class="col-md-2 control-label text-info">
                Indicador
            </label>
            <div class="col-md-8">
                <g:select from="${planes.Indicadores.list().sort{it.descripcion}}" name="indicadores" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="descripcion" />
            </div>
            <a href="#" class="btn btn-success" id="btnAgregarIndicador"><i class="fa fa-plus"></i> Agregar </a>
        </span>
    </div>
    <div id="divTablaIndicador">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaIndicadores();

    function cargarTablaIndicadores(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'planesNegocio', action: 'tablaIndicadores_ajax')}',
            data:{
                id: '${plan?.id}'
            },
            success: function (msg) {
                $("#divTablaIndicador").html(msg)
            }
        });
    }

    $("#btnAgregarIndicador").click(function () {
        var indicador = $("#indicadores option:selected").val();
        agregarIndicador(indicador);
    });

    function agregarIndicador(indicador){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'planesNegocio', action: 'agregarIndicador_ajax')}',
            data:{
                id: '${plan?.id}',
                indicador: indicador
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaIndicadores();
                }else{
                    if(msg == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>  El tipo de indicador seleccionado ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar el indicador","error")
                    }
                }
            }
        })
    }
</script>
