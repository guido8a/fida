<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/09/20
  Time: 10:22
--%>

<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reportes</title>

    %{--    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}"></script>--}%

    <style type="text/css">

    .tab-content, .left, .right {
        height : 500px;
    }

    .tab-content {
        background    : #EEEEEE;
        border-left   : solid 1px #DDDDDD;
        border-bottom : solid 1px #DDDDDD;
        border-right  : solid 1px #DDDDDD;
        padding-top   : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 600px;
        text-align: justify;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 20px;
        padding: 20px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .example_c {
        color: #808b9d !important;
        /*text-transform: uppercase;*/
        text-decoration: none;
        background: #ffffff;
        padding: 20px;
        border: 4px solid #78b665 !important;
        display: inline-block;
        transition: all 0.4s ease 0s;
    }

    .example_c:hover {
        color: #ffffff !important;
        background: #f6b93b;
        border-color: #f6b93b !important;
        transition: all 0.4s ease 0s;
    }


    .mensaje {
        color: #494949 !important;
        /*text-transform: uppercase;*/
        text-decoration: none;
        background: #ffffff;
        padding: 20px;
        border: 4px solid #f6b93b !important;
        display: inline-block;
        transition: all 0.4s ease 0s;
    }

    </style>


</head>

<body>


<g:set var="iconGen" value="fa fa-cog"/>
<g:set var="iconEmpr" value="fa fa-building-o"/>

%{--<ul class="nav nav-tabs">--}%
<ul class="nav nav-pills">
    <li class="active"><a data-toggle="pill" href="#generales">Generales</a></li>
    <li><a data-toggle="pill" href="#obra">POA</a></li>
    <li><a data-toggle="pill" href="#cont">Datos geográficos</a></li>
</ul>

<div class="tab-content">
    <div id="generales" class="tab-pane fade in active">

        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>
                    %{--                    <g:link class="link btn btn-info btn-ajax example_c item" texto="grgf"  controller="reportes" action="mapa">--}%
                    %{--                        <i class="fa fa-map-marked-alt fa-4x text-success"></i>--}%
                    %{--                        <br/> Localización de proyectos--}%
                    %{--                    </g:link>--}%

                    <a href="#" id="btnOrganizaciones" class="btn btn-info btn-ajax example_c item" texto="trnp">
                        <i class="fa fa-building fa-4x text-success"></i>
                        <br/> Organizaciones
                    </a>
                    <a href="#" id="btnSocios" class="btn btn-info btn-ajax example_c item" texto="dire">
                        <i class="fa fa-users fa-4x text-success"></i>
                        <br/> Socios
                    </a>
                    <a href="#" id="btnEncuestas" class="btn btn-info btn-ajax example_c item" texto="undd">
                        <i class="fa fa-paste fa-4x text-success"></i>
                        <br/> Encuestas
                    </a>
                </p>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>
                    <a href="#" id="btnTalleres" class="btn btn-info btn-ajax example_c item" texto="func">
                        <i class="fa fa-book-medical fa-4x text-success"></i>
                        <br/> Talleres
                    </a>
                    <a href="#" id="btnCapacitaciones" class="btn btn-info btn-ajax example_c item" texto="ddlb">
                        <i class="fa fa-atlas fa-4x text-success"></i>
                        <br/> Capacitaciones
                    </a>
                    <a href="#" id="btnConvenios" class="btn btn-info btn-ajax example_c item" texto="auxl">
                        <i class="fa fa-handshake fa-4x text-success"></i>
                        <br/> Convenios
                    </a>
                </p>
            </div>
        </div>
    </div>

    <div id="obra" class="tab-pane fade">
        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>
                    <a href="#" id="btnPoaFuente" class="btn btn-info btn-ajax example_c item" texto="tpob">
                        <i class="fa fa-list-alt fa-4x text-success"></i>
                        <br/> POA por fuente
                    </a>
                    <a href="#" id="btnPoaComponente" class="btn btn-info btn-ajax example_c item" texto="prsp">
                        <i class="fa fa-list-ol fa-4x text-success"></i>
                        <br/> POA por componente
                    </a>
                    <a href="#" id="btnPoaGrupo" class="btn btn-info btn-ajax example_c item" texto="crit">
                        <i class="fa fa-th-list fa-4x text-success"></i>
                        <br/> POA por grupo de gasto
                    </a>
                    <a href="#" id="btnReporteAsignacionesCrono" class="btn btn-info btn-ajax example_c item" texto="anua">
                        <i class="fa fa-calendar-check fa-4x text-success"></i>
                        <br/> Cronograma valorado
                    </a>
                </p>
            </div>
        </div>
    </div>

    <div id="cont" class="tab-pane fade">
        <div class="row">
            <div class="col-md-12 col-xs-5">
                <p>
                    <g:link class="link btn btn-info btn-ajax example_c item" texto="grgf"  controller="reportes" action="mapa">
                        <i class="fa fa-map-marked-alt fa-4x text-success"></i>
                        <br/> Localización de proyectos
                    </g:link>
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled" texto="tpgr" controller="tipoGarantia" action="list">--}%
                %{--                        <i class="fab fa-gofore fa-4x text-success disabled"></i>--}%
                %{--                        <br/>Tipo de Garantía--}%
                %{--                    </g:link>--}%
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled" texto="tdgr" controller="tipoDocumentoGarantia" action="list">--}%
                %{--                        <i class="fab fa-gofore fa-4x text-success"></i>--}%
                %{--                        <br/> Tipo de documento de garantía--}%
                %{--                    </g:link>--}%
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled" texto="edgr" controller="estadoGarantia" action="list">--}%
                %{--                        <i class="fab fa-gofore fa-4x text-success"></i>--}%
                %{--                        <br/> Estado de la garantía--}%
                %{--                    </g:link>--}%
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled" texto="asgr" controller="aseguradora" action="list">--}%
                %{--                        <i class="fab fa-adn fa-4x text-success"></i>--}%
                %{--                        <br/> Aseguradora--}%
                %{--                    </g:link>--}%
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled" texto="tpas" controller="tipoAseguradora" action="list">--}%
                %{--                        <i class="fab fa-adn fa-4x text-success"></i>--}%
                %{--                        <br/> Tipo de aseguradora--}%
                %{--                    </g:link>--}%
                %{--                    <g:link class="link btn btn-success btn-ajax example_c item disabled disabled" texto="itun" controller="unidadIncop" action="calendario">--}%
                %{--                        <i class="fa fa-building fa-4x"></i>--}%
                %{--                        <br/> Unidad del Item--}%
                %{--                    </g:link>--}%
                </p>
            </div>
        </div>
    </div>

    <div id="tool" style="margin-left: 350px; width: 300px; height: 160px; display: none;padding:25px;"
         class="ui-widget-content ui-corner-all mensaje">
    </div>

</div>

<div id="grgf" style="display:none">
    <h3>Localización geográfica</h3><br>
    <p>Mapa que contiene la localización geográfica de los proyectos</p>
</div>

<div id="undd" style="display:none">
    <h3>Reporte de encuestas</h3><br>
    <p>Reporte de las encuestas generadas en el sistema</p>
</div>

<div id="trnp" style="display:none">
    <h3>Organizaciones</h3><br>
    <p>Listado de organizaciones por provincia.</p>
</div>

<div id="dpto" style="display:none">
    <h3>Socios</h3><br>
    <p>Listado de socios por organización.</p>
</div>

<div id="dire" style="display:none">
    <h3>Socios</h3><br>
    <p>Listado de socios por organización.</p>
</div>

<div id="func" style="display:none">
    <h3>Talleres</h3><br>
    <p>Listado de capacitaciones que ha recibido una organización.</p>
</div>

<div id="crit" style="display:none">
    <h3>POA por grupo de gasto</h3><br>
    <p>Ejecución del POA por grupo de gasto</p>
</div>

<div id="tpob" style="display:none">
    <h3>POA por fuente</h3><br>
    <p>Ejecución del POA por fuente de financiamiento.</p>
</div>
<div id="csob" style="display:none">
    <h3>Clase de Obra</h3><br>
    <p>Clase de obra, ejemplo: aulas, pavimento, cubierta, estructuras, adoquinado, puentes, mejoramiento, etc.</p>
</div>
<div id="prsp" style="display:none">
    <h3>POA por componente</h3><br>
    <p>Ejecución del POA por componente y actividad.</p>
</div>
<div id="edob" style="display:none">
    <h3>Estado de la Obra</h3><br>
    <p>Estado de la obra durante el proyecto de construcción, para distinguir entre: precontractual, ofertada, contratada, etc.</p>
</div>
<div id="prog" style="display:none">
    <h3>Programa</h3><br>
    <p>Programa del cual forma parte una obra o proyecto.</p>
</div>
<div id="auxl" style="display:none">
    <h3>Convenios consolidados</h3><br>
    <p>Listado de convenios.</p>
</div>
<div id="tpfp" style="display:none">
    <h3>Tipo de fórmula polinómica</h3><br>
    <p>Tipo de forma polínomica que tiene el contrato, puede ser contractual o de liquidación.</p>
</div>
<div id="var" style="display:none">
    <h3>Variables</h3><br>
    <p>Valores de parámetros de transporte y costos indirectos que se usan por defecto en las obras.</p>
</div>
<div id="anio" style="display:none">
    <h3>Ingreso de Años</h3><br>
    <p>Registro de los años para el control y manejo de los índices año por año.</p>
</div>
<div id="anua" style="display:none">
    <h3>Cronograma valorado</h3><br>
    <p>Cronograma valorado por año</p>
</div>
<div id="fnfn" style="display: none">
    <h3>Fuente de financiamiento</h3>
    <p>Fuente de financiamiento de las partidas presupuestarias</p>
    <p>Entidad que financia la adquisición o construcción.</p>
</div>
<div id="ddlb" style="display:none">
    <h3>Capacitaciones</h3><br>
    <p>Listado de capacitaciones por provincia</p>
</div>

<script type="text/javascript">

    $("#btnEncuestas").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'encuesta_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlEncuesta",
                    title : "Seleccione",
                    message : msg,
                    class   : "modal-sm",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reportesEncuestasExcel')}?fi=" + $("#fechaInicio").val() + "&ff=" + $("#fechaFin").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnPoaGrupo").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'grupoGasto_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgGrupo",
                    title : "Seleccione un grupo de gasto",
                    class   : "modal-sm",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reportePoaxGrupoExcel')}?grupo=" + $("#grupo option:selected").val() + "&fi=" + $("#fechaInicio").val() + "&ff=" + $("#fechaFin").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnReporteAsignacionesCrono").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'anio_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlAnio",
                    title : "Seleccione un Año",
                    class   : "modal-sm",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteAsignacionesExcel')}?id=" + '${1}' + "&anio=" + $("#anioR option:selected").val();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnConvenios").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'organizaciones_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlOrganizacion",
                    title : "Seleccione una Organización",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reportesConveniosExcel')}/" + $("#organizacion option:selected").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnPoaComponente").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'componente_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlFuente",
                    title : "Seleccione",
                    message : msg,
                    class   : "modal-sm",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reportePoaComponenteExcel')}?componente=" + $("#componente option:selected").val() + "&fi=" + $("#fechaInicio").val() + "&ff=" + $("#fechaFin").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnPoaFuente").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'fuente_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlFuente",
                    title : "Seleccione",
                    message : msg,
                    class   : "modal-sm",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reportePoaFuenteExcel')}?fuente=" + $("#fuente option:selected").val() + "&fi=" + $("#fechaInicio").val() + "&ff=" + $("#fechaFin").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnCapacitaciones").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'provincia_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlProvincia",
                    title : "Seleccione una provincia",
                    message : msg,
                    class   : "modal-sm",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteCapacitacionesExcel')}/" + $("#provincia option:selected").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnTalleres").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'organizaciones_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlOrganizacion",
                    title : "Seleccione una Organización",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteTalleresExcel')}/" + $("#organizacion option:selected").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnSocios").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'organizaciones_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlOrganizacion",
                    title : "Seleccione una Organización",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteSociosExcel')}/" + $("#organizacion option:selected").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    $("#btnOrganizaciones").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'provincia_ajax')}',
            data:{
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id    : "dlProvincia",
                    title : "Seleccione una provincia",
                    message : msg,
                    class   : "modal-sm",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-check'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteOrganizacionesExcel')}/" + $("#provincia option:selected").val()
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        })
    });

    %{--$("#btnIva").click(function () {--}%
    %{--    $.ajax({--}%
    %{--        type: 'POST',--}%
    %{--        url: '${createLink(controller: 'parametros', action: 'formIva_ajax')}',--}%
    %{--        data:{--}%
    %{--        },--}%
    %{--        success: function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id    : "dlgIva",--}%
    %{--                title : "Iva",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            guardarIva($("#ivaExi").val());--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--        }--}%
    %{--    })--}%
    %{--});--}%



    %{--function  guardarIva(iva){--}%
    %{--    $.ajax({--}%
    %{--        type: 'POST',--}%
    %{--        url:'${createLink(controller: 'parametros', action: 'guardarIva_ajax')}',--}%
    %{--        data:{--}%
    %{--            iva:iva--}%
    %{--        },--}%
    %{--        success: function (msg) {--}%
    %{--            if(msg == 'ok'){--}%
    %{--                log("Iva guardado correctamente", "success")--}%
    %{--            }else{--}%
    %{--                log("Error al guardar el Iva","error")--}%
    %{--            }--}%
    %{--        }--}%
    %{--    });--}%
    %{--}--}%


    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });
    });


    %{--$("#btnCambiarIva").click(function () {--}%
    %{--    $.ajax({--}%
    %{--        type: "POST",--}%
    %{--        url: "${createLink(controller: "obra", action:'formIva_ajax')}",--}%
    %{--        data: {--}%

    %{--        },--}%
    %{--        success: function (msg) {--}%
    %{--            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');--}%
    %{--            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');--}%

    %{--            btnSave.click(function () {--}%
    %{--                $(this).replaceWith(spinner);--}%
    %{--                $.ajax({--}%
    %{--                    type: "POST",--}%
    %{--                    url: "${createLink(controller: 'obra', action:'guardarIva_ajax')}",--}%
    %{--                    data: $("#frmIva").serialize(),--}%
    %{--                    success: function (msg) {--}%
    %{--                        if(msg == 'ok'){--}%
    %{--                            alert('Iva cambiado correctamente!');--}%
    %{--                            $("#modal-TipoObra").modal("hide");--}%
    %{--                        }else{--}%
    %{--                            alert("Error al cambiar el Iva")--}%

    %{--                        }--}%
    %{--                        $("#modal-TipoObra").modal("hide");--}%
    %{--                    }--}%
    %{--                });--}%
    %{--                return false;--}%

    %{--            });--}%

    %{--            $("#modalHeader_tipo").removeClass("btn-edit btn-show btn-delete");--}%
    %{--            $("#modalTitle_tipo").html("Cambiar IVA");--}%
    %{--            $("#modalBody_tipo").html(msg);--}%
    %{--            $("#modalFooter_tipo").html("").append(btnOk).append(btnSave);--}%
    %{--            $("#modal-TipoObra").modal("show");--}%
    %{--        }--}%
    %{--    });--}%
    %{--    return false;--}%

    %{--});--}%

    $(document).ready(function () {
        $('.item').hover(function () {
            $('#tool').html($("#" + $(this).attr('texto')).html());
            $('#tool').show();
        }, function () {
            $('#tool').hide();
        });
    });
</script>
</body>
</html>
