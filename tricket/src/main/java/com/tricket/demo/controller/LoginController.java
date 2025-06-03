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

    // GET: Mostrar formulario de login sin errores
    @GetMapping("/login")
    public String mostrarFormularioLogin() {
        return "login"; // No envíes "error" aquí, el JSP lo controlará si está vacío
    }
    
    
    // POST: Procesar login
    @PostMapping("/login")
    public String login(@RequestParam String correo,
            @RequestParam String contrasena,
            HttpSession session,
            Model model) {
        UsuarioJPA usuario = usuarioService.autenticar(correo, contrasena);
        if (usuario != null) {
            session.setAttribute("usuarioLogueado", usuario);
            return "redirect:/tecnico"; // o el dashboard que tengas
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos");
            return "login";
        }
    }

    // GET: Cerrar sesión
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
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
        if (!contrasena.equals(confirmarContrasena)) {
            model.addAttribute("errorRegistro", "Las contraseñas no coinciden");
            return "login"; // Vuelve al JSP donde está el formulario y muestra error
        }

        // Aquí puedes hacer más validaciones (correo o usuario únicos, etc.)
        // Crear y guardar el usuario
        UsuarioJPA nuevoUsuario = new UsuarioJPA();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setApellido_paterno(apellidoPaterno);
        nuevoUsuario.setApellido_materno(apellidoMaterno);

        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setContrasena(contrasena);
        nuevoUsuario.setRol("cliente");
        nuevoUsuario.setFecha_registro(new Timestamp(new Date().getTime()));

        usuarioService.guardar(nuevoUsuario);

        // Redirigir al login o directamente loguear
        return "redirect:/login";
    }

}
