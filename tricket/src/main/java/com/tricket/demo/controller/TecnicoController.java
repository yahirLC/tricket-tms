package com.tricket.demo.controller;

import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.CategoriaService;
import com.tricket.demo.service.ComentarioService;
import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.GrupoService;
import com.tricket.demo.service.HistorialService;
import com.tricket.demo.service.NotificacionService;
import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TecnicoController {

    @Autowired
    private GrupoService grupoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private ComentarioService comentarioService;

    @Autowired
    private NotificacionService notificacionService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private HistorialService historialService;

    @Autowired
    private EstadoService estadoService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/tecnico")
    public String mostrarTecnico(HttpSession session, Model model) {
        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"tecnico".equals(usuario.getRol())) {

            if ("admin".equals(usuario.getRol())) {

                System.out.println("admin");
                return "redirect:/admin";
            } else {

                if ("cliente".equals(usuario.getRol())) {
                    System.out.println("cliente");
                    return "redirect:/cliente";
                }

            }

            return "redirect:/login";
        }

        model.addAttribute("categorias", categoriaService.listarCategorias());
        model.addAttribute("comentarios", comentarioService.listarComentarios());
        model.addAttribute("grupos", grupoService.listarGrupos());
        model.addAttribute("notificaciones", notificacionService.listarNotificaciones());
        model.addAttribute("tickets", ticketService.listarTickets());
        model.addAttribute("historiales", historialService.listarHistoriales());
        model.addAttribute("estados", estadoService.listarEstados());
        model.addAttribute("usuarios", usuarioService.listarUsuarios());

        System.out.println("hola");

        return "tecnico";
    }

}
