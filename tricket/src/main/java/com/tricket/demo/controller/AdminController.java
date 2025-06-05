package com.tricket.demo.controller;

import com.tricket.demo.model.entity.CategoriaJPA;
import com.tricket.demo.model.entity.EstadoJPA;
import com.tricket.demo.model.entity.NotificacionJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.CategoriaService;
import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.NotificacionService;
import com.tricket.demo.service.SolicitudService;

import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private EstadoService estadoService;
    
    @Autowired
    private CategoriaService categoriaService;
    
    @Autowired
    private NotificacionService notificacionService;
    
    @Autowired
    private SolicitudService solicitudService;
    

    @GetMapping("/admin")
    public String mostrarAdmin(HttpSession session, Model model) {
        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"admin".equals(usuario.getRol())) {

            return "redirect:/login";
        }

        long totalMisTickets = ticketService.contarMisTickets(usuario.getId());
        
        model.addAttribute("totalTickets", ticketService.listarTickets(usuario.getGrupoId()).size());
        model.addAttribute("tickets", ticketService.listarTickets(usuario.getGrupoId()));
        model.addAttribute("ticketsNoCerrados", ticketService.contarTicketsNoCerrados(usuario.getGrupoId()));
        
        model.addAttribute("totalMisTickets", totalMisTickets);
        model.addAttribute("misTickets", ticketService.listarTicketsPorAsignado(usuario.getId()));
        model.addAttribute("misticketsNoCerrados", ticketService.contarMisTicketsNoCerrados(usuario.getId()));
        

        int grupoId = usuario.getGrupoId();
        List<UsuarioJPA> integrantes = usuarioService.obtenerUsuariosPorGrupo(grupoId);
        
        long totalIntegrantes = integrantes.size();

        model.addAttribute("integrantes", integrantes);
        model.addAttribute("totalIntegrantes",totalIntegrantes);

        List<EstadoJPA> listaEstados = estadoService.listarEstados();
        List<CategoriaJPA> listaCategorias = categoriaService.listarCategorias();

        model.addAttribute("listaEstados", listaEstados);
        model.addAttribute("listaCategorias", listaCategorias);
        
        List<NotificacionJPA> listaNotificaciones = notificacionService.listarNotificacionesPorUsuario(usuario.getId());
        
        model.addAttribute("listaNotificaciones",listaNotificaciones);
        model.addAttribute("countNotificaciones",listaNotificaciones.size());
        
        model.addAttribute("listaSolicitudes",solicitudService.listarSolicitudes(grupoId));
        model.addAttribute("countSolicitudes",solicitudService.listarSolicitudes(grupoId).size());

        return "admin";
    }
    
     @GetMapping("/")
    public String redirectToLogin() {
        return "redirect:/login";
    }

}
