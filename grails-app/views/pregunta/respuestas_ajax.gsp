<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/20
  Time: 11:09
--%>

<g:form class="form-horizontal" name="fmrRespuesta">
    <div class="form-group">
        <span class="grupo">
            <label for="tipo" class="col-md-2 control-label text-info">
                Tipo
            </label>
            <div class="col-md-4">
                <g:select from="${['M': 'Selección Múltiple', 'N':'Numérico', 'T':'Texto']}" name="tipo" class="form-control input-sm"
                          optionKey="key" optionValue="value" />
            </div>
        </span>

    </div>
    <div class="form-group">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Respuesta
            </label>
            <div class="col-md-8" id="divComboRespuestas">
            </div>
        </span>
        <a href="#" class="btn btn-success" id="btnAgregaRespuesta"><i class="fa fa-plus"></i> Agregar </a>
    </div>
    <div id="divTablaRespuestas">

    </div>
</g:form>

<script type="text/javascript">

    $("#tipo").change(function () {
        var tipo = $("#tipo option:selected").val();
        cargarComboRespuestas(tipo)
    });

    cargarComboRespuestas($("#tipo option:selected").val());

    function cargarComboRespuestas(tipo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'pregunta', action: 'comboRespuestas_ajax')}',
            data:{
                tipo: tipo
            },
            success: function (msg) {
                $("#divComboRespuestas").html(msg)
            }
        });
    }

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
                var parts = msg.split("_")
                if(parts[0] == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaRespuestas();
                }else{
                    if(parts[0] == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>" + parts[1])
                    }else{
                        log("Error al agregar la respuesta","error")
                    }
                }
            }
        })
    }
</script>
