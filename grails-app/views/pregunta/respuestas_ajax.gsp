<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/20
  Time: 11:09
--%>


<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 12:01
--%>

<g:form class="form-horizontal" name="fmrRespuesta">
    <div class="form-group">
        <span class="grupo">
            <label for="respuesta" class="col-md-2 control-label text-info">
                Respuesta
            </label>
            <div class="col-md-8">
                <g:select from="${preguntas.Respuesta.list().sort{it.id}}" name="respuesta" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="opcion" />
            </div>
        </span>
        <a href="#" class="btn btn-success" id="btnAgregaRespuesta"><i class="fa fa-plus"></i> Agregar </a>
    </div>
    <div id="divTablaRespuestas">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaRespuestas();

    function cargarTablaRespuestas(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'pregunta', action: 'tablaRespuesta_ajax')}',
            data:{
                id: '${pregunta?.id}'
            },
            success: function (msg) {
                $("#divTablaRespuestas").html(msg)
            }
        });
    }

    $("#btnAgregaRespuesta").click(function () {
        var res = $("#respuesta option:selected").val();
        agregarRespuesta(res);
    });

    function agregarRespuesta(res){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'pregunta', action: 'agregarRespuestaSeleccionada_ajax')}',
            data:{
                id: '${pregunta?.id}',
                respuesta: res
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaRespuestas();
                }else{
                    if(msg == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> La respuesta seleccionada ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar la respuesta","error")
                    }
                }
            }
        })
    }
</script>
