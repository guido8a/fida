%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
        <th>Número</th>
        <th>Indicador</th>
        <th>Descripción</th>
    </tr>
    </thead>
    <tbody id="tbDoc">
    <g:each in="${pregunta}" var="preg">
        <tr data-id="${preg.id}" style="width: 100%">
            <td style="width: 5%; text-align: center; background-color: #78b665">${preg?.numero}</td>
            <td style="width: 50%"><elm:textoBusqueda busca="${params.search}">
                ${preg?.indicador?.descripcion}</elm:textoBusqueda></td>
            <td style="width: 45%"><elm:textoBusqueda busca="${params.search}">${preg?.descripcion}</elm:textoBusqueda></td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(function () {
        $("tbody>tr").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                %{--ver: {--}%
                %{--    label: "Ver",--}%
                %{--    icon: "fa fa-search",--}%
                %{--    action: function ($element) {--}%
                %{--        var id = $element.data("id");--}%
                %{--        $.ajax({--}%
                %{--            type: "POST",--}%
                %{--            url: "${createLink(controller:'pregunta', action:'show_ajax')}",--}%
                %{--            data: {--}%
                %{--                id: id--}%
                %{--            },--}%
                %{--            success: function (msg) {--}%
                %{--                bootbox.dialog({--}%
                %{--                    title: "Ver Pregunta",--}%
                %{--                    message: msg,--}%
                %{--                    buttons: {--}%
                %{--                        ok: {--}%
                %{--                            label: "Aceptar",--}%
                %{--                            className: "btn-primary",--}%
                %{--                            callback: function () {--}%
                %{--                            }--}%
                %{--                        }--}%
                %{--                    }--}%
                %{--                });--}%
                %{--            }--}%
                %{--        });--}%
                %{--    }--}%
                %{--},--}%
                editar: {
                    label: "Editar",
                    icon: "fa fa-edit",
                    action: function ($element) {
                        var id = $element.data("id");
                        createEditPregunta(id);
                    }
                },
                respuestas: {
                    label: "Fijar Respuestas posibles",
                    icon: "fa fa-pen-nib",
                    action: function ($element) {
                        var id = $element.data("id");
                        cargarSeleccionados(id);
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        deletePregunta(id);
                    }
                }
            },
            onShow: function ($element) {
                $element.addClass("success");
            },
            onHide: function ($element) {
                $(".success").removeClass("success");
            }
        });

        function deletePregunta(id) {
            bootbox.confirm({
                size: "small",
                title: 'Alerta',
                message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de borrar esta pregunta?",
                callback: function(result){
                    if(result){
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'pregunta', action: 'borrarPregunta_ajax')}',
                            data:{
                                id: id
                            },
                            success: function (msg) {
                                if(msg == 'ok'){
                                    log("Pregunta borrada correctamente","success");
                                    reloadTablaPregunta();
                                }else{
                                    if(msg == 'er'){
                                        bootbox.alert({
                                            size: "small",
                                            title: "Alerta!!!",
                                            message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  La pregunta ya está siendo utilizada, no puede ser borrada!",
                                            callback: function(){}
                                        })
                                    }else{
                                        log("Error al borrar la pregunta","error")
                                    }
                                }
                            }
                        });
                    }
                }
            });
        }


        function cargarSeleccionados(id){
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'pregunta', action:'respuestas_ajax')}",
                data    : {
                    id: id
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEdit",
                        title   : "Cargar respuestas seleccionadas",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-save'></i> Guardar",
                                className : "btn-success",
                                callback  : function () {

                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
        }

    });
</script>