<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/06/20
  Time: 12:20
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:javascript src="/jstree-3.0.8/dist/jstree.min.js"/>
    <asset:stylesheet src="/jstree-3.0.8/dist/themes/default/style.min.css"/>
    <meta name="layout" content="main">

    <title>Estructura de Unidades Ejecutoras</title>


    <style type="text/css">
    #tree {
        overflow-y : auto;
        height     : 700px;
    }

    .jstree-search {
        color : #5F87B2 !important;
    }
    </style>

</head>

<body>

<div id="cargando" class="text-center">
    <p>Cargando...</p>

    <img src="${resource(dir: 'images', file: 'spinner.gif')}" alt='Cargando...' width="64px" height="64px"/>

    <p>Por favor espere</p>
</div>

<div class="row" style="margin-bottom: 10px;">

   <div class="col-md-2">
        <div class="input-group input-group-sm">
            <g:textField name="searchArbol" class="form-control input-sm" placeholder="Buscador"/>
            <span class="input-group-btn">
                <a href="#" id="btnSearchArbol" class="btn btn-sm btn-info">
                    <i class="fa fa-search"></i>&nbsp;
                </a>
            </span>
        </div><!-- /input-group -->
    </div>

    <div class="col-md-3 hidden" id="divSearchRes">
        <span id="spanSearchRes">
            5 resultados
        </span>

        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnNextSearch" title="Siguiente">
                <i class="fa fa-chevron-down"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnPrevSearch" title="Anterior">
                <i class="fa fa-chevron-up"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnClearSearch" title="Limpiar búsqueda">
                <i class="fa fa-times-circle"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-1">
        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnCollapseAll" title="Cerrar todos los nodos">
                <i class="fa fa-minus-square"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnExpandAll" title="Abrir todos los nodos">
                <i class="fa fa-plus-square"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-5 text-right pull-right" style="font-size: 14px">
        <i class="fas fa-warehouse text-success fa-1x"></i> Unidad Ejecutora / <i class="fa fa-home text-success fa-1x"></i> Organización
        <i class="fa fa-user-circle text-primary fa-2x" style="margin-left: 50px"></i> Persona
    </div>
</div>

<div id="tree" class="well hidden">

</div>

<script type="text/javascript">
    var searchRes = [];
    var posSearchShow = 0;
    var $treeContainer = $("#tree");

    function createEditUnidad(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'unidadEjecutora', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEdit",
                    title : title + " Unidad Ejecutora",
                    // class : "modal-lg",
                    message : msg,
                    class : "modal-lg",
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
                                return submitFormUnidad();
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

    function createEditPersona(id, parentId) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditPersona",
                    title : title + " Usuario",
                    class : "modal-lg",
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
                                return submitFormPersona();
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

    function submitFormUnidad() {
        var $form = $("#frmSaveUnidad");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log(parts[1], "success");
                        setTimeout(function () {
                            var dialog = cargarLoader("Cargando...");
                            location.reload(true);
                        }, 1000);
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function submitFormPersona() {
        var $form = $("#frmPersona");
        var $btn = $("#dlgCreateEditPersona").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log(parts[1], "success");
                        setTimeout(function () {
                            var dialog = cargarLoader("Cargando...");
                            location.reload(true);
                        }, 1000);
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function createContextMenu(node) {
        $(".lzm-dropdown-menu").hide();

        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;

        // var nodeParentId = $node.parent().parent().children()[1].id.split("_")[1]
        // console.log("n " + nodeParentId)
        // var nodeText = $node.children("a").first().text();

        var esRoot = nodeType == "root";
        var esPrincipal = nodeType == "unidadEjecutora";
        var esCanton = nodeType.contains("canton");
        var esPersona = nodeType.contains("persona");
        var tieneHijos = $node.hasClass("hasChildren");
        var inactivo = $node.hasClass("inactivo");
        var tienePresupuesto = $node.hasClass("presupuesto");

        var items = {};

        var agregarUnidad = {
            label  : "Agregar Unidad Ejecutora",
            // icon   : "fa fa-underline text-success",
            icon   : "fa fa-building text-success",
            action : function () {
                createEditUnidad(null);
            }
        };

        var agregarPersona = {
            label  : "Agregar Usuario",
            icon   : "fa fa-user-circle text-info",
            action : function () {
                createEditPersona(null, nodeId);
            }
        };

        var agregarPersona2 = {
            label  : "Agregar Usuario",
            icon   : "fa fa-user-circle text-info",
            action : function () {
                createEditPersona(null, $node.parent().parent().children()[1].id.split("_")[1]);
            }
        };

        var editarUnidad = {
            label  : "Editar Unidad Ejecutora",
            icon   : "fa fa-pen text-warning",
            action : function () {
                createEditUnidad(nodeId);
            }
        };

        var editarPersona = {
            label  : "Editar Usuario",
            icon   : "fa fa-pen text-warning",
            action : function () {
                createEditPersona(nodeId, null);
            }
        };

        var verUnidad = {
            label            : "Ver datos de la Unidad Ejecutora",
            icon             : "fa fa-laptop text-primary",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "unidadEjecutora", action:'show_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Unidad Ejecutora",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var verPersona = {
            label            : "Ver datos del usuario",
            icon             : "fa fa-laptop text-primary",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "persona", action:'show_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Usuario",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var borrarUnidadEjecutora = {
            label            : "Borrar Unidad Ejecutora",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Unidad Ejecutora",
                    message: "Está seguro de borrar esta unidad ejecutora? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'unidadEjecutora', action: 'borrarUnidad_ajax')}',
                                data:{
                                    id: nodeId
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    var parts = msg.split("_");
                                    if(parts[0] == 'ok'){
                                        log("Unidad borrada correctamente","success");
                                        setTimeout(function () {
                                            var dialog = cargarLoader("Cargando...");
                                            location.reload(true);
                                        }, 1000);
                                    }
                                     else{
                                         if(parts[0] == 'res'){
                                             bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                             return false;
                                         }else{
                                             log("Error al borrar la unidad", "error")
                                         }
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        var borrarPersona = {
            label            : "Borrar Usuario",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar usuario",
                    message: "Está seguro de borrar este usuario? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'persona', action: 'borrarPersona_ajax')}',
                                data:{
                                    id: nodeId
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Usuario borrado correctamente","success");
                                        setTimeout(function () {
                                            var dialog = cargarLoader("Cargando...");
                                            location.reload(true);
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el usuario", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

        var presupuestoEntidad = {
            label            : "Presupuesto de la Unidad",
            icon             : "fa fa-dollar-sign text-success",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: 'unidadEjecutora',  action:'presupuestoEntidad_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Presupuesto de la Unidad",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    label     : "Guardar",
                                    icon      : "fa fa-save",
                                    className : "btn-success",
                                    callback  : function () {
                                        var $frm = $("#frmPresupuestoEntidad");
                                        if ($frm.valid()) {
                                            var dialog = cargarLoader("Cargando...");
                                            var data = $frm.serialize();
                                            data += "&unidad=" + nodeId;
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(controller: 'unidadEjecutora', action:'savePresupuestoEntidad_ajax')}",
                                                data    : data,
                                                success : function (msg) {
                                                    var parts = msg.split("*");
                                                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                    dialog.modal('hide')
                                                }
                                            });
                                            return true;
                                        }
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var perfiles = {
            label            : "Perfiles del usuario",
            icon             : "fa fa-list text-primary",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "persona", action:'perfiles_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Perfiles",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        if (esRoot) {
            items.agregarUnidad = agregarUnidad;
        } else if (esPrincipal) {
            items.agregarUnidad = agregarUnidad;
            items.agregarPersona = agregarPersona;
            items.verUnidad = verUnidad;
            items.editarUnidad = editarUnidad;
            if(!tieneHijos){
                items.borrarUnidad = borrarUnidadEjecutora;
            }
            if(tienePresupuesto){
                items.presupuesto = presupuestoEntidad;
            }

        }
        else if(esCanton){
            items.agregarUnidad = agregarUnidad;
        }
        else if (esPersona) {
            items.agregarPersona = agregarPersona2;
            items.verPersona = verPersona;
            items.editarPersona = editarPersona;
            if(!inactivo){
             items.perfiles = perfiles;
            }
        }
        return items;
    }

    function scrollToNode($scrollTo) {
        $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
            scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
        });
    }

    function scrollToRoot() {
        var $scrollTo = $("#root");
        scrollToNode($scrollTo);
    }

    function scrollToSearchRes() {
        var $scrollTo = $(searchRes[posSearchShow]).parents("li").first();
        $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
        scrollToNode($scrollTo);
    }

    $(function () {

        $treeContainer.on("loaded.jstree", function () {
            $("#cargando").hide();
            $("#tree").removeClass("hidden");

        }).on("select_node.jstree", function (node, selected, event) {
        }).jstree({
            plugins     : ["types", "state", "contextmenu", "search"],
            core        : {
                multiple       : false,
                check_callback : true,
                themes         : {
                    variant : "small",
                    dots    : true,
                    stripes : true
                },
                data           : {
                    // async : false,
                    url   : '${createLink(controller: 'unidadEjecutora' , action:"loadTreePart_ajax")}',
                    data  : function (node) {
                        return {
                            id    : node.id,
                            sort  : "${params.sort?:'nombre'}",
                            order : "${params.order?:'asc'}"
                        };
                    }
                }
            },
            contextmenu : {
                show_at_node : false,
                items        : createContextMenu
            },
            state       : {
                key : "unidades",
                opened: false
            },
            search      : {
                fuzzy             : false,
                show_only_matches : false,
                ajax              : {
                    url     : "${createLink(controller: 'unidadEjecutora', action:'arbolSearch_ajax')}",
                    success : function (msg) {
                        var json = $.parseJSON(msg);
                        $.each(json, function (i, obj) {
                            $('#tree').jstree("open_node", obj);
                        });
                        setTimeout(function () {
                            searchRes = $(".jstree-search");
                            var cantRes = searchRes.length;
                            posSearchShow = 0;
                            $("#divSearchRes").removeClass("hidden");
                            $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                            scrollToSearchRes();
                        }, 300);
                    }
                }
            },
            types       : {
                root                : {
                    icon : "fa fa-sitemap text-info"
                },
/*
                unidadPadreActivo   : {
                    icon : "fa fa-building text-info"
                },
                unidadPadreInactivo : {
                    icon : "fa fa-building text-muted"
                },
                unidadHijoActivo    : {
                    icon : "fa fa-home text-success"
                },
                unidadHijoInactivo  : {
                    icon : "fa fa-home text-muted"
                },
*/
                usuarioActivo       : {
                    icon : "fa fa-user text-info"
                },
                usuarioInactivo     : {
                    icon : "fa fa-user text-muted"
                }
            }
        });

        $("#btnExpandAll").click(function () {
            $treeContainer.jstree("open_all");
            scrollToRoot();
            return false;
        });

        $("#btnCollapseAll").click(function () {
            $treeContainer.jstree("close_all");
            scrollToRoot();
            return false;
        });

        $('#btnSearchArbol').click(function () {
            $treeContainer.jstree("open_all");
            $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
            return false;
        });
        $("#searchArbol").keypress(function (ev) {
            if (ev.keyCode == 13) {
                $treeContainer.jstree("open_all");
                $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                return false;
            }
        });

        $("#btnPrevSearch").click(function () {
            if (posSearchShow > 0) {
                posSearchShow--;
            } else {
                posSearchShow = searchRes.length - 1;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnNextSearch").click(function () {
            if (posSearchShow < searchRes.length - 1) {
                posSearchShow++;
            } else {
                posSearchShow = 0;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnClearSearch").click(function () {
            $treeContainer.jstree("clear_search");
            $("#searchArbol").val("");
            posSearchShow = 0;
            searchRes = [];
            scrollToRoot();
            $("#divSearchRes").addClass("hidden");
            $("#spanSearchRes").text("");
        });

    });


</script>

</body>
</html>