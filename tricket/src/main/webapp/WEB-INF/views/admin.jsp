<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>ADMIN</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            /* ... (tu CSS existente) ... */
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
            /* Estilos para el chat flotante, si es necesario ajustar */
            #chatFlotante {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 300px;
                height: 400px; /* Altura fija para el chat */
                background-color: white;
                border: 1px solid #ccc;
                z-index: 1000;
                box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
                border-radius: 10px;
                overflow: hidden;
                display: none; /* Asegura que esté oculto al inicio */
                flex-direction: column; /* Para organizar el contenido del chat */
            }
            #chatFlotante > div:first-child { /* Encabezado del chat */
                flex-shrink: 0;
            }
            #chatMensajes { /* CAMBIO: ID del contenedor de mensajes del chat */
                flex-grow: 1; /* Permite que ocupe el espacio restante */
                overflow-y: auto;
                padding: 10px;
                background: #f8f9fa;
            }
            #chatFlotante > div:last-child { /* Área de input y botón */
                flex-shrink: 0;
            }
        </style>
        <script>
            function mostrarTablaGenerales() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "block";
                document.getElementById("mistickets").style.display = "none"; // Asegurarse de ocultar otros
                document.getElementById("equipoContainer").style.display = "none"; // Asegurarse de ocultar otros
                document.getElementById("chatFlotante").style.display = "none"; // Ocultar chat si se cambia de sección
            }

            function mostrarMistickets() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "none";
                document.getElementById("mistickets").style.display = "block";
                document.getElementById("equipoContainer").style.display = "none"; // Asegurarse de ocultar otros
                document.getElementById("chatFlotante").style.display = "none"; // Ocultar chat si se cambia de sección
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

            function mostrarEquipo() {
                document.getElementById("dashboardRow").style.display = "none";
                document.getElementById("tablaGenerales").style.display = "none";
                document.getElementById("mistickets").style.display = "none"; // Asegurarse de ocultar otros
                document.getElementById("equipoContainer").style.display = "flex";
                document.getElementById("chatFlotante").style.display = "none"; // Ocultar chat si se cambia de sección
            }
        </script>

       <script>
    let usuarioDestino = null; 

    // Estos valores ya se insertan como strings desde el servidor JSP.
    // Aseguramos que son strings quitando parseInt().
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
        nuevoMensajeDiv.innerHTML = '<b>Tú:</b> ' + mensaje; // Usar concatenación simple para el DOM
        chatBox.appendChild(nuevoMensajeDiv);
        chatBox.scrollTop = chatBox.scrollHeight;
        input.value = "";

        const emisorId = usuarioActualId; 
        const receptorId = usuarioDestino; 
        
        // --- CAMBIO CLAVE: Construir la URL con concatenación pura para evitar cualquier ambigüedad de JSP/EL ---
        // Esto asegura que encodeURIComponent(mensaje) sea evaluado por el navegador.
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
        // --- CAMBIO CLAVE: Construir la URL con concatenación pura ---
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
                            ${user.nombre}
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
