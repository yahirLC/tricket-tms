<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>ADMIN</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                display: flex;
                min-height: 100vh;
                flex-direction: column; /* Para que la barra de navegación esté encima del resto del contenido */
            }
            .navbar-admin {
                background-color: #2c3e50; /* Azul oscuro */
                color: white;
                padding: 0.5rem 1rem;
                display: flex;
                justify-content: flex-end; /* Alinea los elementos a la derecha */
                align-items: center;
                font-size: 0.9rem;
            }
            .admin-info {
                display: flex;
                align-items: center;
            }
            .admin-text {
                margin-right: 0.5rem;
            }
            .dropdown-admin {
                position: relative;
                display: inline-block;
            }
            .dropdown-toggle-admin {
                cursor: pointer;
                font-size: 1.2rem;
            }
            .dropdown-menu-admin {
                position: absolute;
                background-color: #34495e;
                color: white;
                min-width: 80px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                right: 0; /* Alinea el menú desplegable a la derecha */
            }
            .dropdown-menu-admin a {
                color: white;
                padding: 8px 12px;
                text-decoration: none;
                display: block;
                font-size: 0.9rem;
            }
            .dropdown-menu-admin a:hover {
                background-color: #555;
            }
            .sidebar {
                width: 250px;
                background-color: #f8f9fa;
                padding-top: 2rem;
            }
            .sidebar a {
                display: block;
                padding: 10px 20px;
                color: #333;
                text-decoration: none;
            }
            .sidebar a.active, .sidebar a:hover {
                background-color: #0d6efd;
                color: white;
            }
            .content {
                flex-grow: 1;
                padding: 2rem;
            }
            .dashboard-card {
                cursor: pointer;
                padding: 2rem;
                border-radius: 10px;
                background-color: #e9ecef;
                text-align: center;
                transition: background-color 0.3s;
            }
            .dashboard-card:hover {
                background-color: #dee2e6;
            }
            .dashboard-title {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }
            .dashboard-number {
                font-size: 2.5rem;
                font-weight: bold;
            }
            #tablaGenerales {
                display: none; /* Ahora se oculta por defecto */
            }
        </style>
        <script>
            function mostrarTablaGenerales() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "block";
            }

            function mostrarMistickets() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "none";
                document.getElementById("mistickets").style.display = "block";
                document.getElementById("equipoContainer").style.display = "none";
            }

            function toggleDropdown() {
                var dropdown = document.getElementById("adminDropdownMenu");
                dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
            }

            // Cerrar el dropdown si se hace clic fuera de él
            window.onclick = function (event) {
                if (!event.target.matches('.dropdown-toggle-admin')) {
                    var dropdowns = document.getElementsByClassName("dropdown-menu-admin");
                    for (var i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.style.display === "block") {
                            openDropdown.style.display = "none";
                        }
                    }
                }
            }

            function buscarEnTabla() {
                var input = document.getElementById("searchInput");
                var filter = input.value.toUpperCase();
                var table = document.getElementById("ticketsTable");
                var tbody = table.getElementsByTagName("tbody")[0];
                var rows = tbody.getElementsByTagName("tr");

                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].getElementsByTagName("td");
                    var found = false;
                    for (var j = 0; j < cells.length; j++) {
                        var cellText = cells[j].textContent || cells[j].innerText;
                        if (cellText.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                    rows[i].style.display = found ? "" : "none";
                }
            }

            function buscarEnMistickets() {
                var input = document.getElementById("searchInputTickets");
                var filter = input.value.toUpperCase();
                var table = document.getElementById("misticketsTable");
                var tbody = table.getElementsByTagName("tbody")[0];
                var rows = tbody.getElementsByTagName("tr");

                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].getElementsByTagName("td");
                    var found = false;
                    for (var j = 0; j < cells.length; j++) {
                        var cellText = cells[j].textContent || cells[j].innerText;
                        if (cellText.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                    rows[i].style.display = found ? "" : "none";
                }
            }
        </script>

        <script>
            function mostrarEquipo() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "none";
                document.getElementById("equipoContainer").style.display = "flex";
            }
        </script>

    </head>
    <body>

        <div class="navbar-admin">
            <div class="admin-info">
                <span class="admin-text">${usuarioLogueado.nombre} - Admin</span>
                <div class="dropdown-admin">
                    <span class="dropdown-toggle-admin" onclick="toggleDropdown()">&#8942;</span>
                    <div id="adminDropdownMenu" class="dropdown-menu-admin" style="display: none;">
                        <a href="/logout">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: flex;">
            <div class="sidebar">
                <h4 class="text-center">TRICKET</h4>
                <a href="/admin">Dashboard</a>
                <a href="#">Opción 2</a>
            </div>

            <div class="content">
                <div id="dashboardRow" class="row g-4">
                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarMistickets()">
                            <div class="dashboard-title">Tickets</div>
                            <div class="dashboard-number">${totalMisTickets}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarTablaGenerales()">
                            <div class="dashboard-title">Generales</div>
                            <div class="dashboard-number">${totalTickets}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarEquipo()">
                            <div class="dashboard-title">Equipo</div>
                            <div class="dashboard-number">${totalIntegrantes}</div>
                        </div>
                    </div>
                </div>

                <!-- TABLA GENERALES -->

                <div id="tablaGenerales" class="table-responsive mt-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="me-2 col-md-4">
                            <input type="text" class="form-control form-control-sm" placeholder="Buscar..." id="searchInput" oninput="buscarEnTabla()">
                        </div>
                        <div class="ms-auto">
                            <button class="btn btn-success btn-sm" onclick="window.location.href = '/ticket?modo=inserccion'">
                                <span style="font-size: 1rem;">&#43;</span> Nuevo
                            </button>
                        </div>
                    </div>
                    <table class="table table-bordered table-hover" id="ticketsTable">
                        <thead class="table-primary">
                            <tr>
                                <th>#</th>
                                <th>Asunto</th>
                                <th>Categoria</th>
                                <th>Estado</th>
                                <th>Asignado a</th>
                                <th>Creado el</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tick" items="${tickets}">
                                <tr style="cursor:pointer;" onclick="window.location.href = '/ticket?id=${tick.id}&modo=lectura'">
                                    <td>${tick.numero}</td>
                                    <td>${tick.titulo}</td>
                                    <td><c:forEach var="categoria" items="${listaCategorias}">
                                            <c:if test="${categoria.id == tick.categoria_id}">${categoria.nombre}</c:if>
                                        </c:forEach>  </td>
                                    <td><c:forEach var="estado" items="${listaEstados}">
                                            <c:if test="${estado.id == tick.estado_id}">${estado.nombre}</c:if>
                                        </c:forEach>  </td>
                                    <td><c:forEach var="usuario" items="${integrantes}">
                                            <c:if test="${usuario.id == tick.asignadoA}">${usuario.nombre}</c:if>
                                        </c:forEach></td>
                                    <td>${tick.fecha_creacion}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>


                <!-- MISTIKCETS -->
                <div id="mistickets" class="table-responsive mt-4" style="display:none;">
                    <div class="d-flex align-items-center mb-3">
                        <div class="me-2 col-md-4">
                            <input type="text" class="form-control form-control-sm" placeholder="Buscar..." id="searchInputTickets" oninput="buscarEnMistickets()">
                        </div>

                    </div>
                    <table class="table table-bordered table-hover" id="misticketsTable">
                        <thead class="table-primary">
                            <tr>
                                <th>#</th>
                                <th>Asunto</th>
                                <th>Categoria</th>
                                <th>Estado</th>
                                <th>Asignado a</th>
                                <th>Creado el</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí puedes iterar otro conjunto de datos, por ejemplo: misTickets -->
                            <c:forEach var="tick" items="${misTickets}">
                                <tr style="cursor:pointer;" onclick="window.location.href = '/ticket?id=${tick.id}&modo=lectura'">
                                    <td>${tick.numero}</td>
                                    <td>${tick.titulo}</td>
                                    <td><c:forEach var="categoria" items="${listaCategorias}">
                                            <c:if test="${categoria.id == tick.categoria_id}">${categoria.nombre}</c:if>
                                        </c:forEach></td>
                                    <td><c:forEach var="estado" items="${listaEstados}">
                                            <c:if test="${estado.id == tick.estado_id}">${estado.nombre}</c:if>
                                        </c:forEach></td>
                                    <td><c:forEach var="usuario" items="${integrantes}">
                                            <c:if test="${usuario.id == tick.asignadoA}">${usuario.nombre}</c:if>
                                        </c:forEach></td>
                                    <td>${tick.fecha_creacion}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- EQUIPO -->

                <div id="equipoContainer" class="row g-3" style="display: none;">
                    <c:forEach var="miembro" items="${integrantes}">
                        <div class="col-md-3">
                            <div class="dashboard-card" onclick="alert('Ver perfil de ${miembro.nombre}')">
                                <div class="dashboard-title">${miembro.nombre}</div>
                                <div class="dashboard-number">${miembro.rol}</div> 
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
        </div>

    </body>
</html>