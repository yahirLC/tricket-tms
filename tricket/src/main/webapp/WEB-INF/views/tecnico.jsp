<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Panel Técnico</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
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
        </style>
        <script>
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
        </script>
    </head>
    <body>

        <div class="navbar-admin">
            <div class="admin-info">
                <span class="admin-text">${usuarioLogueado.nombre} - Técnico</span>
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
                <c:set var="tabla" value="${param.tabla}" />
                <a href="tecnico?tabla=categorias" class="${tabla == 'categorias' ? 'active' : ''}">Categorías</a>
                <a href="tecnico?tabla=logs" class="${tabla == 'logs' ? 'active' : ''}">Logs</a>
                <a href="tecnico?tabla=estados" class="${tabla == 'estados' ? 'active' : ''}">Estados</a>
                <a href="tecnico?tabla=comentarios" class="${tabla == 'comentarios' ? 'active' : ''}">Comentarios</a>
                <a href="tecnico?tabla=usuarios" class="${tabla == 'usuarios' ? 'active' : ''}">Usuarios</a>
                <a href="tecnico?tabla=tickets" class="${tabla == 'tickets' ? 'active' : ''}">Tickets</a>
                <a href="tecnico?tabla=historial" class="${tabla == 'historial' ? 'active' : ''}">Historial</a>
                <a href="tecnico?tabla=grupos" class="${tabla == 'grupos' ? 'active' : ''}">Grupos</a>
            </div>


            <div class="content">
                <c:choose>


                    <c:when test="${tabla == 'categorias'}">
                        <h2>Categorías</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>Nombre</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categorias}">
                                    <tr><td>${cat.id}</td><td>${cat.nombre}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'logs'}">
                        <h2>Logs</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>usuario_id</th><th>accion</th><th>fechao</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="log" items="${logs}">
                                    <tr>
                                        <td>${log.id}</td><td>${log.usuario_id}</td>
                                        <td>${log.accion}</td><td>${log.fecha}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'estados'}">
                        <h2>Estados</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>Nombre</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="est" items="${estados}">
                                    <tr><td>${est.id}</td><td>${est.nombre}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'comentarios'}">
                        <h2>Comentarios</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>TICKET_ID</th><th>ID Usuario</th><th>Comentario</th><th>Fecha</th> </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="com" items="${comentarios}">
                                    <tr><td>${com.id}</td><td>${com.ticket_id}</td><td>${com.usuario_id}</td><td>${com.comentario}</td><td>${com.fecha}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'usuarios'}">
                        <h2>Usuarios</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>Nombre</th><th>Correo</th><th>Rol</th><th>grupo_id</th> <th>f_registro</th><th>user</th><th>materno</th> </tr>
                                <th>paterno</th>
                            </thead>
                            <tbody>
                                <c:forEach var="usu" items="${usuarios}">
                                    <tr><td>${usu.id}</td><td>${usu.nombre}</td><td>${usu.correo}</td><td>${usu.rol}</td>
                                    <td>${usu.grupo_id}</td><td>${usu.fecha_registro}</td><td>${usu.usuario}</td><td>${usu.apellido_materno}</td><td>${usu.apellido_paterno}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'tickets'}">
                        <h2>Tickets</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr>
                                    <th>ID</th><th>numero</th><th>categoria</th><th>estado</th><th>severidad</th>
                                    <th>tipo</th><th>grupo_id</th><th>titulo_id</th><th>descripcion</th><th>asignado_a</th><th>fechacreacion</th><th>fechacierre</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tick" items="${tickets}">
                                    <tr>
                                        <td>${tick.id}</td><td>${tick.numero}</td><td>${tick.categoria_id}</td>
                                        <td>${tick.estado_id}</td><td>${tick.severidad}</td><td>${tick.tipo}</td><td>${tick.grupo_id}</td>
                                        <td>${tick.titulo}</td><td>${tick.descripcion}</td><td>${tick.asignado_a}</td><td>${tick.fecha_creacion}</td><td>${tick.fecha_cierre}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'historial'}">
                        <h2>Historial</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr>
                                    <th>ID</th>
                                    <th>ticket_id</th>
                                    <th>Usuario</th>
                                    <th>accion</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="his" items="${historiales}">
                                    <tr><td>${his.id}</td><td>${his.ticket_id}</td><td>${his.usuario_id}</td><td>${his.accion}</td><td>${his.fecha}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:when test="${tabla == 'grupos'}">
                        <h2>Grupos</h2>
                        <table class="table table-bordered table-hover">
                            <thead class="table-primary">
                                <tr><th>ID</th><th>Nombre</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="gru" items="${grupos}">
                                    <tr><td>${gru.id}</td><td>${gru.nombre}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>


                    <c:otherwise>
                        <div class="alert alert-info">
                            <strong>Info:</strong> Selecciona una tabla desde el menú lateral para ver sus datos.
                        </div>
                    </c:otherwise>

                </c:choose>
            </div>
        </div>

    </body>
</html>