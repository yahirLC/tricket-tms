<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>TRICKET - Mis Datos</title>
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
            flex-shrink: 0; 
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
            padding: 0 5px;
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

       
        .main-layout {
            display: flex;
            flex-grow: 1;
        }

     
        .sidebar {
            width: 250px;
            background-color: #f8f9fa; 
            padding-top: 2rem;
            flex-shrink: 0; 
            box-shadow: 2px 0 5px rgba(0,0,0,0.1); 
        }
        .sidebar h4 {
            color: #333;
            margin-bottom: 1.5rem;
            padding: 0 20px;
        }
        .sidebar a {
            display: block;
            padding: 10px 20px;
            color: #333;
            text-decoration: none;
            transition: background-color 0.2s, color 0.2s;
        }
        .sidebar a.active, .sidebar a:hover {
            background-color: #0d6efd; 
            color: white;
        }

        
        .content {
            flex-grow: 1;
            padding: 2rem;
            background-color: #ffffff;
        }

        
        .data-card {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            
            height: 100%; 
        }
        .data-card h2 {
            color: #0d6efd;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .data-item {
            margin-bottom: 0.75rem;
            display: flex;
            align-items: baseline;
        }
        .data-item strong {
            color: #34495e; 
            display: inline-block;
            width: 130px; 
            flex-shrink: 0; 
        }
        .data-item span {
            color: #555;
            flex-grow: 1; 
        }

        
       
    </style>
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

    <div class="main-layout">
        <div class="sidebar">
            <h4 class="text-center">TRICKET</h4>
            <a href="javascript:history.back()">Dashboard</a>
            
            <a href="/aboutMe" class="active">Mis datos</a> 
        </div>

        <div class="content">
            <div class="container-fluid">
                <div class="row g-4 mb-4"> 
                    <div class="col-md-6"> 
                        <div class="data-card">
                            <h2>Mis Datos Personales</h2>
                            <c:if test="${not empty usuarioLogueado}">
                                <div class="data-item"><strong>ID:</strong> <span>${usuarioLogueado.id}</span></div>
                                <div class="data-item"><strong>Nombre:</strong> <span>${usuarioLogueado.nombre}</span></div>
                                <div class="data-item"><strong>Apellido Paterno:</strong> <span>${usuarioLogueado.apellido_paterno}</span></div>
                                <div class="data-item"><strong>Apellido Materno:</strong> <span>${usuarioLogueado.apellido_materno}</span></div>
                                <div class="data-item"><strong>Email:</strong> <span>${usuarioLogueado.correo}</span></div> <%-- Corregido: .email a .correo --%>
                                <div class="data-item"><strong>Usuario:</strong> <span>${usuarioLogueado.usuario}</span></div>
                                <div class="data-item"><strong>Rol:</strong> <span>${usuarioLogueado.rol}</span></div>
                                <div class="data-item"><strong>Fecha de Registro:</strong> <span>${usuarioLogueado.fecha_registro}</span></div>
                            </c:if>
                            <c:if test="${empty usuarioLogueado}">
                                <div class="alert alert-warning text-center" role="alert">
                                    No se encontraron datos de usuario. Por favor, inicia sesión.
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="col-md-6"> 
                        <div class="data-card">
                            <h2>Datos de Mi Grupo</h2>
                            <c:if test="${not empty grupoDelUsuario}">
                                <div class="data-item"><strong>ID de Grupo:</strong> <span>${grupoDelUsuario.id}</span></div>
                                <div class="data-item"><strong>Nombre del Grupo:</strong> <span>${grupoDelUsuario.nombre}</span></div>
                            </c:if>
                            <c:if test="${empty grupoDelUsuario}">
                                <div class="alert alert-info text-center" role="alert">
                                    Actualmente no perteneces a ningún grupo.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleDropdown() {
            var dropdownMenu = document.getElementById("adminDropdownMenu");
            if (dropdownMenu.style.display === "none") {
                dropdownMenu.style.display = "block";
            } else {
                dropdownMenu.style.display = "none";
            }
        }

        // Cierra el dropdown si se hace clic fuera de él
        window.onclick = function(event) {
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
</body>
</html>