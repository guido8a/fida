<%@ page import="parametros.proyectos.TipoElemento; proyectos.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Plan de Proyecto</title>



</head>

<body>

<g:set var="editable" value="${proyecto.aprobado != 'a'}"/>
<g:if test="${params.list != 'list'}">
    <g:set var="editable" value="${false}"/>
</g:if>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="proyecto" action="proy" id="1" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Regresar a proyectos
        </g:link>
    </div>
    <g:if test="${editable || (session.perfil.codigo == 'ASPL')}">
        <div class="btn-group">
            <a href="#" class="btn btn-sm btn-success" id="btnAddComp" title="Agregar componente"
               data-show="${componentes.size()}">
                <i class="fa fa-plus"></i> componente
            </a>
        </div>
    </g:if>
</div>

<g:if test="${proyecto.aprobado == 'a'}">
    <div class="alert alert-info">
        El proyecto está aprobado, no puede modificar ni agregar componentes ni actividades
    </div>
</g:if>

<div class="panel-primary col-md-12" style="text-align: left; font-size: 14px;">
    <strong>Marco Lógico: </strong> <strong style="color: #5596ff; "> ${proyecto?.nombre}</strong>
</div>

<g:if test="${componentes.size() > 0}">
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top: 50px">
        <g:set var="tc" value="0"/>
        <g:each in="${componentes}" var="comp" status="k">
            <g:set var="compInfo" value="Componente ${comp.numero ?: 's/n'}:
                                ${(comp?.objeto?.size() > 40) ? comp?.objeto?.substring(0, 40) + "..." : comp.objeto}"/>
            <div class="panel panel-success">
                <div class="panel-heading" role="tab" id="headingComp${k + 1}">
                    <h4 class="panel-title" data-toggle="collapse" data-parent="#accordion" href="#componente${k + 1}"
                        aria-expanded="${k + 1 == params.show.toInteger() ? 'true' : 'false'}" aria-controls="componente${k + 1}">
                        <a href="#">
                            ${compInfo}
                        </a>
                        <g:if test="${editable}">
                            <span class="btn-group pull-right">
                                <a href="#" class="btn btn-xs btn-success btnAddAct" title="Agregar actividad"
                                   data-id="${comp.id}" data-show="${k + 1}">
                                    <i class="fa fa-plus"></i> Actividad
                                </a>
                                <a href="#" class="btn btn-xs btn-info btnEditComp" title="Editar componente"
                                   data-id="${comp.id}" data-show="${k + 1}">
                                    <i class="far fa-edit"></i> Editar Componente
                                </a>
                                <a href="#" class="btn btn-xs btn-danger btnDeleteComp" title="Eliminar componente"
                                   data-id="${comp.id}" data-info="${compInfo}">
                                    <i class="far fa-trash-alt"></i>
                                </a>
                            </span>
                        </g:if>
                    </h4>
                </div>

                <div id="componente${k + 1}" class="panel-collapse collapse ${k + 1 == params.show.toInteger() ? 'in' : ''}"
                     role="tabpanel" aria-labelledby="headingComp${k + 1}">
                    <table class="table table-bordered table-condensed table-hover azul">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%">#</th>
                            <th style="width: 60%">Actividad</th>
                            <th style="width: 15%">Monto</th>
                            <th style="width: 15%">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:set var="total" value="${0}"/>
                        <g:each in="${MarcoLogico.findAllByMarcoLogicoAndEstado(comp, 0, [sort: 'numero'])}" var="act" status="l">
                            <g:set var="total" value="${total.toDouble() + act.monto}"/>
                            <tr data-id="${act.id}" data-show="${k + 1}" data-info="${act.objeto}">
                                <td class="text-center">${act.numero}</td>
                                <td>${act?.objeto}</td>
                                <td class="text-right"><g:formatNumber number="${act.monto}" type="currency" currencySymbol=""/></td>
                                <g:if test="${editable}">
                                    <td style="text-align: center">
                                        <div class="btn-group ">
                                            <a href="#" class="btn btn-xs btn-info btnEditAct" title="Editar actividad"
                                               data-id="${act.id}" data-show="${k}" data-com="${act?.marcoLogico?.id}">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="#" class="btn btn-xs btn-danger btnDeleteAct" title="Eliminar actividad"
                                               data-id="${act.id}" data-show="${k}" data-info="${act.objeto}">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                            <a href="#" class="btn btn-xs btn-warning btnCronoAct" title="Cronograma"
                                               data-id="${act.id}" data-show="${k}">
                                                <i class="fa fa-calendar"></i>
                                            </a>
                                        </div>
                                    </td>
                                </g:if>
                            </tr>
                        </g:each>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th colspan="2">Subtotal</th>
                            <th class="text-right"><g:formatNumber number="${total}" type="currency" currencySymbol=""/></th>
                        </tr>
                        </tfoot>
                        <g:set var="tc" value="${tc.toDouble() + total}"/>
                    </table>
                </div>
            </div>
        </g:each>
    </div>

    <div class="alert alert-info">
        <h4>TOTAL: <g:formatNumber number="${tc}" type="currency" currencySymbol=""/></h4>
    </div>
    <elm:modal titulo="Crear Respaldo" id="modal-respaldo">
        <div class="modal-body">
            <div class="row">
                <div class="col-md-2">
                    <label>Descripción</label>
                </div>
                <div class="col-md-10">
                    <input type="text" class="form-control input-sm required" id="desc-resp">
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn btn-success btn-sm" id="guardar-respaldo">
                <i class="fa fa-save"></i>Guardar
            </a>
            <a href="#" class="btn btn-danger btn-sm">Cerrar</a>
        </div>

    </elm:modal>
    <script type="text/javascript">
        $("#respaldo").click(function(){
            $("#modal-respaldo").modal("show")
        });
        $("#guardar-respaldo").click(function(){
            var desc = $("#desc-resp").val()
            if(desc.length>0){
                openLoader()

                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'marcoLogico',action: 'crearRespaldo')}",
                    data    : {
                        id:"${proyecto.id}",
                        desc:desc
                    },
                    success : function (msg) {
                        closeLoader()
                        $("#modal-respaldo").modal("hide")
                        bootbox.alert({
                                message: "Respaldo creado correctamente",
                                title :"Listo"
                            }
                        );
                    }
                });
            }else{
                $("#modal-respaldo").modal("hide")
                bootbox.alert({
                        message: "Ingrese una descripción",
                        title :"Error",
                        class : "modal-error"
                    }
                );
            }

        });
    </script>
</g:if>
<g:if test="${editable}">
    <script type="text/javascript">
        function submitFormComponente(show) {
            var $form = $("#frmComponente");
            var $btn = $("#dlgCreateEditComponente").find("#btnSave");
            if ($form.valid()) {
                $btn.replaceWith(spinner);
                var dialog = cargarLoader("Guardando...");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : $form.serialize(),
                    success : function (msg) {
                        dialog.modal('hide');
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        setTimeout(function () {
                            if (parts[0] == "SUCCESS") {
                                location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto', id:proyecto.id, params:reqParams)}&show=" + show;
                            } else {
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }, 1000);
                    }
                });
            } else {
                return false;
            } //else
        }
        function createEditComponente(show, id) {
            var title = id ? "Editar" : "Crear";
            var data = id ? {id : id} : {};
            data.proyecto = "${proyecto.id}";
            data.tipoElemento = '${TipoElemento.findByDescripcion("Componente").id}';
            data.show = show;
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'marcoLogico', action:'form_componente_ajax')}",
                data    : data,
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEditComponente",
                        title   : title + " Componente",
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
                                    return submitFormComponente(show);
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        } //createEdit

        function submitFormActividad(show) {
            var $form = $("#frmActividad");
            var $btn = $("#dlgCreateEditActividad").find("#btnSave");
            if ($form.valid()) {
                $btn.replaceWith(spinner);
                var dialog = cargarLoader("Guardando...");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : $form.serialize(),
                    success : function (msg) {
                        dialog.modal('hide');
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        setTimeout(function () {
                            if (parts[0] == "SUCCESS") {
                                location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto', id:proyecto.id, params:reqParams)}&show=" + show;
                            } else {
                                closeLoader();
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }, 1000);
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "error");
                    }
                });
            } else {
                return false;
            } //else
        }
        function createEditActividad(show, componente, id) {
            var title = id ? "Editar" : "Crear";
            var data = id ? {id : id} : {};
            data.proyecto = "${proyecto.id}";
            data.tipoElemento = '${TipoElemento.findByDescripcion("Actividad").id}';
            data.show = show;
            if (componente) {
                data.marcoLogico = componente;
            }
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'marcoLogico', action:'form_actividad_ajax')}",
                data    : data,
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEditActividad",
                        title   : title + " Actividad",
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
                                    return submitFormActividad(show);
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
        } //createEdit

        function deleteMarcoLogico(itemId, itemInfo, tipo) {
            var str = "Componente";
            var infoDel = "El componente no se eliminará si tiene actividades, metas o asignaciones asociadas.";
            if (tipo == "act") {
                str = "Actividad";
                infoDel = "La actividad no se eliminará si tiene metas o asignaciones asociadas.";
            }
            bootbox.dialog({
                title   : "Alerta",
                message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i>" +
                    "<p>¿Está seguro que desea eliminar <span class='text-danger'><strong>" + itemInfo + "</strong></span>?</p>" +
                    "<p>Esta acción no se puede deshacer.</p>" +
                    "<p>" + infoDel + "</p>",
                buttons : {
                    cancelar : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                        }
                    },
                    eliminar : {
                        label     : "<i class='fa fa-trash-o'></i> Eliminar",
                        className : "btn-danger",
                        callback  : function () {
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type    : "POST",
                                url     : '${createLink(controller:'marcoLogico', action:'delete_marcoLogico_ajax')}',
                                data    : {
                                    id   : itemId,
                                    tipo : tipo
                                },
                                success : function (msg) {
                                    dialog.modal('hide');
                                    var parts = msg.split("*");
                                    if (parts[0] == "SUCCESS") {
                                        log(parts[1],"success");
                                        setTimeout(function () {
                                            location.reload(true);
                                        }, 1000);
                                    } else {
                                        closeLoader();
                                        bootbox.alert(parts[1]);

                                    }
                                }
                            });
                        }
                    }
                }
            });
        }

        $(function () {

            %{--$("tbody>tr").contextMenu({--}%
            %{--    items  : {--}%
            %{--        header     : {--}%
            %{--            label  : "Acciones",--}%
            %{--            header : true--}%
            %{--        },--}%
            %{--        editar     : {--}%
            %{--            label  : "Editar",--}%
            %{--            icon   : "fa fa-pencil",--}%
            %{--            action : function ($element) {--}%
            %{--                var id = $element.data("id");--}%
            %{--                var show = $element.data("show");--}%
            %{--                createEditActividad(show, null, id);--}%
            %{--            }--}%
            %{--        },--}%
            %{--        cronograma : {--}%
            %{--            label  : "Cronograma",--}%
            %{--            icon   : "fa fa-calendar",--}%
            %{--            action : function ($element) {--}%
            %{--                var id = $element.data("id");--}%
            %{--                var show = $element.data("show");--}%
            %{--                location.href = "${createLink(controller: 'cronograma', action:'show', id:proyecto.id)}?act=" + id + "&list=${reqParams.list}";--}%
            %{--            }--}%
            %{--        },--}%
            %{--        eliminar   : {--}%
            %{--            label            : "Eliminar",--}%
            %{--            icon             : "fa fa-trash-o",--}%
            %{--            separator_before : true,--}%
            %{--            action           : function ($element) {--}%
            %{--                var id = $element.data("id");--}%
            %{--                var info = $element.data("info");--}%
            %{--                deleteMarcoLogico(id, info, "act");--}%
            %{--            }--}%
            %{--        }--}%
            %{--    },--}%
            %{--    onShow : function ($element) {--}%
            %{--        $element.addClass("success");--}%
            %{--    },--}%
            %{--    onHide : function ($element) {--}%
            %{--        $(".success").removeClass("success");--}%
            %{--    }--}%
            %{--});--}%

            $("#btnAddComp").click(function () {

                var s = $(this).data("show");

                <g:if test="${proyecto?.fechaRegistro}">
                bootbox.confirm({
                    size: "small",
                    title: 'Alerta',
                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿El proyecto ya se encuentra registrado, está seguro de modificar el marco lógico?",
                    buttons: {
                        confirm: {
                            label: 'Aceptar',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancelar',
                            className: 'btn-primary'
                        }
                    },
                    callback: function(result){
                        if(result){
                            createEditComponente(s);
                            // return false;
                        }
                    }
                });
                </g:if>
                <g:else>
                createEditComponente(s);
                return false;
                </g:else>
                %{--                --}%
                %{--                --}%
//                createEditComponente($(this).data("show"));
//                return false;
            });

            $(".btnEditComp").click(function () {

                var s = $(this).data("show");
                var id = $(this).data("id");

                <g:if test="${proyecto?.fechaRegistro}">
                bootbox.confirm({
                    size: "small",
                    title: 'Alerta',
                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿El proyecto ya se encuentra registrado, está seguro de modificar el marco lógico?",
                    buttons: {
                        confirm: {
                            label: 'Aceptar',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancelar',
                            className: 'btn-primary'
                        }
                    },
                    callback: function(result){
                        if(result){
                            createEditComponente(s, id);
                        }
                    }
                });
                </g:if>
                <g:else>
                createEditComponente(s, id);
                return false;
                </g:else>
            });

            $(".btnDeleteComp").click(function () {
                deleteMarcoLogico($(this).data("id"), $(this).data("info"), "comp");
                return false;
            });

            $(".btnAddAct").click(function () {

                var s = $(this).data("show");
                var id = $(this).data("id");

                <g:if test="${proyecto?.fechaRegistro}">
                bootbox.confirm({
                    size: "small",
                    title: 'Alerta',
                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿El proyecto ya se encuentra registrado, está seguro de modificar el marco lógico?",
                    buttons: {
                        confirm: {
                            label: 'Aceptar',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancelar',
                            className: 'btn-primary'
                        }
                    },
                    callback: function(result){
                        if(result){
                            createEditActividad(s,id);
                            // return false;
                        }
                    }
                });
                </g:if>
                <g:else>
                createEditActividad(s,id);
                return false;
                </g:else>
            });

            $(".btnEditAct").click(function () {


                var s = $(this).data("show");
                var id = $(this).data("id");
                var c = $(this).data("com");

                <g:if test="${proyecto?.fechaRegistro}">
                bootbox.confirm({
                    size: "small",
                    title: 'Alerta',
                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿El proyecto ya se encuentra registrado, está seguro de modificar el marco lógico?",
                    buttons: {
                        confirm: {
                            label: 'Aceptar',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancelar',
                            className: 'btn-primary'
                        }
                    },
                    callback: function(result){
                        if(result){
                            createEditActividad(s,c,id);
                            // return false;
                        }
                    }
                });
                </g:if>
                <g:else>
                createEditActividad(s,c,id);
                return false;
                </g:else>


                // createEditActividad($(this).data("show"), $(this).data("com"), $(this).data("id"));
                // return false;
            });

            $(".btnDeleteAct").click(function () {
                deleteMarcoLogico($(this).data("id"), $(this).data("info"), "act");
                return false;
            });

            $(".btnCronoAct").click(function () {
                var id = $(this).data("id");
                location.href = "${createLink(controller: 'cronograma', action:'show', id:proyecto.id)}?act=" + id + "&list=${reqParams.list}";
            });

        });
    </script>
</g:if>
<g:else>
    <script type="text/javascript">

        $("#btnAddComp").click(function () {
            createEditComponente($(this).data("show"));
            return false;
        });

        function submitFormComponente(show) {
            var $form = $("#frmComponente");
            var $btn = $("#dlgCreateEditComponente").find("#btnSave");
            if ($form.valid()) {
                $btn.replaceWith(spinner);
                var dialog = cargarLoader("Guardando...");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : $form.serialize(),
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        setTimeout(function () {
                            if (parts[0] == "SUCCESS") {
                                location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto', id:proyecto.id, params:reqParams)}&show=" + show;
                            } else {
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }, 1000);
                    }
                });
            } else {
                return false;
            } //else
        }

        function createEditComponente(show, id) {
            var title = id ? "Editar" : "Crear";
            var data = id ? {id : id} : {};
            data.proyecto = "${proyecto.id}";
            data.tipoElemento = '${TipoElemento.findByDescripcion("Componente").id}';
            data.show = show;
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'marcoLogico', action:'form_componente_ajax')}",
                data    : data,
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEditComponente",
                        title   : title + " Componente",
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
                                    return submitFormComponente(show);
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
        } //createEdit

        function numeroActividad(show, dscr, id) {
            var title = id ? "Editar" : "Crear";
            var data = id ? {id : id} : {};
            data.proyecto = "${proyecto.id}";
            data.tipoElemento = '${TipoElemento.findByDescripcion("Actividad").id}';
            data.show = show;
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'marcoLogico', action:'cambiaNumero_ajax')}",
                data    : data,
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEditActividad",
                        title   : "Cambia el número de la actividad:<p>" + dscr + "</p>",
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
                                    return submitFormNumero(show);
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

        function submitFormNumero(show) {
            var $form = $("#frmaActividad");
            var $btn = $("#dlgCreateEditActividad").find("#btnSave");
            if ($form.valid()) {
                $btn.replaceWith(spinner);
                openLoader("Guardando Actividad");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : $form.serialize(),
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        setTimeout(function () {
                            if (parts[0] == "SUCCESS") {
                                location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto', id:proyecto.id, params:reqParams)}";
                            } else {
                                closeLoader();
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }, 1000);
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "error");
                    }
                });
            } else {
                return false;
            } //else
        }


        $(function () {
            $("tbody>tr").contextMenu({
                items  : {
                    header     : {
                        label  : "Acciones",
                        header : true
                    },
                    editar     : {
                        label  : "Cambiar número",
                        icon   : "fa fa-pencil",
                        action : function ($element) {
                            var id = $element.data("id");
                            var dscr = $element.data("info");
                            var show = $element.data("show");
                            numeroActividad(show, dscr, id);
                        }
                    },
                    cronograma : {
                        label  : "Cronograma",
                        icon   : "fa fa-calendar",
                        action : function ($element) {
                            var id = $element.data("id");
                            var show = $element.data("show");
                            location.href = "${createLink(controller: 'cronograma', action:'show', id:proyecto.id)}?act=" + id + "&list=${reqParams.list}";
                        }
                    }
                },
                onShow : function ($element) {
                    $element.addClass("success");
                },
                onHide : function ($element) {
                    $(".success").removeClass("success");
                }
            });
        });
    </script>
</g:else>
</body>
</html>