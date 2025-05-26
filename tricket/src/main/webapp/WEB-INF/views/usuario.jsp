<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <h1 class="text-center mb-4">Usuarios</h1>
        <table class="table table-bordered table-hover table-striped">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>NOMBRE</th>
                    <th>CORREO</th>
                    <th>CONTRASENA</th>
                    <th>ROL</th>
                    <th>GRUPO_ID</th>
                    <th>FECHA_REGISTRO</th>
                    <th>USER</th>
                    <th>APELLIDO_MATERNO</th>
                    <th>APELLIDO_PATERNO</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usr" items="${usuarios}">
                    <tr>
                        <td>${usr.id}</td>
                        <td>${usr.nombre}</td>
                         <td>${usr.correo}</td>
                        <td>${usr.contrasena}</td>
                         <td>${usr.rol}</td>
                        <td>${usr.grupo_id}</td>
                         <td>${usr.fecha_registro}</td>
                        <td>${usr.usuario}</td>
                         <td>${usr.apellido_materno}</td>
                        <td>${usr.apellido_paterno}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
