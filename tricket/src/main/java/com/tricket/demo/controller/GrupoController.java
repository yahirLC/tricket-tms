package com.tricket.demo.controller;

import com.tricket.demo.model.entity.GrupoJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.GrupoService;
import com.tricket.demo.service.SolicitudService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class GrupoController {

    @Autowired
    private GrupoService grupoService;

    @Autowired
    private SolicitudService solicitudService;

    @GetMapping("/grupo")
    public String listar(Model model) {
        model.addAttribute("grupos", grupoService.listarGrupos());
        return "grupo";
    }

    @PostMapping("/unirseGrupo")
    public String unirseGrupo(@RequestParam("grupoId") Integer idgroup,
            HttpSession session, // Inyecta la sesión
            RedirectAttributes redirectAttributes) {

        
        UsuarioJPA usuarioLogueado = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null || usuarioLogueado.getId() == null) {
            redirectAttributes.addFlashAttribute("error", "Debes iniciar sesión para unirte a un grupo.");
            return "redirect:/login"; // Redirige a la página de login si no hay usuario en sesión
        }

        Integer iduser = usuarioLogueado.getId();

        
        boolean solicitudCreada = solicitudService.crearSolicitud(iduser, idgroup);

        if (solicitudCreada) {
            redirectAttributes.addFlashAttribute("mensaje", "¡Solicitud para unirse al grupo enviada exitosamente! Espera la aprobación.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Ya existe una solicitud pendiente o te has unido a este grupo previamente.");
        }

        
        return "redirect:/login"; 
    }

    @GetMapping("/aboutMe")
    public String showAboutMe(Model model, HttpSession session) {
        UsuarioJPA usuarioLogueado = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            
            return "redirect:/login"; 
        }

        
        model.addAttribute("usuarioLogueado", usuarioLogueado);

        
        GrupoJPA grupoDelUsuario = null;
        if (usuarioLogueado.getGrupoId() != null) { // Asume que UsuarioJPA tiene un getGrupoId()
            
            grupoDelUsuario = grupoService.obtenerGrupoPorId(usuarioLogueado.getGrupoId());
        }
        model.addAttribute("grupoDelUsuario", grupoDelUsuario);

        return "about"; 
    }

}
