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
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                /* Fondo animado */
                background: linear-gradient(-45deg, #a8e6cf, #dcedc1, #a8e6cf, #dcedc1);
                background-size: 400% 400%;
                animation: animateBackground 15s ease infinite;
            }

            @keyframes animateBackground {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            
            .navbar-admin {
                background-color: #004d40; 
                color: white;
                padding: 0.8rem 1.5rem; 
                display: flex;
                justify-content: flex-end;
                align-items: center;
                font-size: 1rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); 
            }
            .admin-info {
                display: flex;
                align-items: center;
            }
            .admin-text {
                margin-right: 0.8rem;
                font-weight: 500;
            }
            .dropdown-admin {
                position: relative;
                display: inline-block;
            }
            .dropdown-toggle-admin {
                cursor: pointer;
                font-size: 1.5rem; 
                color: rgba(255, 255, 255, 0.8);
                transition: color 0.3s ease;
            }
            .dropdown-toggle-admin:hover {
                color: white;
            }
            .dropdown-menu-admin {
                position: absolute;
                background-color: #00332e; 
                color: white;
                min-width: 120px; 
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.3); 
                z-index: 1001; 
                right: 0;
                border-radius: 8px; /* Bordes redondeados */
                overflow: hidden; /* Para que los bordes redondeados se apliquen a los enlaces */
            }
            .dropdown-menu-admin a {
                color: white;
                padding: 10px 15px; /* Más padding */
                text-decoration: none;
                display: block;
                font-size: 0.95rem;
                transition: background-color 0.3s ease;
            }
            .dropdown-menu-admin a:hover {
                background-color: #00695c; /* Un verde intermedio para el hover */
            }

            /* Sidebar */
            .sidebar {
                width: 250px;
                background-color: #ffffff; /* Blanco para el sidebar */
                padding-top: 2rem;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05); /* Sombra lateral */
                border-right: 1px solid #eee; /* Borde sutil */
                flex-shrink: 0; /* Evita que el sidebar se encoja */
            }
            .sidebar h4 {
                color: #004d40; /* Color del texto del título TRICKET */
                margin-bottom: 2rem;
                font-weight: 700;
                letter-spacing: 1px; /* Espaciado entre letras */
            }
            .sidebar a {
                display: block;
                padding: 12px 25px; /* Más padding */
                color: #495057; /* Gris oscuro para el texto */
                text-decoration: none;
                transition: all 0.3s ease; /* Transición suave para hover */
                font-weight: 500;
            }
            .sidebar a.active, .sidebar a:hover {
                background-color: #28a745; /* Verde Bootstrap */
                color: white;
                border-radius: 0 25px 25px 0; /* Bordes redondeados en la derecha */
                margin-right: 10px; /* Margen para el efecto visual */
            }

            /* Contenido principal */
            .content {
                flex-grow: 1;
                padding: 2.5rem; /* Más padding */
                background-color: rgba(255, 255, 255, 0.95); /* Fondo blanco con ligera transparencia */
                border-radius: 10px; /* Bordes redondeados */
                margin: 20px; /* Margen alrededor del contenido */
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Sombra más pronunciada */
            }

            /* Tarjetas de Dashboard */
            .dashboard-card {
                cursor: pointer;
                padding: 2.5rem; /* Más padding */
                border-radius: 15px; /* Bordes más redondeados */
                background-color: #f0f8f0; /* Un verde muy claro */
                text-align: center;
                transition: all 0.3s ease;
                border: 1px solid #d4edda; /* Borde verde claro */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }
            .dashboard-card:hover {
                background-color: #e6ffe6; /* Un verde más claro al pasar el ratón */
                transform: translateY(-5px); /* Pequeño efecto de elevación */
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            }
            .dashboard-title {
                font-size: 1.4rem; /* Tamaño de fuente ligeramente más grande */
                margin-bottom: 0.8rem;
                color: #004d40; /* Verde oscuro */
                font-weight: 600;
            }
            .dashboard-number {
                font-size: 2.8rem; /* Tamaño de fuente más grande */
                font-weight: bold;
                color: #28a745; /* Verde Bootstrap */
            }

            /* Tablas */
            .table-responsive {
                background-color: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            }
            .table-bordered th, .table-bordered td {
                border-color: #e9ecef; /* Color de borde más suave */
            }
            .table-hover tbody tr:hover {
                background-color: #f1f8e9; /* Un verde más claro al pasar el ratón por las filas */
                cursor: pointer;
            }
            .table-success th {
                background-color: #28a745; /* Verde Bootstrap */
                color: white;
                border-color: #28a745;
            }

            /* Campo de búsqueda y checkbox */
            .form-control {
                border-radius: 8px;
                border-color: #ced4da;
            }
            .form-control:focus {
                box-shadow: 0 0 0 0.25rem rgba(40, 167, 69, 0.25); /* Sombra de enfoque verde */
                border-color: #28a745;
            }
            label input[type="checkbox"] {
                margin-left: 15px;
                margin-right: 5px;
            }

            /* Botón "Nuevo" */
            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }
            .btn-success:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }
            .btn-sm {
                padding: 0.3rem 0.8rem;
                font-size: 0.875rem;
                border-radius: 6px;
            }

            /* Contenedor de equipo, notificaciones y solicitudes */
            #equipoContainer .border,
            #notificacionesContainer .border,
            #solicitudesContainer .border {
                background-color: #fdfdfd;
                border: 1px solid #e0e0e0 !important;
                border-radius: 8px;
                margin-bottom: 10px;
                padding: 15px !important;
                transition: all 0.3s ease;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }
            #equipoContainer .border:hover,
            #notificacionesContainer .border:hover,
            #solicitudesContainer .border:hover {
                background-color: #f0f0f0;
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            }

            /* Modales */
            .modal-content {
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }
            .modal-header {
                background-color: #004d40; /* Verde oscuro */
                color: white;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                border-bottom: none;
            }
            .modal-title {
                font-weight: bold;
            }
            .modal-footer {
                border-top: none;
                padding-top: 0;
            }

            /* Chat flotante */
            #chatFlotante {
                position: fixed;
                bottom: 30px; /* Más separado del borde */
                right: 30px; /* Más separado del borde */
                width: 320px; /* Un poco más ancho */
                height: 450px; /* Un poco más alto */
                background: white;
                border: 1px solid #ccc;
                border-radius: 15px; /* Más redondeado */
                box-shadow: 0 5px 20px rgba(0,0,0,0.3); /* Sombra más prominente */
                z-index: 9999;
                display: none;
                flex-direction: column;
                overflow: hidden; /* Asegura que todo el contenido respete el border-radius */
            }
            #chatFlotante > div:first-child {
                background-color: #28a745; /* Encabezado verde */
                color: white;
                padding: 12px 15px;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: bold;
            }
            #chatFlotante > div:first-child span {
                cursor: pointer;
                font-size: 1.2rem;
                opacity: 0.8;
                transition: opacity 0.2s ease;
            }
            #chatFlotante > div:first-child span:hover {
                opacity: 1;
            }
            #chatMensajes {
                flex-grow: 1;
                overflow-y: auto;
                padding: 15px; /* Más padding */
                background: #f8f9fa; /* Fondo ligeramente gris para los mensajes */
                border-bottom: 1px solid #eee;
            }
            #chatMensajes div {
                margin: 8px 0;
                padding: 8px 12px;
                border-radius: 10px;
                line-height: 1.4;
                max-width: 85%;
            }
            #chatMensajes div b {
                font-weight: 600;
            }
            #chatMensajes div:has(b:contains("Tú:")) { /* Mensajes enviados por el usuario actual */
                background-color: #e1ffc7; /* Fondo verde claro */
                align-self: flex-end; /* Alinea a la derecha */
                margin-left: auto; /* Empuja a la derecha */
                text-align: right;
            }
            #chatMensajes div:not(:has(b:contains("Tú:"))) { /* Mensajes de otros usuarios */
                background-color: #e9ecef; /* Fondo gris claro */
                align-self: flex-start; /* Alinea a la izquierda */
                margin-right: auto; /* Empuja a la izquierda */
                text-align: left;
            }

            #chatFlotante > div:last-child {
                padding: 15px;
                border-top: 1px solid #e0e0e0;
                display: flex;
                gap: 8px;
            }
            #inputMensaje {
                border-radius: 20px; /* Bordes redondeados para el input */
                padding: 8px 15px;
            }
            #chatFlotante .btn-sm {
                border-radius: 20px; /* Bordes redondeados para el botón */
                padding: 8px 15px;
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
                        <thead class="table-success"> <%-- Cambiado de table-primary a table-success --%>
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
                    <div style="background-color: #28a745; color: white; padding: 10px; border-top-left-radius: 10px; border-top-right-radius: 10px;"> <%-- Verde cambiado --%>
                        <strong id="nombreUsuarioChat">Chat</strong>
                        <span style="float: right; cursor: pointer;" onclick="cerrarChat()">✖</span>
                    </div>
                    <div id="chatMensajes" style="padding: 10px; max-height: 200px; overflow-y: auto;">
                        <p style="color: gray;">(Aquí irían los mensajes)</p>
                    </div>
                    <div style="padding: 10px; border-top: 1px solid #ccc; display: flex; gap: 5px;">
                        <input type="text" class="form-control form-control-sm" id="inputMensaje" placeholder="Escribe un mensaje..." onkeydown="manejarEnter(event)">
                        <button class="btn btn-sm btn-success" onclick="enviarMensaje()">Enviar</button> <%-- Cambiado de btn-primary a btn-success --%>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>