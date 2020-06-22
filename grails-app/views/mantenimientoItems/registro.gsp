<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>REGISTRO Y MANT. DE ITEMS</title>

    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree', file: 'jquery.jstree.js')}"></script>--}%
    %{--        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree/_lib', file: 'jquery.cookie.js')}"></script>--}%

    %{--        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>--}%
    %{--        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>--}%

    %{--        <script src="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.js')}"></script>--}%
    %{--        <link href="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.css')}" rel="stylesheet"/>--}%
    %{--        <link href="${resource(dir: 'js/jquery/plugins/jgrowl', file: 'jquery.jgrowl.customThemes.css')}" rel="stylesheet"/>--}%


    %{--        <g:if test="${janus.Parametros.findByEmpresaLike(message(code: 'ambiente2'))}">--}%
    %{--            <link href="${resource(dir: 'css', file: 'treeV2.css')}" rel="stylesheet"/>--}%
    %{--        </g:if>--}%
    %{--        <g:else>--}%
    %{--            <link href="${resource(dir: 'css', file: 'tree.css')}" rel="stylesheet"/>--}%
    %{--        </g:else>--}%



    <asset:javascript src="/jstree/jquery.jstree.js"/>
    <asset:javascript src="/jstree/_lib/jquery.hotkeys.js"/>
    %{--    <asset:javascript src="/jgrowl/jquery.jgrowl.js"/>--}%
    <asset:stylesheet src="/apli/treeV2.css"/>
    %{--    <asset:stylesheet src="/jgrowl/jquery.jgrowl.css"/>--}%
    %{--    <asset:stylesheet src="/jgrowl/jquery.jgrowl.customThemes.css"/>--}%


</head>

<body>

<g:if test="${flash.message}">
    <div class="span12">
        <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
            <a class="close" data-dismiss="alert" href="#">×</a>
            ${flash.message}
        </div>
    </div>
</g:if>

<div class="col-md-12 btn-group" data-toggle="buttons-radio">
    <a href="#" id="1" class="btn btn-success toggle active">
        <i class="fa fa-box-open"></i>
        Bienes <!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
    </a>
    <a href="#" id="2" class="btn btn-warning toggle">
        <i class="fa fa-users-cog"></i>
        Servicios
    </a>
    %{--    <a href="#" id="3" class="btn btn-info toggle">--}%
    %{--        <i class="icon-truck"></i>--}%
    %{--        Equipos--}%
    %{--    </a>--}%

%{--    <form class="form-search" style="width: 700px; margin-left: 380px; margin-top: -30px;">--}%
%{--        <div class="input-append">--}%
%{--            <input type="text" class="input-medium search-query" id="search"/>--}%
%{--            <a href='#' class='btn' id="btnSearch"><i class='icon-zoom-in'></i> Buscar</a>--}%
%{--        </div>--}%
%{--        <span id="cantRes"></span>--}%
%{--        <input type="button" class="btn btn-info" value="Cerrar todo" onclick="$('#tree').jstree('close_all');">--}%
%{--    </form>--}%

    <div class="col-md-5">
        <form class="form-search">
            <input type="text" class="input-medium search-query" id="search"/>
            <a href='#' class='btn btn-success' id="btnSearch"><i class='icon-zoom-in'></i> Buscar</a>
            <span id="cantRes"></span>
            <input type="button" class="btn btn-info" value="Cerrar todo" onclick="$('#tree').jstree('close_all');">
        </form>
    </div>

</div>

<div id="loading" style="text-align:center;">
    %{--            <img src="${resource(dir: 'images', file: 'spinner_24.gif')}" alt="Cargando..."/>--}%
    <p>Cargando... Por favor espere.</p>
</div>

<div id="treeArea" >
    <div id="tree" class="ui-corner-all"></div>
    <div id="info" class="ui-corner-all"></div>
</div>

<div class="modal longModal hide fade" id="modal-tree">
    <div class="modal-header" id="modalHeader">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
    </div>

    <div class="modal-footer" id="modalFooter">
    </div>
</div>

<div class="modal hide fade" id="modal-small">
    <div class="modal-header" id="modalHeaderSmall">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitleSmall"></h3>
    </div>

    <div class="modal-body" id="modalBodySmall">
    </div>

    <div class="modal-footer" id="modalFooterSmall">
    </div>
</div>

<script type="text/javascript">

    // $.jGrowl.defaults.closerTemplate = '<div>[ cerrar todo ]</div>';

    var btn = $("<a href='#' class='btn btn-success' id='btnSearch'><i class='icon-zoom-in'></i> Buscar</a>");
    var urlSp = "${resource(dir: 'images', file: 'spinner.gif')}";
    var sp = $('<span class="add-on" id="btnSearch"><img src="' + urlSp + '"/></span>');

    var current = "1";

    var icons = {
        grupo_material           : '${assetPath(src: 'tree/carpeta2.png')}',
        grupo_manoObra           : '${assetPath(src: 'tree/carpeta5.png')}',
        grupo_equipo             : '${assetPath(src: 'tree/carpeta6.png')}',
        grupo_consultoria        : '${assetPath(src: 'tree/carpeta5.png')}',

        subgrupo_material        : '${assetPath(src: 'tree/carpeta.png')}',
        subgrupo_manoObra        : '${assetPath(src: 'tree/grupo_manoObra.png')}',
        subgrupo_equipo          : '${assetPath(src: 'tree/item_equipo.png')}',
        subgrupo_consultoria     : '${assetPath(src: 'tree/grupo_manoObra.png')}',

        departamento_material    : '${assetPath(src: 'tree/carpeta3.png')}',
        departamento_manoObra    : '${assetPath(src: 'tree/departamento_manoObra.png')}',
        departamento_equipo      : '${assetPath(src: 'tree/departamento_equipo.png')}',
        departamento_consultoria : '${assetPath(src: 'tree/departamento_manoObra.png')}',

        item_material            : '${assetPath(src: 'tree/item_material.png')}',
        item_manoObra            : '${assetPath(src: 'tree/item_manoObra.png')}',
        item_equipo              : '${assetPath(src: 'tree/item_equipo.png')}',
        item_consultoria         : '${assetPath(src: 'tree/item_material.png')}'
    };


    function showInfo() {
        var node = $.jstree._focused().get_selected();
        var parent = node.parent().parent();

        var nodeStrId = node.attr("id");
        var nodeText = $.trim(node.children("a").text());

        var nodeRel = node.attr("rel");
        var parts = nodeRel.split("_");
        var nodeNivel = parts[0];
        var nodeTipo = parts[1];

        parts = nodeStrId.split("_");
        var nodeId = parts[1];

        var url = "";

        console.log(nodeNivel, icons.grupo_material);

        switch (nodeNivel) {
            case "grupo":
                // console.log(nodeTipo);
                url = "${createLink(action:'showGr_ajax')}";
                if (nodeTipo == "manoObra") {
                    url = "${createLink(action:'showSg_ajax')}";
                }
                break;
            case "subgrupo":
                url = "${createLink(action:'showSg_ajax')}";
                break;
            case "departamento":
                url = "${createLink(action:'showDp_ajax')}";
                break;
            case "item":
                url = "${createLink(action:'showIt_ajax')}";
                break;
        }

        $.ajax({
            type    : "POST",
            url     : url,
            data    : {
                id : nodeId
            },
            success : function (msg) {
                $("#info").html(msg);
            }
        });
    }

    function createUpdate(params) {
//                console.log("params:", params);
        var obj = {
            label            : params.label,
            separator_before : params.sepBefore, // Insert a separator before the item
            separator_after  : params.sepAfter, // Insert a separator after the item
            icon             : params.icon,
            action           : function (obj) {
                $.ajax({
                    type     : "POST",
                    url      : params.url,
                    data     : params.data,
                    success  : function (msg) {
                        var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                        var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Guardar</a>');

                        btnSave.click(function () {
                            if ($("#frmSave").valid()) {
                                btnSave.replaceWith(spinner);
                                var url = $("#frmSave").attr("action");
                                $.ajax({
                                    type    : "POST",
                                    url     : url,
                                    data    : $("#frmSave").serialize(),
                                    success : function (msg) {
                                        var parts = msg.split("_");
                                        if (parts[0] == "OK") {
                                            if (params.action == "create") {
                                                if (params.open) {
                                                    $("#" + params.nodeStrId).removeClass("jstree-leaf").addClass("jstree-closed");
                                                    $('#tree').jstree("open_node", $("#" + params.nodeStrId));
                                                }
                                                $('#tree').jstree("create_node", $("#" + params.nodeStrId), params.where, {attr : {id : params.tipo + "_" + parts[2]}, data : parts[3]});
                                                $("#modal-tree").modal("hide");
                                                log(params.log + parts[3] + " creado correctamente");
                                            } else if (params.action == "update") {
                                                $("#tree").jstree('rename_node', $("#" + params.nodeStrId), parts[3]);
                                                $("#modal-tree").modal("hide");
                                                log(params.log + parts[3] + " editado correctamente");
                                                showInfo();
                                            }
                                        } else {
                                            $("#modal-tree").modal("hide");
                                            log("Ha ocurrido el siguiente error: " + parts[1], true);
                                        }
                                    }
                                });
                            }
//                                            $("#frmSave").submit();
                            return false;
                        });
                        if (params.action == "create") {
                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                        } else if (params.action == "update") {
                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");
                        }
                        $("#modalTitle").html(params.title);
                        $("#modalBody").html(msg);
//                                console.log("Botones", btnOk, btnSave)
                        $("#modalFooter").html("").append(btnOk).append(btnSave);
//                                console.log("Footer:", $("#modalFooter"))
                        $("#modal-tree").modal("show");
                    },
                    complete : function () {
                        $('#modalBody').animate({scrollTop : $('#frmSave').offset().top}, 'slow');
//                                console.log($('#nombre').focus())
//                                $('input').first().focus();
                    }
                });
            }
        };
        return obj;
    }

    function remove(params) {
        var obj = {
            label            : params.label,
            separator_before : params.sepBefore, // Insert a separator before the item
            separator_after  : params.sepAfter, // Insert a separator after the item
            icon             : params.icon,
            action           : function (obj) {

                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                var btnSave = $('<a href="#"  class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');
                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
                $("#modalTitle").html(params.title);
                $("#modalBody").html("<p>Está seguro de querer eliminar este " + params.confirm + "?</p>");
                $("#modalFooter").html("").append(btnOk).append(btnSave);
                $("#modal-tree").modal("show");

                btnSave.click(function () {
                    btnSave.replaceWith(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : params.url,
                        data    : params.data,
                        success : function (msg) {
                            var parts = msg.split("_");
                            if (parts[0] == "OK") {
                                $("#tree").jstree('delete_node', $("#" + params.nodeStrId));
                                $("#modal-tree").modal("hide");
                                log(params.log + " eliminado correctamente");
                                if ($("#" + params.parentStrId).children("ul").children().size() == 0) {
                                    $("#" + params.parentStrId).removeClass("hasChildren");
                                }
                            } else {
                                $("#modal-tree").modal("hide");
                                log("Ha ocurrido un error al eliminar", true);
                            }
                        }
                    });
                    return false;
                });
            }
        };
        return obj;
    }

    function createContextmenu(node) {
        var parent = node.parent().parent();

        var nodeStrId = node.attr("id");
        var nodeText = $.trim(node.children("a").text());

        var parentStrId = parent.attr("id");
        var parentText = $.trim(parent.children("a").text());

        var nodeRel = node.attr("rel");
        var parts = nodeRel.split("_");
        var nodeNivel = parts[0];
        var nodeTipo = parts[1];

        var parentRel = parent.attr("rel");
        parts = nodeRel.split("_");
        var parentNivel = parts[0];
        var parentTipo = parts[1];

        parts = nodeStrId.split("_");
        var nodeId = parts[1];

        parts = parentStrId.split("_");
        var parentId = parts[1];

        var nodeHasChildren = node.hasClass("hasChildren");
        var cantChildren = node.children("ul").children().size();
        nodeHasChildren = nodeHasChildren || cantChildren != 0;

        var menuItems = {}, lbl = "", item = "";

        switch (nodeTipo) {
            case "material":
                lbl = "o material";
                item = "Material";
                break;
            case "manoObra":
                lbl = "a mano de obra";
                item = "Mano de obra";
                break;
            case "equipo":
                lbl = "o equipo";
                item = "Equipo";
                break;
        }

//                console.log(nodeNivel);

        switch (nodeNivel) {
            case "grupo":
                if (current == 2) {
//                            nodeId = 21;
                    %{--                    menuItems.crearHijo = createUpdate({--}%
                    %{--                        action    : "create",--}%
                    %{--                        label     : "Nuevo subgrupo",--}%
                    %{--                        sepBefore : false,--}%
                    %{--                        sepAfter  : false,--}%
                    %{--                        icon      : icons["departamento_" + nodeTipo],--}%
                    %{--                        url       : "${createLink(action:'formDp_ajax')}",--}%
                    %{--                        data      : {--}%
                    %{--                            subgrupo : nodeId--}%
                    %{--                        },--}%
                    %{--                        open      : true,--}%
                    %{--                        nodeStrId : nodeStrId,--}%
                    %{--                        where     : "first",--}%
                    %{--                        tipo      : "dp",--}%
                    %{--                        log       : "Subgrupo ",--}%
                    %{--                        title     : "Nuevo subgrupo"--}%
                    %{--                    });--}%

                    menuItems.crearHijo = {
                        label: "<i class='fa fa-star text-warning'></i>  Nuevo Subgrupo",
                        action : function () {
                            createEditSubGrupo(null, nodeId)
                        }
                    }
                } else {
                    %{--menuItems.crearHijo = createUpdate({--}%
                    %{--    action    : "create",--}%
                    %{--    label     : "Nuevo grupo",--}%
                    %{--    icon      : icons["subgrupo_" + nodeTipo],--}%
                    %{--    sepBefore : false,--}%
                    %{--    sepAfter  : false,--}%
                    %{--    url       : "${createLink(action:'formSg_ajax')}",--}%
                    %{--    data      : {--}%
                    %{--        grupo : nodeId--}%
                    %{--    },--}%
                    %{--    open      : false,--}%
                    %{--    nodeStrId : nodeStrId,--}%
                    %{--    where     : "first",--}%
                    %{--    tipo      : "sg",--}%
                    %{--    log       : "Grupo ",--}%
                    %{--    title     : "Nuevo grupo"--}%
                    %{--});--}%

                    menuItems.crearHijo = {
                        label  : "<i class='fa fa-star text-info'></i> Nuevo grupo",
                        action : function () {
                            createEditGrupo(null, nodeId)
                        }
                    };
                }
                break;
            case "subgrupo":
            %{--menuItems.editar = createUpdate({--}%
            %{--    action    : "update",--}%
            %{--    label     : "Editar grupo",--}%
            %{--    icon      : icons.edit,--}%
            %{--    sepBefore : false,--}%
            %{--    sepAfter  : false,--}%
            %{--    url       : "${createLink(action:'formSg_ajax')}",--}%
            %{--    data      : {--}%
            %{--        grupo : parentId,--}%
            %{--        id    : nodeId--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    log       : "Grupo ",--}%
            %{--    title     : "Editar grupo"--}%
            %{--});--}%

                menuItems.editar = {
                    label  : "<i class='fa fa-pen text-info'></i> Editar grupo",
                    action : function () {
                        createEditGrupo(nodeId, null)
                    }
                };


                if (!nodeHasChildren) {
                    %{--menuItems.eliminar = remove({--}%
                    %{--    label       : "Eliminar grupo",--}%
                    %{--    sepBefore   : false,--}%
                    %{--    sepAfter    : false,--}%
                    %{--    icon        : icons.delete,--}%
                    %{--    title       : "Eliminar grupo",--}%
                    %{--    confirm     : "grupo",--}%
                    %{--    url         : "${createLink(action:'deleteSg_ajax')}",--}%
                    %{--    data        : {--}%
                    %{--        id : nodeId--}%
                    %{--    },--}%
                    %{--    nodeStrId   : nodeStrId,--}%
                    %{--    parentStrId : parentStrId,--}%
                    %{--    log         : "Grupo "--}%
                    %{--});--}%


                    // menuItems.eliminar = {
                    //     label: 'Eliminar grupo',
                    //     action : function () {
                    //         eliminarGrupo(null, parentId)
                    //     }
                    // }

                    menuItems.eliminar ={
                        label            : "<i class='fa fa-trash text-info'></i> Eliminar grupo",
                        separator_before : true,
                        action           : function () {
                            bootbox.confirm({
                                title: "Eliminar grupo",
                                message: "Está seguro de borrar este grupo? Esta acción no puede deshacerse.",
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
                                            url: '${createLink(controller: 'mantenimientoItems', action: 'borrarSubGrupo_ajax')}',
                                            data:{
                                                id: nodeId
                                            },
                                            success: function (msg) {
                                                dialog.modal('hide');
                                                if(msg == 'ok'){
                                                    log("Grupo borrado correctamente","success");
                                                    setTimeout(function () {
                                                        location.reload(true);
                                                    }, 1000);
                                                }else{
                                                    log("Error al borrar el grupo", "error")
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    }
                }
            %{--menuItems.crearHermano = createUpdate({--}%
            %{--    action    : "create",--}%
            %{--    label     : "Nuevo grupo",--}%
            %{--    icon      : icons[nodeRel],--}%
            %{--    sepBefore : true,--}%
            %{--    sepAfter  : true,--}%
            %{--    url       : "${createLink(action:'formSg_ajax')}",--}%
            %{--    data      : {--}%
            %{--        grupo : parentId--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    where     : "after",--}%
            %{--    tipo      : "sg",--}%
            %{--    log       : "Grupo ",--}%
            %{--    title     : "Nuevo grupo"--}%
            %{--});--}%

                menuItems.crearHermano = {
                    label  : "<i class='fa fa-star text-info'></i> Crear Grupo",
                    action : function () {
                        createEditGrupo(null, parentId)
                    }
                };

            %{--menuItems.crearHijo = createUpdate({--}%
            %{--    action    : "create",--}%
            %{--    label     : "Nuevo subgrupo",--}%
            %{--    sepBefore : false,--}%
            %{--    sepAfter  : false,--}%
            %{--    icon      : icons["departamento_" + nodeTipo],--}%
            %{--    url       : "${createLink(action:'formDp_ajax')}",--}%
            %{--    data      : {--}%
            %{--        subgrupo : nodeId--}%
            %{--    },--}%
            %{--    open      : true,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    where     : "first",--}%
            %{--    tipo      : "dp",--}%
            %{--    log       : "Subgrupo ",--}%
            %{--    title     : "Nuevo subgrupo"--}%
            %{--});--}%

                menuItems.crearHijo = {
                    label: "<i class='fa fa-star text-warning'></i> Nuevo Subgrupo",
                    action : function () {
                        createEditSubGrupo(null, nodeId)
                    }
                };

                break;
            case "departamento":

//                        if (current == 2) {
//                            parentId = 21;
//                        }

            %{--menuItems.editar = createUpdate({--}%
            %{--    action    : "update",--}%
            %{--    label     : "Editar subgrupo",--}%
            %{--    icon      : icons.edit,--}%
            %{--    sepBefore : false,--}%
            %{--    sepAfter  : false,--}%
            %{--    url       : "${createLink(action:'formDp_ajax')}",--}%
            %{--    data      : {--}%
            %{--        subgrupo : parentId,--}%
            %{--        id       : nodeId--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    log       : "Subgrupo ",--}%
            %{--    title     : "Editar subgrupo"--}%
            %{--});--}%

                menuItems.editar = {
                    label: "<i class='fa fa-pen text-warning'></i> Editar Subgrupo",
                    action : function () {
                        createEditSubGrupo(nodeId, parentId)
                    }
                };


                if (!nodeHasChildren) {
                    %{--menuItems.eliminar = remove({--}%
                    %{--    label       : "Eliminar subgrupo",--}%
                    %{--    sepBefore   : false,--}%
                    %{--    sepAfter    : false,--}%
                    %{--    icon        : icons.delete,--}%
                    %{--    title       : "Eliminar subgrupo",--}%
                    %{--    confirm     : "subgrupo",--}%
                    %{--    url         : "${createLink(action:'deleteDp_ajax')}",--}%
                    %{--    data        : {--}%
                    %{--        id : nodeId--}%
                    %{--    },--}%
                    %{--    nodeStrId   : nodeStrId,--}%
                    %{--    parentStrId : parentStrId,--}%
                    %{--    log         : "Subgrupo "--}%
                    %{--});--}%

                    menuItems.eliminar = {
                        label            : "<i class='fa fa-trash text-warning'></i> Eliminar Subgrupo",
                        separator_before : true,
                        action           : function () {
                            bootbox.confirm({
                                title: "Eliminar Subgrupo",
                                message: "Está seguro de borrar este subgrupo? Esta acción no puede deshacerse.",
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
                                            url: '${createLink(controller: 'mantenimientoItems', action: 'borrarDepartamento_ajax')}',
                                            data:{
                                                id: nodeId
                                            },
                                            success: function (msg) {
                                                dialog.modal('hide');
                                                if(msg == 'ok'){
                                                    log("Subgrupo borrado correctamente","success");
                                                    setTimeout(function () {
                                                        location.reload(true);
                                                    }, 1000);
                                                }else{
                                                    log("Error al borrar el subgrupo", "error")
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    }


                }
            %{--menuItems.crearHermano = createUpdate({--}%
            %{--    action    : "create",--}%
            %{--    label     : "Nuevo subgrupo",--}%
            %{--    sepBefore : true,--}%
            %{--    sepAfter  : true,--}%
            %{--    icon      : icons[nodeRel],--}%
            %{--    url       : "${createLink(action:'formDp_ajax')}",--}%
            %{--    data      : {--}%
            %{--        subgrupo : parentId--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    where     : "after",--}%
            %{--    tipo      : "dp",--}%
            %{--    log       : "Subgrupo ",--}%
            %{--    title     : "Nuevo subgrupo"--}%
            %{--});--}%
                menuItems.crearHermano = {
                    label: "<i class='fa fa-star text-warning'></i> Nuevo Subgrupo",
                    action : function () {
                        createEditSubGrupo(null, parentId)
                    }
                };
            %{--menuItems.crearHijo = createUpdate({--}%
            %{--    action    : "create",--}%
            %{--    label     : "Nuev" + lbl,--}%
            %{--    sepBefore : false,--}%
            %{--    sepAfter  : false,--}%
            %{--    icon      : icons["item_" + nodeTipo],--}%
            %{--    url       : "${createLink(action:'formIt_ajax')}",--}%
            %{--    data      : {--}%
            %{--        departamento : nodeId,--}%
            %{--        grupo        : current--}%
            %{--    },--}%
            %{--    open      : true,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    where     : "first",--}%
            %{--    tipo      : "it",--}%
            %{--    log       : item + " ",--}%
            %{--    title     : "Nuevo " + item.toLowerCase()--}%
            %{--});--}%

                menuItems.crearHijo = {
                    label: "<i class='fa fa-star text-success'></i> Nuevo " + item,
                    action : function () {
                        createEditItem(null, nodeId, item)
                    }
                };

                break;
            case "item":


            %{--menuItems.editar = createUpdate({--}%
            %{--    action    : "update",--}%
            %{--    label     : "Editar " + item.toLowerCase(),--}%
            %{--    icon      : icons.edit,--}%
            %{--    sepBefore : false,--}%
            %{--    sepAfter  : false,--}%
            %{--    url       : "${createLink(action:'formIt_ajax')}",--}%
            %{--    data      : {--}%
            %{--        departamento : parentId,--}%
            %{--        id           : nodeId,--}%
            %{--        grupo        : current--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    log       : item + " ",--}%
            %{--    title     : "Editar " + item.toLowerCase()--}%
            %{--});--}%


                menuItems.editar = {
                    label: "<i class='fa fa-pen text-success'></i> Editar " + item,
                    action : function () {
                        createEditItem(nodeId, parentId, item)
                    }
                };


            %{--menuItems.info = {--}%
            %{--    label            : "Información",--}%
            %{--    separator_before : false, // Insert a separator before the item--}%
            %{--    separator_after  : false, // Insert a separator after the item--}%
            %{--    icon             : icons.info,--}%
            %{--    action           : function (obj) {--}%
            %{--        $.ajax({--}%
            %{--            type    : "POST",--}%
            %{--            url     : "${createLink(action: 'infoItems')}",--}%
            %{--            data    : {--}%
            %{--                id : nodeId--}%
            %{--            },--}%
            %{--            success : function (msg) {--}%
            %{--                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Aceptar</a>');--}%
            %{--                $("#modalHeader").removeClass("btn-edit btn-show btn-delete");--}%

            %{--                $("#modalTitle").html("Información del item");--}%
            %{--                $("#modalBody").html(msg);--}%
            %{--                $("#modalFooter").html("").append(btnOk);--}%
            %{--                $("#modal-tree").modal("show");--}%
            %{--            }--}%
            %{--        });--}%
            %{--    }--}%
            %{--};--}%
            %{--menuItems.copiar = {--}%
            %{--    label            : "Copiar a oferentes",--}%
            %{--    separator_before : false, // Insert a separator before the item--}%
            %{--    separator_after  : false, // Insert a separator after the item--}%
            %{--    icon             : icons.copiar,--}%
            %{--    action           : function (obj) {--}%
            %{--        $.ajax({--}%
            %{--            type    : "POST",--}%
            %{--            url     : "${createLink(action: 'copiarOferentes')}",--}%
            %{--            data    : {--}%
            %{--                id : nodeId--}%
            %{--            },--}%
            %{--            success : function (msg) {--}%
            %{--                var p = msg.split("_");--}%
            %{--                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Aceptar</a>');--}%
            %{--                $("#modalTitleSmall").html("Información");--}%
            %{--                if (p[0] == "OK") {--}%
            %{--                    $("#modalBodySmall").html("El item fue copiado a oferentes");--}%
            %{--                } else {--}%
            %{--                    $("#modalBodySmall").html(p[1]);--}%
            %{--                }--}%
            %{--                $("#modalFooterSmall").html("").append(btnOk);--}%
            %{--                $("#modal-small").modal("show");--}%
            %{--            }--}%
            %{--        });--}%
            %{--    }--}%
            %{--};--}%
                if (!nodeHasChildren) {
                    %{--menuItems.eliminar = {--}%
                    %{--    label            : "Eliminar",--}%
                    %{--    separator_before : false, // Insert a separator before the item--}%
                    %{--    separator_after  : false, // Insert a separator after the item--}%
                    %{--    icon             : icons.delete,--}%
                    %{--    action           : function (obj) {--}%
                    %{--        $.ajax({--}%
                    %{--            type    : "POST",--}%
                    %{--            url     : "${createLink(action: 'infoItems')}",--}%
                    %{--            data    : {--}%
                    %{--                id     : nodeId,--}%
                    %{--                delete : 1--}%
                    %{--            },--}%
                    %{--            success : function (msg) {--}%
                    %{--                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Aceptar</a>');--}%
                    %{--                $("#modalHeader").removeClass("btn-edit btn-show btn-delete");--}%

                    %{--                $("#modalTitle").html("Eliminar item");--}%
                    %{--                $("#modalBody").html(msg);--}%
                    %{--                $("#modalFooter").html("").append(btnOk);--}%
                    %{--                $("#modal-tree").modal("show");--}%
                    %{--            }--}%
                    %{--        });--}%
                    %{--    }--}%
                    %{--};--}%


                    menuItems.eliminar ={
                        label            : "<i class='fa fa-trash text-success'></i> Eliminar " + item,
                        separator_before : true,
                        action           : function () {
                            bootbox.confirm({
                                title: "Eliminar material",
                                message: "Está seguro de borrar este material? Esta acción no puede deshacerse.",
                                buttons: {
                                    cancel: {
                                        label: '<i class="fa fa-times"></i> Cancelar',
                                        className: 'btn-primary'
                                    },
                                    confirm: {
                                        label: '<i class="fa fa-trash"></i> Borrar',
                                        className: 'btn-danger'
                                    }
                                },        edit                     : '<asset:image src="/tree/edit.png"/>',
        delete                   : '<asset:image src="/tree/delete.gif"/>',
        info                     : '<asset:image src="/tree/info.png"/>',
        copiar                   : '<asset:image src="/tree/copiar.png"/>',


                                callback: function (result) {
                                    if(result){
                                        var dialog = cargarLoader("Borrando...");
                                        $.ajax({
                                            type: 'POST',
                                            url: '${createLink(controller: 'mantenimientoItems', action: 'borrarItem_ajax')}',
                                            data:{
                                                id: nodeId
                                            },
                                            success: function (msg) {
                                                dialog.modal('hide');
                                                if(msg == 'ok'){
                                                    log("Material borrado correctamente","success");
                                                    setTimeout(function () {
                                                        location.reload(true);
                                                    }, 1000);
                                                }else{
                                                    log("Error al borrar el material", "error")
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    }
                }
            %{--menuItems.crearHermano = createUpdate({--}%
            %{--    action    : "create",--}%
            %{--    label     : "Nuev" + lbl,--}%
            %{--    sepBefore : true,--}%
            %{--    sepAfter  : true,--}%
            %{--    icon      : icons[nodeRel],--}%
            %{--    url       : "${createLink(action:'formIt_ajax')}",--}%
            %{--    data      : {--}%
            %{--        departamento : parentId,--}%
            %{--        grupo        : current--}%
            %{--    },--}%
            %{--    open      : false,--}%
            %{--    nodeStrId : nodeStrId,--}%
            %{--    where     : "after",--}%
            %{--    tipo      : "it",--}%
            %{--    log       : item + " ",--}%
            %{--    title     : "Nuevo " + item--}%
            %{--});--}%

                menuItems.crearHermano = {
                    label: "<i class='fa fa-star text-success'></i> Nuevo " + item,
                    action : function () {
                        createEditItem(null, parentId, item)
                    }
                };
                break;
        }

        return menuItems;
    }

    function createEditGrupo(id, parentId) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formSubGrupo_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditGrupo",
                    title : title + " Grupo",
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
                                return submitFormGrupo();
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


    function createEditSubGrupo(id, parentId) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formDepartamento_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditSubGrupo",
                    title : title + " Sub Grupo",
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
                                return submitFormSubGrupo();
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


    function createEditItem(id, parentId, tipo) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        data.tipo = tipo
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'mantenimientoItems', action:'formItem_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditItem",
                    // title : title + " Material",
                    title : title + " " + tipo,
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
                                return submitFormItem();
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


    function submitFormGrupo() {
        var $form = $("#frmSave-grupoInstance");
        var $btn = $("#dlgCreateEditGrupo").find("#btnSave");
        if ($form.valid()) {
            $("#grupo").attr("disabled", false);
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

    function submitFormSubGrupo() {
        var $form = $("#frmSave-subGrupoInstance");
        var $btn = $("#dlgCreateEditSubGrupo").find("#btnSave");
        if ($form.valid()) {
            $("#subgrupo").attr("disabled", false);
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

    function submitFormItem() {
        var $form = $("#frmSave-itemInstance");
        var $btn = $("#dlgCreateEditItem").find("#btnSave");
        if ($form.valid()) {
            $("#departamento").attr("disabled", false);
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

    function initTree(tipo) {
        var id, rel, label;
        var li = "";

        switch (tipo) {
            case "1":
                id = "materiales_1";
                rel = "grupo_material";
                label = " MATERIALES";
                li = "<li id='" + id + "' class='root hasChildren jstree-closed' rel='" + rel + "' ><a href='#' class='label_arbol'>" + label + "</a></li>";
                break;
            case "2":
                $.ajax({
                    type    : "POST",
                    async   : false,
                    url     : "${createLink(action:'loadMO')}",
                    success : function (msg) {
                        var p = msg.split("*");
                        li = p[0];
                        id = p[1];
                    }
                });
                break;
            case "3":
                id = "equipos_3";
                rel = "grupo_equipo";
                label = "Equipos";
                li = "<li id='" + id + "' class='root hasChildren jstree-closed' rel='" + rel + "' ><a href='#' class='label_arbol'>"  +  label + "</a></li>";
                break;
        }
        $("#tree").bind("loaded.jstree",
            function (event, data) {
                $("#loading").hide();
                $("#treeArea").show();
            }).jstree({
            "core"        : {
                "initially_open" : [ id ]
            },
            "plugins"     : ["themes", "html_data", "json_data", "ui", "types", "contextmenu", "search", "crrm"/*, "dnd"/*, "wholerow"*/],
            "html_data"   : {
                "data" : "<ul type='root'>" + li + "</ul>",
                "ajax" : {
                    "url"   : "${createLink(action: 'loadTreePart')}",
                    "data"  : function (n) {
                        var obj = $(n);
                        var id = obj.attr("id");
                        var parts = id.split("_");
                        id = 0;
                        if (parts.length > 1) {
                            id = parts[1]
                        }
                        var tipo = obj.attr("rel");
                        return {id : id, tipo : tipo}
                    },
                    success : function (data) {
                    },
                    error   : function (data) {
                    }
                }
            },
            "types"       : {
                "valid_children" : [ "grupo_material", "grupo_manoObra", "grupo_equipo"  ],
                "types"          : {
                    "grupo_material"        : {
                        "icon" : {
                            // 'image' : "/assets/tree/carpeta.png",
                            'image' : icons.grupo_material,
                        },
                        "valid_children" : [ "subgrupo_material" ]
                    },
                    "subgrupo_material"     : {
                        "icon" : {
                            'image' : icons.subgrupo_material,
                        },
                        "valid_children" : [ "departamento_material" ]
                    },
                    "departamento_material" : {
                        "icon" : {
                            'image': icons.departamento_material,
                        },
                        "valid_children" : [ "item_material" ]
                    },
                    "item_material"         : {
                        "icon" : {
                            'image': icons.item_material,
                        },
                        "valid_children" : [ "" ]
                    },

                    "grupo_manoObra"        : {
                        "icon"           : {
                            "image" : icons.grupo_manoObra
                        },
                        "valid_children" : [ "departamento_manoObra" ]
                    },
                    "subgrupo_manoObra"     : {
                        "icon"           : {
                            "image" : icons.subgrupo_manoObra
                        },
                        "valid_children" : [ "departamento_manoObra" ]
                    },
                    "departamento_manoObra" : {
                        "icon"           : {
                            "image" : icons.departamento_manoObra
                        },
                        "valid_children" : [ "item_manoObra" ]
                    },
                    "item_manoObra"         : {
                        "icon"           : {
                            "image" : icons.item_manoObra
                        },
                        "valid_children" : [ "" ]
                    },

                    "grupo_equipo"        : {
                        "icon"           : {
                            "image" : icons.grupo_equipo
                        },
                        "valid_children" : [ "subgrupo_equipo" ]
                    },
                    "subgrupo_equipo"     : {
                        "icon"           : {
                            "image" : icons.subgrupo_equipo
                        },
                        "valid_children" : [ "departamento_equipo" ]
                    },
                    "departamento_equipo" : {
                        "icon"           : {
                            "image" : icons.departamento_equipo
                        },
                        "valid_children" : [ "item_equipo" ]
                    },
                    "item_equipo"         : {
                        "icon"           : {
                            "image" : icons.item_equipo
                        },
                        "valid_children" : [ "" ]
                    }
                }
            },
            themes         : {
                variant : "small",
                dots    : true,
                stripes : true
            },
            "search"      : {
                "case_insensitive" : true,
                "ajax"             : {
                    "url"    : "${createLink(action:'searchTree_ajax')}",
                    "data"   : function () {
                        return { search : this.data.search.str, tipo : current }
                    },
                    complete : function () {
                        $("#btnSearch").replaceWith(btn);
                        btn.click(function () {
                            doSearch();
                        });
                    }
                }
            },
            "contextmenu" : {
                select_node : true,
                "items"     : createContextmenu
            }, //contextmenu
            "ui"          : {
                "select_limit" : 1
            }
        }).bind("search.jstree",function (e, data) {
            var cant = data.rslt.nodes.length;
            var search = data.rslt.str;
            $("#cantRes").html("<b>" + cant + "</b> resultado" + (cant == 1 ? "" : "s"));
            if (cant > 0) {
                var container = $('#tree'), scrollTo = $('.jstree-search').first();
                container.animate({
                    scrollTop : scrollTo.offset().top - container.offset().top + container.scrollTop()
                }, 2000);
            }
        }).bind("select_node.jstree", function (NODE, REF_NODE) {
            showInfo();
        });
    }

    function doSearch() {
        var val = $.trim($("#search").val());
        if (val != "") {
            $("#btnSearch").replaceWith(sp);
            $("#tree").jstree("search", val);
        }
    }

    $(function () {

        $(".modal").draggable({
            handle : $(".modal-header"),
            cancel : '.btn, input, select'
        });

        $("#search").val("");

        $(".toggle").click(function () {
            var tipo = $(this).attr("id");
            if (tipo != current) {
                current = tipo;
                initTree(current);
            }
        });

        initTree("1");

        $("#btnSearch").click(function () {
            doSearch();
        });

        $("#search").keyup(function (ev) {
            if (ev.keyCode == 13) {
                doSearch();
            }
        });

        var cache = {};
        %{--$("#search").autocomplete({--}%
        %{--    minLength : 3,--}%
        %{--    source    : function (request, response) {--}%
        %{--        var term = request.term;--}%
        %{--        if (term in cache) {--}%
        %{--            response(cache[ term ]);--}%
        %{--            return;--}%
        %{--        }--}%

        %{--        $.ajax({--}%
        %{--            type     : "POST",--}%
        %{--            dataType : 'json',--}%
        %{--            url      : "${createLink(action: 'search_ajax')}",--}%
        %{--            data     : {--}%
        %{--                search : term,--}%
        %{--                tipo   : current--}%
        %{--            },--}%
        %{--            success  : function (data) {--}%
        %{--                cache[ term ] = data;--}%
        %{--                response(data);--}%
        %{--            }--}%
        %{--        });--}%

        %{--    }--}%
        %{--});--}%

    });
</script>

</body>
</html>
