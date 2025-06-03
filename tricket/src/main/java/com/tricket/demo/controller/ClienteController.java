package com.tricket.demo.controller;

import com.tricket.demo.model.entity.CategoriaJPA;
import com.tricket.demo.model.entity.EstadoJPA;
import com.tricket.demo.model.entity.GrupoJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.CategoriaService;
import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.GrupoService;

import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ClienteController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EstadoService estadoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private GrupoService grupoService;

    @GetMapping("/cliente")
    public String mostrarCliente(HttpSession session, Model model) {
        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"cliente".equals(usuario.getRol())) {
            return "redirect:/login";
        }

        if (usuario.getGrupoId() == null) {
            return "redirect:/nuevo";
        }

        long totalMisTickets = ticketService.contarMisTickets(usuario.getId());

        model.addAttribute("totalMisTickets", totalMisTickets);
        model.addAttribute("misTickets", ticketService.listarTicketsPorAsignado(usuario.getId()));
        model.addAttribute("misticketsNoCerrados", ticketService.contarMisTicketsNoCerrados(usuario.getId()));

        int grupoId = usuario.getGrupoId();
        List<UsuarioJPA> integrantes = usuarioService.obtenerUsuariosPorGrupo(grupoId);

        model.addAttribute("integrantes", integrantes);
        model.addAttribute("totalIntegrantes", integrantes.size());

        List<EstadoJPA> listaEstados = estadoService.listarEstados();
        List<CategoriaJPA> listaCategorias = categoriaService.listarCategorias();

        model.addAttribute("listaEstados", listaEstados);
        model.addAttribute("listaCategorias", listaCategorias);

        return "cliente";
    }

    @GetMapping("/nuevo")
    public String mostrarNuevo(HttpSession session, Model model) {
        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"cliente".equals(usuario.getRol())) {
            return "redirect:/login";
        }
        return "nuevo";
    }

    @PostMapping("/crearGrupo")
    public String crearGrupo(HttpServletRequest request, HttpSession session) {
        String nombreGrupo = request.getParameter("nombreGrupo");

        GrupoJPA nuevoGrupo = grupoService.crearGrupo(nombreGrupo);

        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuario != null) {

            usuario.setGrupoId(nuevoGrupo.getId());

            usuario.setRol("admin");

            usuarioService.guardar(usuario);

            session.setAttribute("usuarioLogueado", usuario);

        }

        return "redirect:/admin";
    }

}
