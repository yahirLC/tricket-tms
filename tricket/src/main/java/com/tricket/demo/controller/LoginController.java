package com.tricket.demo.controller;

import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    // GET: Mostrar formulario de login
    @GetMapping("/login")
    public String mostrarFormularioLogin(@RequestParam(value = "error", required = false) String error, // Puedes seguir usando esto para errores
            @RequestParam(value = "logout", required = false) String logout, // Puedes seguir usando esto para logout
            Model model) {
        if (error != null) {
            model.addAttribute("error", "Correo o contraseña incorrectos.");
        }
        if (logout != null) {
            model.addAttribute("message", "Has cerrado sesión exitosamente.");
        }
        return "login";
    }

    // POST: Procesar login (TU LÓGICA VUELVE AQUÍ)
    @PostMapping("/login")
    public String login(@RequestParam String correo,
            @RequestParam String contrasena, // Contraseña en texto plano del formulario
            HttpSession session,
            Model model) {
        // Llama a tu servicio para autenticar. El servicio ahora maneja el hasheo.
        UsuarioJPA usuario = usuarioService.autenticar(correo, contrasena);
        if (usuario != null) {
            session.setAttribute("usuarioLogueado", usuario); // Si es exitoso, guarda en sesión
            return "redirect:/tecnico"; // Redirige a tu página de dashboard
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos");
            return "login"; // Vuelve al formulario con error
        }
    }

    // GET: Cerrar sesión (TU LÓGICA VUELVE AQUÍ)
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Invalida la sesión actual
        return "redirect:/login?logout=true"; // Redirige al login con un mensaje de logout
    }

    @PostMapping("/registro")
    public String registro(@RequestParam String nombre,
            @RequestParam String apellidoPaterno,
            @RequestParam String apellidoMaterno,
            @RequestParam String usuario,
            @RequestParam String correo,
            @RequestParam String contrasena,
            @RequestParam String confirmarContrasena,
            Model model) {

        // Verifica que las contraseñas coincidan
        if (!contrasena.equals(confirmarContrasena)) {
            model.addAttribute("errorRegistro", "Las contraseñas no coinciden.");
            return "login"; // Regresa a la misma vista porque login.jsp tiene ambos formularios
        }

        // Verifica si ya existe un usuario con ese correo
        if (usuarioService.buscarPorCorreo(correo).isPresent()) {
            model.addAttribute("errorRegistro", "Ya existe una cuenta con este correo.");
            return "login";
        }

        // Verifica si ya existe ese nombre de usuario
        if (usuarioService.buscarPorUsuario(usuario).isPresent()) {
            model.addAttribute("errorRegistro", "El nombre de usuario ya está en uso.");
            return "login";
        }

        // Crea el objeto y guarda
        UsuarioJPA nuevoUsuario = new UsuarioJPA();
        nuevoUsuario.setNombre(nombre);

        nuevoUsuario.setApellido_paterno(apellidoPaterno);
        nuevoUsuario.setApellido_materno(apellidoMaterno);
        nuevoUsuario.setRol("cliente");
        nuevoUsuario.setFecha_registro(new Timestamp(new Date().getTime()));
        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setContrasena(contrasena); // El servicio la hashea

        usuarioService.guardar(nuevoUsuario);

        model.addAttribute("message", "Registro exitoso. Ahora puedes iniciar sesión.");
        return "login";
    }

}
