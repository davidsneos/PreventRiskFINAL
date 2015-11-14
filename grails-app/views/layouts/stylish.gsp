<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <g:javascript library="jquery"/>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load('visualization', '1.1', {packages: ['map']});
            google.setOnLoadCallback(drawMap);

            function drawMap () {
                var options = {
                    center: ({lat: -74.0862351, lng: 4.6381991}),
                    zoomLevel: 13,
                    showTip: true,
                    icons: {
                        hospital: {
                            normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
                            selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Azure-icon.png'
                        },
                        drug: {
                            normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Pink-icon.png',
                            selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Pink-icon.png'
                        }
                    }
                };
                var data = new google.visualization.DataTable();
                data.addColumn('number', 'Lat');
                data.addColumn('number', 'Long');
                data.addColumn('string', 'Name');
                data.addColumn('string', 'Marker')

                var locations = '/PreventRisk/location/index'
                $.getJSON(locations)
                        .done(function (dat) {
                            $.each(dat, function (i, loc) {
                                if(loc.class == "Hospital"){
                                    data.addRow( [loc.longitude, loc.latitude,
                                        "Nombre: " + loc.name + '\n' + "Tipo: " + loc.type + '\n' + "Calidad: " + loc.quality ,
                                        'hospital'] )
                                }else if(loc.class == "Drugstore"){
                                    data.addRow( [loc.longitude, loc.latitude,
                                        "Nombre: " + loc.name + '\n' + "Especialidad: " + loc.speciality,
                                        'drug'] )
                                }
                            });
                        });

                var map = new google.visualization.Map(document.getElementById('map_div'));
                map.draw(data, options);
            }

    </script>

  <title>PreventRisk</title>

  <!-- Bootstrap Core CSS -->
  <link href="${request.contextPath}/stylish/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${request.contextPath}/stylish/css/stylish-portfolio.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${request.contextPath}/stylish/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/ico" href="${request.contextPath}/stylish/img/favicon.ico"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <!-- Navigation -->


    <a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i class="fa fa-bars"></i></a>
    <nav id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <a id="menu-close" href="#" class="btn btn-light btn-lg pull-right toggle"><i class="fa fa-times"></i></a>
            <g:if test="${!session.user}">
                <li class="sidebar-brand">
                    <a href="http://localhost:9090/PreventRisk/user/login"  onclick = $("#menu-close").click(); ><i class="fa fa-user fa-lw"></i>&nbsp; Ingresar</a>
                </li>
            </g:if>
            <g:else>
                <li class="sidebar-brand">
                    <a href="http://localhost:9090/PreventRisk/user/logout"  onclick = $("#menu-close").click(); ><i class="fa fa-user fa-lw"></i>&nbsp; Salir</a>
                </li>
            </g:else>
            <li>
                <a href="#top" onclick = $("#menu-close").click(); ><i class="fa fa-home fa-lw"></i>&nbsp; Inicio</a>
            </li>
            <li>
                <a href="#services" onclick = $("#menu-close").click(); ><i class="fa fa-shield fa-lw"></i>&nbsp; Servicios</a>
            </li>
            <li>
                <a href="#entities" onclick = $("#menu-close").click(); ><i class="fa fa-map-marker fa-lw"></i>&nbsp; Entidades cercanas</a>
            </li>
            <li>
                <a href="#about" onclick = $("#menu-close").click(); ><i class="fa fa-info-circle fa-lw"></i>&nbsp; Sobre nosotros</a>
            </li>
        </ul>
    </nav>


    <!-- Header -->
    <header id="top" class="header">
        <div class="text-vertical-center">
            <div class="container" >
                <img src="${request.contextPath}/stylish/img/preventrisk-w.png" width="200px" height="auto" />
            </div>
            <g:if test="${session.user}">
                <h3>Hola ${session.user.lastName} ${session.user.firstName}!
                <br>Aquí sabrás qué hacer en caso de emergencias.</h3>
                <h4><a href="http://localhost:9090/PreventRisk/user/logout">Cerrar sesión</a></h4>
                <br>
            </g:if>
            <g:else>
                <h3>Aquí sabrás qué hacer en caso de emergencias.</h3>
                <h4><a href="http://localhost:9090/PreventRisk/user/login">Inicia sesión</a>. Si
                eres nuevo, regístrate <a href="http://localhost:9090/PreventRisk/user/registro">aquí</a>.</h4>
                <br>
            </g:else>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <a href="#about" class="btn btn-dark btn-lg">Saber más</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Services -->
    <!-- The circle icons use Font Awesome's stacked icon classes. For more information, visit http://fontawesome.io/examples/ -->
    <section id="services" class="services bg-primary">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-10 col-lg-offset-1">
                    <h2>¿Qué te ofrecemos?</h2>
                    <hr class="small">
                    <div class="row">
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-gear fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong>Simulador</strong>
                                </h4>
                                <p>Puedes crear una situación de emergencia y mostraremos qué hacer.</p>
                                <a href="http://localhost:9090/PreventRisk/" class="btn btn-light">Ingresar</a>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-book fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong>Curso</strong>
                                </h4>
                                <p>Aquí podrás aprender como actuar en caso de emergencia y ver tu progreso.</p>
                                <a href="http://localhost:9090/PreventRisk/" class="btn btn-light">Ingresar</a>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="service-item">
                                <span class="fa-stack fa-4x">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-hospital-o fa-stack-1x text-primary"></i>
                                </span>
                                <h4>
                                    <strong>Entidades cercanas</strong>
                                </h4>
                                <p>En caso de emergencia, verás que entidades de salud dependiendo del caso.</p>
                                <a href="#map_markers_div" class="btn btn-light">Ver</a>
                            </div>
                        </div>
                    </div>
                    <!-- /.row (nested) -->
                </div>
                <!-- /.col-lg-10 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>


    <!-- Call to Action -->
    <section id="entities" class="call-to-action bg-primary">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h3>Puedes ver cual droguería o hospital es el más cercano.</h3>
                    <div class="form-group">
                        <label for="sel1"><h4>Filtrar por:</h4></label>
                        <select class="form-control" id="sel1" style ="opacity: 0.8; border-bottom: none">
                            <option disabled="disabled">-- Seleccione -- </option>
                            <option>Droguerias</option>
                            <option>Hospitales</option>
                            <option>Centros de salud</option>
                        </select>
                    </div>
                    <a href="#" class="btn btn-lg btn-dark">Ver</a>
                </div>
            </div>
        </div>
    </section>

    <div id="map_div" style="height: 450px"></div>

    <!-- Map
    <aside class="map">
        <iframe width="100%" height="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7953.50127292347!2d-74.09018762744006!3d4.6385152302482515!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f9bce39a6fabb%3A0x20a24f1701dc7d9c!2sCdad.+Universitaria%2C+Bogot%C3%A1!5e0!3m2!1ses-419!2sco!4v1445094889494"></iframe>
        <br />
        <small>
            <a href="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7953.50127292347!2d-74.09018762744006!3d4.6385152302482515!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f9bce39a6fabb%3A0x20a24f1701dc7d9c!2sCdad.+Universitaria%2C+Bogot%C3%A1!5e0!3m2!1ses-419!2sco!4v1445094889494"></a>
        </small>
    </iframe>
    </aside>-->

    <!-- Footer -->
    <section id = "about">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h4><strong>PreventRisk</strong>
                    </h4>
                    <p>Bogotá D.C. - Colombia</p>
                    <br>
                    <ul class="list-inline">
                        <li>
                            <a href="#"><i class="fa fa-facebook fa-fw fa-3x"></i></a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-twitter fa-fw fa-3x"></i></a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-dribbble fa-fw fa-3x"></i></a>
                        </li>
                    </ul>
                    <hr class="small">
                    <p class="text-muted">Copyright &copy; PreventRisk 2015</p>
                </div>
            </div>
        </div>
    </section>

<!-- jQuery -->
<script src="${request.contextPath}/stylish/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${request.contextPath}/stylish/js/bootstrap.min.js"></script>

<!-- Custom Theme JavaScript -->
<script>
    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Scrolls to the selected menu item on the page
    $(function() {
        $('a[href*=#]:not([href=#])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    });
    </script>

</body>

</html>