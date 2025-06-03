<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar sesión / Registro</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
        <script>
            function mostrarRegistro() {
                document.getElementById('loginForm').style.display = 'none';
                document.getElementById('registroForm').style.display = 'block';
            }

            function mostrarLogin() {
                document.getElementById('registroForm').style.display = 'none';
                document.getElementById('loginForm').style.display = 'block';
            }
        </script>
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <h2 class="text-center mb-4">Bienvenido</h2>

            <!-- FORMULARIO DE LOGIN -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" class="mx-auto" style="max-width: 400px;">
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>
                <div class="mb-3">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                </div>

                <div class="mb-3 text-end">
                    <a href="#" onclick="mostrarRegistro()">¿No tienes cuenta? Registrarme</a>
                </div>

                <button type="submit" class="btn btn-primary w-100">Ingresar</button>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3">${error}</div>
                </c:if>


            </form>

            <!-- FORMULARIO DE REGISTRO -->
            <form id="registroForm" action="${pageContext.request.contextPath}/registro" method="post" class="mx-auto" style="max-width: 400px; display: none;">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                </div>
                <div class="mb-3">
                    <label for="apellidoPaterno" class="form-label">Apellido Paterno</label>
                    <input type="text" class="form-control" id="apellidoPaterno" name="apellidoPaterno" required>
                </div>
                <div class="mb-3">
                    <label for="apellidoMaterno" class="form-label">Apellido Materno</label>
                    <input type="text" class="form-control" id="apellidoMaterno" name="apellidoMaterno" required>
                </div>
                <div class="mb-3">
                    <label for="usuario" class="form-label">Usuario</label>
                    <input type="text" class="form-control" id="usuario" name="usuario" required>
                </div>

                <div class="mb-3">
                    <label for="correoRegistro" class="form-label">Correo</label>
                    <input type="email" class="form-control" id="correoRegistro" name="correo" required>
                </div>
                <div class="mb-3">
                    <label for="contrasenaRegistro" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="contrasenaRegistro" name="contrasena" required>
                </div>
                <div class="mb-3">
                    <label for="confirmarContrasena" class="form-label">Confirmar contraseña</label>
                    <input type="password" class="form-control" id="confirmarContrasena" name="confirmarContrasena" required>
                </div>

                <div class="mb-3 text-end">
                    <a href="#" onclick="mostrarLogin()">¿Ya tienes cuenta? Iniciar sesión</a>
                </div>

                <button type="submit" class="btn btn-success w-100">Registrarme</button>

                <c:if test="${not empty errorRegistro}">
                    <div class="alert alert-danger mt-3">${errorRegistro}</div>
                </c:if>

            </form>
        </div>

    </body>
</html>
