<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Grupo de Usuario</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

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
    <body class="bg-light d-flex align-items-center justify-content-center vh-100">

        <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
            <h3 class="text-center mb-4">¡Bienvenido!</h3>

            <!-- Formulario para crear un nuevo grupo -->
            <form id="crearGrupo" action="/crearGrupo" method="post">
                <div class="mb-3">
                    <label for="nombreGrupo" class="form-label">Nombre para el grupo:</label>
                    <input type="text" name="nombreGrupo" id="nombreGrupo" class="form-control" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Crear grupo</button>
                </div>
            </form>

            <!-- Formulario oculto para ingresar a un grupo existente -->
            <form id="unirseGrupo" action="/unirseGrupo" method="post" style="display: none;">
                <div class="mb-3 mt-4">
                    <label for="grupoId" class="form-label">ID del grupo:</label>
                    <input type="number" name="grupoId" id="grupoId" class="form-control" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Unirse al grupo</button>
                </div>
            </form>

            <!-- Botones de navegación entre formularios -->
            <div class="text-center mt-3">
                <button id="btnIngresarGrupo" class="btn btn-link p-0" onclick="mostrarInputGrupoId()">Ingresar a un grupo</button>
                <button id="btnCrearGrupo" class="btn btn-link p-0" onclick="mostrarCrearGrupo()" style="display: none;">Crear grupo</button>
            </div>
        </div>

        <!-- Bootstrap JS (opcional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
