<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Grupo de Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                background: linear-gradient(-45deg, #a8e6cf, #dcedc1, #a8e6cf, #dcedc1);
                background-size: 400% 400%;
                animation: animateBackground 15s ease infinite;
                display: flex; /* Añadido para centrar el contenido */
                align-items: center; /* Centra verticalmente */
                justify-content: center; /* Centra horizontalmente */
            }

            @keyframes animateBackground {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            .card {
                background-color: rgba(255, 255, 255, 0.9); /* Ligeramente transparente para ver el fondo */
            }

            /* Estilos para los enlaces/botones de cambio de formulario */
            .btn-link {
                color: #28a745 !important; /* verde */
            }

            .btn-link:hover {
                color: #1e7e34 !important;
            }
        </style>

        <script>
            function mostrarInputGrupoId() {
                document.getElementById("crearGrupo").style.display = "none";
                document.getElementById("unirseGrupo").style.display = "block";
                document.getElementById("btnIngresarGrupo").style.display = "none";
                document.getElementById("btnCrearGrupo").style.display = "block";
            }

            function mostrarCrearGrupo() {
                document.getElementById("unirseGrupo").style.display = "none";
                document.getElementById("crearGrupo").style.display = "block";
                document.getElementById("btnCrearGrupo").style.display = "none";
                document.getElementById("btnIngresarGrupo").style.display = "block";
            }
        </script>
    </head>
    <body>

        <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
            <h3 class="text-center mb-4">¡Bienvenido!</h3>

            <form id="crearGrupo" action="/crearGrupo" method="post">
                <div class="mb-3">
                    <label for="nombreGrupo" class="form-label">Nombre para el grupo:</label>
                    <input type="text" name="nombreGrupo" id="nombreGrupo" class="form-control" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Crear grupo</button>
                </div>
            </form>

            <form id="unirseGrupo" action="/unirseGrupo" method="post" style="display: none;">
                <div class="mb-3 mt-4">
                    <label for="grupoId" class="form-label">ID del grupo:</label>
                    <input type="number" name="grupoId" id="grupoId" class="form-control" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Unirse al grupo</button>
                </div>
            </form>

            <div class="text-center mt-3">
                <button id="btnIngresarGrupo" class="btn btn-link p-0" onclick="mostrarInputGrupoId()">Ingresar a un grupo</button>
                <button id="btnCrearGrupo" class="btn btn-link p-0" onclick="mostrarCrearGrupo()" style="display: none;">Crear grupo</button>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>