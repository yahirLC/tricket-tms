package com.tricket.demo.controller;

import com.tricket.demo.model.entity.CategoriaJPA;
import com.tricket.demo.model.entity.EstadoJPA;
import com.tricket.demo.model.entity.TicketJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.CategoriaService;
import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.util.List;

@Controller
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private EstadoService estadoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/ticket")
    public String mostrarFormularioTicket(@RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "modo", required = false) String modo,
            Model model, HttpSession session) {
        System.out.println("Modo recibido (sin trim): '" + modo + "'");
        String modoTrimmed = (modo != null) ? modo.trim() : "";
        System.out.println("Modo recibido (con trim): '" + modoTrimmed + "'");

        if (id != null) {
            TicketJPA ticket = ticketService.obtenerTicketPorId(id);
            System.out.println("Ticket obtenido para ID " + id + ": " + ticket);

            if (ticket != null) {
                model.addAttribute("ticket", ticket);
                model.addAttribute("modo", "lectura");
                model.addAttribute("tituloPagina", "Detalles del Ticket");

                System.out.println("Modo en controlador: lectura, Titulo: Detalles del Ticket");

                List<EstadoJPA> listaEstados = estadoService.listarEstados();
                List<CategoriaJPA> listaCategorias = categoriaService.listarCategorias();

                model.addAttribute("listaEstados", listaEstados);
                model.addAttribute("listaCategorias", listaCategorias);

                UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

                int grupoId = usuario.getGrupoId();
                List<UsuarioJPA> integrantes = usuarioService.obtenerUsuariosPorGrupo(grupoId);

                model.addAttribute("integrantes", integrantes);

                return "ticket";
            } else {
                return "error";
            }
        } else if ("inserccion".equals(modoTrimmed)) {

            List<EstadoJPA> listaEstados = estadoService.listarEstados();
            List<CategoriaJPA> listaCategorias = categoriaService.listarCategorias();

            model.addAttribute("listaEstados", listaEstados);
            model.addAttribute("listaCategorias", listaCategorias);

            model.addAttribute("modo", "inserccion");
            model.addAttribute("tituloPagina", "Nuevo Ticket");
            model.addAttribute("ticket", new TicketJPA());
            System.out.println("Modo en controlador: inserccion, Titulo: Nuevo Ticket");

            UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");

            int grupoId = usuario.getGrupoId();
            List<UsuarioJPA> integrantes = usuarioService.obtenerUsuariosPorGrupo(grupoId);

            model.addAttribute("integrantes", integrantes);

            return "ticket";
        } else {
            model.addAttribute("modo", "inserccion"); // Default to inserccion
            model.addAttribute("tituloPagina", "Nuevo Ticket");
            model.addAttribute("ticket", new TicketJPA());
            System.out.println("Modo en controlador: inserccion (default), Titulo: Nuevo Ticket");
            return "ticket";
        }
    }

    @PostMapping("/guardarNuevoTicket")
    public String guardarNuevoTicket(@ModelAttribute TicketJPA ticket, HttpSession session) {
        UsuarioJPA usuarioLogueado = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado != null) {
            ticket.setUsuario_id(usuarioLogueado.getId());
        } else {
            // Manejar el caso en que no hay usuario en la sesión (debería ser raro)
            System.err.println("No se encontró información del usuario en la sesión.");
            // Considera lanzar una excepción o redirigir a una página de error.
        }

        if (ticket.getFecha_creacion() == null) {
            ticket.setFecha_creacion(new Timestamp(System.currentTimeMillis()));
        }
        ticketService.guardarTicket(ticket);
        return "redirect:/admin"; // Redirige a la página de administración después de guardar
    }
}
