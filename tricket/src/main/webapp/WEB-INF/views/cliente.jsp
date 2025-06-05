<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>CLIENTE</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            
            body {
                display: flex;
                min-height: 100vh;
                flex-direction: column;
            }
            .navbar-admin {
                background-color: #2c3e50;
                color: white;
                padding: 0.5rem 1rem;
                display: flex;
                justify-content: flex-end; 
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
                right: 0; 
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

            
            #chatFlotante {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 300px;
                height: 400px; 
                background-color: white;
                border: 1px solid #ccc;
                z-index: 1000;
                box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
                border-radius: 10px;
                overflow: hidden;
                display: none;
                flex-direction: column; 
            }
            #chatFlotante > div:first-child { 
                flex-shrink: 0;
            }
            #chatMensajes { 
                flex-grow: 1; 
                overflow-y: auto;
                padding: 10px;
                background: #f8f9fa;
            }
            #chatFlotante > div:last-child {
                flex-shrink: 0;
            }
        </style>
        <script>


            function mostrarMistickets() {
                document.getElementById("dashboardRow").style.display = "none";

                document.getElementById("mistickets").style.display = "block";
                document.getElementById("equipoContainer").style.display = "none";
                document.getElementById("chatFlotante").style.display = "none";
                document.getElementById("notificacionesContainer").style.display = "none";
                buscarEnMistickets();
            }

            function mostrarNotificaciones() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("mistickets").style.display = "none";
                document.getElementById("equipoContainer").style.display = "none";
                document.getElementById("chatFlotante").style.display = "none"; 
                document.getElementById("notificacionesContainer").style.display = "flex";
            }

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

            function buscarEnTabla() {
                const input = document.getElementById("searchInput");
                const filter = input.value.toUpperCase();
                const mostrarFinalizados = document.getElementById("mostrarFinalizados").checked;

                const table = document.getElementById("ticketsTable");
                const tbody = table.getElementsByTagName("tbody")[0];
                const rows = tbody.getElementsByTagName("tr");

                for (let i = 0; i < rows.length; i++) {
                    const cells = rows[i].getElementsByTagName("td");
                    let encontrado = false;
                    let esFinalizado = false;

                    for (let j = 0; j < cells.length; j++) {
                        const cellText = cells[j].textContent || cells[j].innerText;

                        if (cellText.toUpperCase().indexOf("FINALIZADO") !== -1) {
                            esFinalizado = true;
                        }

                        if (cellText.toUpperCase().indexOf(filter) > -1) {
                            encontrado = true;
                        }
                    }


                    if (encontrado && (mostrarFinalizados || !esFinalizado)) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            }

            function buscarEnMistickets() {
                const input = document.getElementById("searchInputTickets");
                const filter = input.value.toUpperCase();
                const mostrarFinalizados = document.getElementById("mostrarFinalizadosTickets").checked;

                const table = document.getElementById("misticketsTable");
                const tbody = table.getElementsByTagName("tbody")[0];
                const rows = tbody.getElementsByTagName("tr");

                for (let i = 0; i < rows.length; i++) {
                    const cells = rows[i].getElementsByTagName("td");
                    let encontrado = false;
                    let esFinalizado = false;

                    for (let j = 0; j < cells.length; j++) {
                        const cellText = cells[j].textContent || cells[j].innerText;

                        if (cellText.toUpperCase().indexOf("FINALIZADO") !== -1) {
                            esFinalizado = true;
                        }

                        if (cellText.toUpperCase().indexOf(filter) > -1) {
                            encontrado = true;
                        }
                    }

                    if (encontrado && (mostrarFinalizados || !esFinalizado)) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            }

            function mostrarEquipo() {
                document.getElementById("dashboardRow").style.display = "none";

                document.getElementById("mistickets").style.display = "none"; // Asegurarse de ocultar otros
                document.getElementById("equipoContainer").style.display = "flex";
                document.getElementById("chatFlotante").style.display = "none"; // Ocultar chat si se cambia de sección
                document.getElementById("notificacionesContainer").style.display = "none";
            }
        </script>

        <script>
            let usuarioDestino = null;

            
            const usuarioActualId = '${usuarioLogueado.id}';
            const usuarioActualNombre = '${usuarioLogueado.nombre}';


            function abrirChat(nombreUsuario, idUsuario) {
                document.getElementById("nombreUsuarioChat").textContent = nombreUsuario;
                document.getElementById("chatFlotante").style.display = "flex";
                document.getElementById("chatMensajes").innerHTML = "";
                usuarioDestino = idUsuario; // idUsuario ya es un String
                cargarHistorialChat(usuarioActualId, usuarioDestino);
            }

            function cerrarChat() {
                document.getElementById("chatFlotante").style.display = "none";
                usuarioDestino = null;
            }

            function manejarEnter(event) {
                if (event.key === "Enter") {
                    enviarMensaje();
                }
            }

            function enviarMensaje() {
                const input = document.getElementById("inputMensaje");
                const mensaje = input.value.trim();
                if (mensaje === "") {
                    return;
                }

                const chatBox = document.getElementById("chatMensajes");

                const nuevoMensajeDiv = document.createElement("div");
                nuevoMensajeDiv.style.margin = "5px 0";
                nuevoMensajeDiv.innerHTML = '<b>Tú:</b> ' + mensaje; 
                chatBox.appendChild(nuevoMensajeDiv);
                chatBox.scrollTop = chatBox.scrollHeight;
                input.value = "";

                const emisorId = usuarioActualId;
                const receptorId = usuarioDestino;

                
                
                const urlEnviar = "/chat/enviar?emisor=" + emisorId + "&receptor=" + receptorId + "&contenido=" + encodeURIComponent(mensaje);

                fetch(urlEnviar, {
                    method: "POST"
                }).then(response => {
                    if (!response.ok) {
                        throw new Error("Error al guardar el mensaje.");
                    }
                }).catch(error => {
                    alert("No se pudo guardar el mensaje: " + error.message);
                });
            }

            function cargarHistorialChat(usuario1Id, usuario2Id) {
                
                const urlConversacion = "/chat/conversacion?usuario1=" + usuario1Id + "&usuario2=" + usuario2Id;

                fetch(urlConversacion, {
                    method: "GET"
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error("Error al cargar el historial del chat.");
                            }
                            return response.json();
                        })
                        .then(mensajes => {
                            const chatBox = document.getElementById("chatMensajes");
                            chatBox.innerHTML = "";

                            mensajes.forEach(msg => {
                                const nuevoMensaje = document.createElement("div");
                                nuevoMensaje.style.margin = "5px 0";

                                const nombreRemitente = msg.remitente.nombre;
                                const contenidoMensaje = msg.contenido;

                                // Comparación de Strings para la consistencia con el backend.
                                // Si msg.remitente.id es un número en el JSON, String() lo convierte a String.
                                const esMio = (String(msg.remitente.id) === usuarioActualId);

                                nuevoMensaje.innerHTML = '<b>' + (esMio ? 'Tú' : nombreRemitente) + ':</b> ' + contenidoMensaje; // Concatenación simple
                                chatBox.appendChild(nuevoMensaje);
                            });
                            chatBox.scrollTop = chatBox.scrollHeight;
                        })
                        .catch(error => {
                            console.error("Error cargando el historial de chat:", error);
                            alert("No se pudo cargar el historial de chat: " + error.message);
                        });
            }
        </script>
    </head>
    <body>

        <div class="navbar-admin">
            <div class="admin-info">
                <span class="admin-text">${usuarioLogueado.nombre} - Cliente</span>
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
                <a href="/cliente">Dashboard</a>
                
                <a href="/aboutMe">Mis datos</a>
            </div>

            <div class="content">
                <div id="dashboardRow" class="row g-4">
                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarMistickets()">
                            <div class="dashboard-title">Tickets</div>
                            <div class="dashboard-number">${misticketsNoCerrados}-${totalMisTickets}</div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarEquipo()">
                            <div class="dashboard-title">Equipo</div>
                            <div class="dashboard-number">${totalIntegrantes}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-card" onclick="mostrarNotificaciones()">
                            <div class="dashboard-title">Notificaciones</div>
                            <div class="dashboard-number">${countNotificaciones}</div>
                        </div>
                    </div>
                </div>



                <div id="mistickets" class="table-responsive mt-4" style="display:none;">
                    <div class="d-flex align-items-center mb-3">
                        <div class="mb-3">
                            <input type="text" id="searchInputTickets" onkeyup="buscarEnMistickets()" placeholder="Buscar..." class="form-control" style="width: 300px; display: inline-block;">
                            <label>
                                <input type="checkbox" id="mostrarFinalizadosTickets" onclick="buscarEnMistickets()"> Finalizados
                            </label>
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

                <div id="equipoContainer" class="row g-3" style="display: none;">
                    <c:forEach var="user" items="${integrantes}">
                        <div onclick="abrirChat('${user.nombre}', '${user.id}')" style="cursor: pointer; padding: 10px; border: 1px solid #ddd; margin-bottom: 5px;">
                            ${user.nombre} #${user.id}
                        </div>
                    </c:forEach>
                </div>
                <div id="notificacionesContainer" class="row g-3" style="display: none;">
                    <c:forEach var="noti" items="${listaNotificaciones}" varStatus="status">
                        <div class="border p-2" style="cursor: pointer;"
                             data-bs-toggle="modal" data-bs-target="#notiModal${status.index}">
                            ${noti.accion}
                        </div>

                        <!-- Modal para cada notificación -->
                        <div class="modal fade" id="notiModal${status.index}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Notificación</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>
                                    <div class="modal-body">
                                        ${noti.descripcion}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>


                <div id="chatFlotante" style="display: none; position: fixed; bottom: 20px; right: 20px; width: 300px; background: white; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.2); z-index: 9999; flex-direction: column;">
                    <div style="background-color: #0d6efd; color: white; padding: 10px; border-top-left-radius: 10px; border-top-right-radius: 10px;">
                        <strong id="nombreUsuarioChat">Chat</strong>
                        <span style="float: right; cursor: pointer;" onclick="cerrarChat()">✖</span>
                    </div>
                    <div id="chatMensajes" style="padding: 10px; max-height: 200px; overflow-y: auto;">
                        <p style="color: gray;">(Aquí irían los mensajes)</p>
                    </div>
                    <div style="padding: 10px; border-top: 1px solid #ccc; display: flex; gap: 5px;">
                        <input type="text" class="form-control form-control-sm" id="inputMensaje" placeholder="Escribe un mensaje..." onkeydown="manejarEnter(event)">
                        <button class="btn btn-sm btn-primary" onclick="enviarMensaje()">Enviar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
