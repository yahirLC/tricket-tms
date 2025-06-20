<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>${tituloPagina}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }

            .ticket-navbar {
                background-color: #1a5e2e; /* Verde oscuro */
                color: white;
                padding: 0.5rem 1rem;
                display: flex;
                justify-content: flex-end; /* Alinea los elementos a la derecha */
                align-items: center;
                font-size: 0.9rem;
            }

            .ticket-admin-info {
                display: flex;
                align-items: center;
            }

            .ticket-admin-text {
                margin-right: 0.5rem;
            }

            .ticket-dropdown-admin {
                position: relative;
                display: inline-block;
            }

            .ticket-dropdown-toggle-admin {
                cursor: pointer;
                font-size: 1.2rem;
            }

            .ticket-dropdown-menu-admin {
                position: absolute;
                background-color: #28a745; /* Verde Bootstrap */
                color: white;
                min-width: 80px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                right: 0; /* Alinea el menú desplegable a la derecha */
            }

            .ticket-wrapper {
                display: flex;
                min-height: 100vh; /* Asegura que el contenedor abarque toda la altura de la ventana */
            }

            .ticket-dropdown-menu-admin a {
                color: white;
                padding: 8px 12px;
                text-decoration: none;
                display: block;
                font-size: 0.9rem;
            }

            .ticket-dropdown-menu-admin a:hover {
                background-color: #218838; /* Un verde un poco más oscuro al pasar el ratón */
            }

            .ticket-sidebar {
                width: 250px;
                background-color: #f8f9fa;
                padding-top: 2rem;
                flex-shrink: 0;
            }

            .ticket-sidebar a {
                display: block;
                padding: 10px 20px;
                color: #333;
                text-decoration: none;
            }

            .ticket-sidebar a.active, .ticket-sidebar a:hover {
                background-color: #28a745; /* Verde Bootstrap */
                color: white;
            }

            .ticket-content {
                flex-grow: 1;
                padding: 2rem;
                overflow-x: auto;
            }

            .readonly-field {
                background-color: #e9ecef;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                padding: 0.375rem 0.75rem;
                width: 100%;
                box-sizing: border-box;
            }

            .form-label {
                margin-bottom: 0.5rem;
                font-weight: bold;
            }

            .ticket-info-label {
                font-weight: bold;
            }
        </style>
        <script>
            function toggleDropdown() {
                var dropdown = document.getElementById("adminDropdownMenu");
                dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
            }

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

        <div class="ticket-navbar">
            <div class="ticket-admin-info">
                <span class="ticket-admin-text">${usuarioLogueado.nombre} - ${usuarioLogueado.rol}</span>
                <div class="ticket-dropdown-admin">
                    <span class="ticket-dropdown-toggle-admin" onclick="toggleDropdown()">&#8942;</span>
                    <div id="adminDropdownMenu" class="ticket-dropdown-menu-admin" style="display: none;">
                        <a href="/logout">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: flex;">
            <div class="ticket-sidebar">
                <h4 class="text-center">TRICKET</h4>
                <a href="javascript:history.back()">Dashboard</a>
                
            </div>

            <div class="ticket-content">
                <div class="ticket-details">
                    <h2>${tituloPagina}</h2>

                    <c:choose>
                        <c:when test="${modo == 'lectura'}">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h2 class="ticket-info-label">${ticket.numero} - ${ticket.titulo}</h2>
                                </div>
                                <div class="col-md-6 text-end">
                                    <a href="/ticket?id=${ticket.id}&modo=edicion" class="btn btn-warning">Editar Ticket</a>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <p><span class="ticket-info-label">Estado:</span>
                                        <c:forEach var="estado" items="${listaEstados}">
                                            <c:if test="${estado.id == ticket.estado_id}">${estado.nombre}</c:if>
                                        </c:forEach>
                                    </p>
                                    <p><span class="ticket-info-label">Categoría:</span>
                                        <c:forEach var="categoria" items="${listaCategorias}">
                                            <c:if test="${categoria.id == ticket.categoria_id}">${categoria.nombre}</c:if>
                                        </c:forEach>
                                    </p>
                                    <span class="ticket-info-label">Descripción:</span>
                                    <div class="readonly-field">${ticket.descripcion}</div>
                                    <p></p>
                                    <p><span class="ticket-info-label">Fecha Creación:</span> ${ticket.fecha_creacion}</p>
                                    <c:if test="${not empty ticket.fecha_cierre}">
                                        <p><span class="ticket-info-label">Fecha Cierre:</span> ${ticket.fecha_cierre}</p>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <p><span class="ticket-info-label">Severidad:</span> ${ticket.severidad}</p>
                                    <p><span class="ticket-info-label">Reportado por:</span>
                                        <c:forEach var="usuario" items="${integrantes}">
                                            <c:if test="${usuario.id == ticket.usuario_id}">${usuario.nombre}</c:if>
                                        </c:forEach>
                                    </p>
                                    <p><span class="ticket-info-label">Asignado a:</span>
                                        <c:forEach var="usuario" items="${integrantes}">
                                            <c:if test="${usuario.id == ticket.asignadoA}">${usuario.nombre}</c:if>
                                        </c:forEach>
                                    </p>
                                </div>
                            </div>
                            <form action="/ticket/cerrar" method="post" onsubmit="return confirm('¿Estás seguro de cerrar este ticket?');">
                                <a href="javascript:history.back()" class="btn btn-secondary">Volver</a>
                                <input type="hidden" name="id" value="${ticket.id}" />
                                <button type="submit" class="btn btn-danger">Cerrar Ticket</button>
                            </form>

                            <%-- Sección para el historial --%>
                            <hr class="my-4">
                            <h3>Historial del Ticket</h3>
                            <c:if test="${not empty listaHistorial}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Categoria</th>
                                                <th>Estado</th>
                                                <th>Asignado a</th>
                                                <th>#</th>
                                                <th>Titulo</th>
                                                <th>Descripcion</th>
                                                <th>Fecha Modificacion</th>
                                                <th>Modifiacado por</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="historial" items="${listaHistorial}">
                                                <tr>
                                                    <td>${historial.categoriaId}</td>
                                                    <td>${historial.estadoId}</td>
                                                    <td>${historial.asignadoA}</td>
                                                    <td>${historial.numero}</td>
                                                    <td>${historial.titulo}</td>
                                                    <td>${historial.descripcion}</td>
                                                    <td>${historial.fechaModificacion}</td>
                                                    <td>${historial.usuarioQueModifico}</td>
                                                   
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty listaHistorial}">
                                <p>No hay historial disponible para este ticket.</p>
                            </c:if>

                        </c:when>
                        <c:when test="${modo == 'edicion' && usuarioLogueado.rol == 'cliente'}">
                            <form action="/guardarTicket" method="post">
                                <input type="hidden" name="id" value="${ticket.id}" />
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="titulo" class="form-label">Título:</label>
                                        <input type="text" class="form-control" id="titulo" name="titulo" value="${ticket.titulo}" readonly>

                                        <label for="numero" class="form-label">Número:</label>
                                        <input type="text" class="form-control" id="numero" name="numero" value="${ticket.numero}" readonly>

                                        <label for="estado_id" class="form-label">Estado:</label>
                                        <select class="form-control" id="estado_id" name="estado_id">
                                            <c:forEach var="estado" items="${listaEstados}">
                                                <option value="${estado.id}" ${ticket.estado_id == estado.id ? 'selected' : ''}>
                                                    ${estado.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>

                                        <label class="form-label">Categoría:</label>
                                        <div class="readonly-field">
                                            <c:forEach var="categoria" items="${listaCategorias}">
                                                <c:if test="${categoria.id == ticket.categoria_id}">${categoria.nombre}</c:if>
                                            </c:forEach>
                                        </div>
                                        <input type="hidden" name="categoria_id" value="${ticket.categoria_id}">

                                        <label class="form-label">Severidad:</label>
                                        <div class="readonly-field">${ticket.severidad}</div>
                                        <input type="hidden" name="severidad" value="${ticket.severidad}">

                                        <label class="form-label">Asignar a:</label>
                                        <div class="readonly-field">
                                            <c:forEach var="miembro" items="${integrantes}">
                                                <c:if test="${miembro.id == ticket.asignadoA}">${miembro.nombre}</c:if>
                                            </c:forEach>
                                        </div>
                                        <input type="hidden" name="asignadoA" value="${ticket.asignadoA}">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="descripcion" class="form-label">Descripción:</label>
                                        <textarea class="form-control" id="descripcion" name="descripcion" rows="16" readonly>${ticket.descripcion}</textarea>

                                        <label for="comentario" class="form-label mt-3">Comentario:</label>
                                        <textarea class="form-control" id="comentario" name="comentario" rows="4"></textarea>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-start gap-2">
                                    <button type="submit" class="btn btn-success">Actualizar Ticket</button>
                                    <a href="/ticket?id=${ticket.id}&modo=lectura" class="btn btn-secondary">Cancelar</a>
                                </div>
                            </form>
                        </c:when>
                        <c:when test="${modo == 'inserccion' || modo == 'edicion'}">
                            <form action="/guardarTicket" method="post">
                                <c:if test="${modo == 'edicion'}">
                                    <input type="hidden" name="id" value="${ticket.id}" />
                                </c:if>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="titulo" class="form-label">Título:</label>
                                        <input type="text" class="form-control" id="titulo" name="titulo" value="${ticket.titulo}">

                                        <label for="numero" class="form-label">Número:</label>
                                        <input type="text" class="form-control" id="numero" name="numero" value="${ticket.numero}">

                                        <label for="estado_id" class="form-label">Estado:</label>
                                        <select class="form-control" id="estado_id" name="estado_id">
                                            <c:forEach var="estado" items="${listaEstados}">
                                                <option value="${estado.id}" ${ticket.estado_id == estado.id ? 'selected' : ''}>
                                                    ${estado.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>

                                        <label for="categoria_id" class="form-label">Categoría:</label>
                                        <select class="form-control" id="categoria_id" name="categoria_id">
                                            <c:forEach var="categoria" items="${listaCategorias}">
                                                <option value="${categoria.id}" ${ticket.categoria_id == categoria.id ? 'selected' : ''}>
                                                    ${categoria.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>

                                        <label for="severidad" class="form-label">Severidad:</label>
                                        <select class="form-control" id="severidad" name="severidad">
                                            <option value="CRITICA" ${ticket.severidad == 'CRITICA' ? 'selected' : ''}>CRITICA</option>
                                            <option value="ALTA" ${ticket.severidad == 'ALTA' ? 'selected' : ''}>ALTA</option>
                                            <option value="MEDIA" ${ticket.severidad == 'MEDIA' ? 'selected' : ''}>MEDIA</option>
                                            <option value="BAJA" ${ticket.severidad == 'BAJA' ? 'selected' : ''}>BAJA</option>
                                            <option value="INFO" ${ticket.severidad == 'INFO' ? 'selected' : ''}>INFO</option>
                                        </select>

                                        <label for="asignado_A" class="form-label">Asignar a:</label>
                                        <select class="form-control" id="asignado_A" name="asignadoA">
                                            <c:forEach var="miembro" items="${integrantes}">
                                                <option value="${miembro.id}" ${ticket.asignadoA == miembro.id ? 'selected' : ''}>
                                                    ${miembro.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="descripcion" class="form-label">Descripción:</label>
                                        <textarea class="form-control" id="descripcion" name="descripcion" rows="16">${ticket.descripcion}</textarea>

                                        <label for="comentario" class="form-label mt-3">Comentario:</label>
                                        <textarea class="form-control" id="comentario" name="comentario" rows="4"></textarea>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-start gap-2">
                                    <button type="submit" class="btn btn-success">
                                        <c:if test="${modo == 'inserccion'}">Crear Ticket</c:if>
                                        <c:if test="${modo == 'edicion'}">Actualizar Ticket</c:if>
                                    </button>
                                    <a href="${modo == 'edicion' ? '/ticket?id=' += ticket.id += '&modo=lectura' : '/admin'}" class="btn btn-secondary">Cancelar</a>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p>Modo no reconocido.</p>
                            <a href="/admin" class="btn btn-secondary">Volver</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>