<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <link href='${resource(dir: "css", file: "print.css")}' rel='stylesheet' type='text/css' media="print"/>

        <script type="text/javascript"
%{--                src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBpasnhIQUsHfgCvC3qeJpEgcB9_ppWQI0&sensor=true">--}%
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpasnhIQUsHfgCvC3qeJpEgcB9_ppWQI0&callback=initMap">

        </script>

            <style>

        #mapa img {
            max-width : none;;
        }

        .control-label {
            font-weight : bold;
        }

        .soloPrint {
            display : none;
        }
        .noprint {
            display : none;
        }
        </style>

        <title>Localización de la Obra</title>
    </head>

    <body>

        <div class="row hide" id="divError">
            <div class="span12 alert alert-error" id="spanError">
            </div>
        </div>

        <div class="datosObra col-md-12" style="margin-bottom: 20px; width: 100%; text-align: center">
            <div style="margin-left: -50px; font-size: large; width: 100%;">Organizaciones Registradas en el Sistema: ${cord.split('_').size()}</div>
        </div>

        <div>
            <div id="mapa" style="width: 900px; height: 640px; margin-left: 10px; float: left; margin-bottom: 20px;"></div>
        </div>

        <div id="nota" style="float: left; width: 200px;" >
            <div style="margin: 20px; margin-top: 80px;" >
                <b>Nota:</b>

                <p>Si usa el botón "Imprimir", use la configuración de página definir la horientación del papel horizontal y
                una escala de 100% para cubrir toda la hoja en tamaño A4</p>

                <p>Se puede usar también la opción "Vista preliminar" desde el menú de Firefox: <span style="color: #000">Archivo -> Imprimir
                -> Vista preliminar</span>, para fijar la horientación del papel a horizontal y
                la escala que desee según sus requerimientos</p>
            </div>

        </div>

        <div class="btn-group" style="margin-top: 10px; margin-left: 20px">
            <a href="#" class="btn btn-info" id="btnVolver"><i class="fa fa-arrow-left"></i> Regresar </a>
        </div>
        <div class="btn-group" style="margin-top: 10px; margin-left: 10px">
            <a href="#" class="btn btn-success" id="btnImprimir"><i class="fa fa-print"></i> Imprimir </a>
        </div>


        <script type="text/javascript">
            //            window.onbeforeprint = preparar;
            //            window.onafterprint = despues;

            var map;
            var lat;
            var longitud;
            var latorigen;
            var longorigen;
            var lastValidCenter;
            //    var allowedBounds;

            var countryCenter = new google.maps.LatLng(-0.15, -78.35);

            var allowedBounds = new google.maps.LatLngBounds(
                    new google.maps.LatLng(-0.41, -79.56),
                    new google.maps.LatLng(-0.50, -76.44),
                    new google.maps.LatLng(-0.28690, -76.59190)
            );

            var marker = new google.maps.Marker({
                position  : countryCenter,
                draggable : true
            });

            function initialize() {

                var myOptions = {
                   // center             : countryCenter,
                    center             :  {lat: -1.7, lng: -78},
                    zoom               : 7,
                    maxZoom            : 16,
                    minZoom            : 4,
                    panControl         : false,
                    zoomControl        : true,
                    mapTypeControl     : false,
                    scaleControl       : false,
                    streetViewControl  : false,
                    overviewMapControl : false,

                    mapTypeId : google.maps.MapTypeId.ROADMAP //SATELLITE, ROADMAP, HYBRID, TERRAIN
                };

                map = new google.maps.Map(document.getElementById('mapa'), myOptions);

                /* maneja los datos */
                var cord = '${cord}'.split('_')
                var nmbr = '${nmbr}'.split('_')
                var plns = '${plns}'.split('_')
                // console.log('nmbr:', cord);

                //ver en: http://maps.google.com/mapfiles/ms/icons/red-dot.png
                for (var i = 0; i <= cord.length; ++i) {
                    var cr = cord[i].split(' ')
                    var path = ''
                    if(plns[i] == 'S') {
                        path = '${assetPath(src: '/apli/pin-p.png')}'
                    } else {
                        path = '${assetPath(src: '/apli/pin-o.png')}'
                    }
                    var marker = new google.maps.Marker({
                        map: map,
                        position: new google.maps.LatLng(parseFloat(cr[0]) + 0.1* Math.random(),
                            parseFloat(cr[1]) + 0.1* Math.random()),
                        icon: path
                    });
                    poneMensaje(marker, nmbr[i].strReplaceAll('kk', '<br>'));
                }


                // limites2();

            }

            function poneMensaje(marker, secretMessage) {
                var infowindow = new google.maps.InfoWindow({
                    content: secretMessage
                });

                marker.addListener('click', function() {
                    infowindow.open(marker.get('map'), marker);
                });
            }

            $(function () {
                initialize();
            });

            $("#btnVolver").click(function () {
                location.href = "${g.createLink(controller: 'reportes', action: 'reportes')}";
            });

            $("#btnImprimir").click(function () {
                $("#nota").addClass('noprint')
                $("#btnVolver").addClass('noprint')
                $("#btnImprimir").addClass('noprint')
                window.print()
                $("#nota").removeClass('noprint')
                $("#btnVolver").removeClass('noprint')
                $("#btnImprimir").removeClass('noprint')
            });


        </script>

    </body>
</html>