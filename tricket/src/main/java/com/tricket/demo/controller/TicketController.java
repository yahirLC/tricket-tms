package com.tricket.demo.controller;

import com.tricket.demo.model.entity.CategoriaJPA;
import com.tricket.demo.model.entity.EstadoJPA;
import com.tricket.demo.model.entity.HistorialJPA;
import com.tricket.demo.model.entity.NotificacionJPA;
import com.tricket.demo.model.entity.TicketJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.CategoriaService;
import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.HistorialService;
import com.tricket.demo.service.NotificacionService;
import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService;
import jakarta.servlet.http.HttpServletRequest;
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
import java.util.Optional;

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

    @Autowired
    private HistorialService historialService;

    @Autowired
    private NotificacionService notificacionService;

    @GetMapping("/ticket")
    public String mostrarFormularioTicket(@RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "modo", required = false) String modo,
            Model model, HttpSession session) {
        System.out.println("Modo recibido (sin trim): '" + modo + "'");
        String modoTrimmed = (modo != null) ? modo.trim() : "";
        System.out.println("Modo recibido (con trim): '" + modoTrimmed + "'");

        
        List<EstadoJPA> listaEstados = estadoService.listarEstados();
        List<CategoriaJPA> listaCategorias = categoriaService.listarCategorias();
        model.addAttribute("listaEstados", listaEstados);
        model.addAttribute("listaCategorias", listaCategorias);

        List<HistorialJPA> listaHistorial = historialService.obtenerHistorialPorTicketId(id);

        model.addAttribute("listaHistorial", listaHistorial);

        UsuarioJPA usuario = (UsuarioJPA) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            
            return "redirect:/login"; 
        }
        int grupoId = usuario.getGrupoId();
        List<UsuarioJPA> integrantes = usuarioService.obtenerUsuariosPorGrupo(grupoId);
        model.addAttribute("integrantes", integrantes);

        if (id != null) {
            TicketJPA ticket = ticketService.obtenerTicketPorId(id);
            System.out.println("Ticket obtenido para ID " + id + ": " + ticket);

            if (ticket != null) {
                model.addAttribute("ticket", ticket);

                if ("lectura".equals(modoTrimmed)) {
                    model.addAttribute("modo", "lectura");
                    model.addAttribute("tituloPagina", "Detalles del Ticket");
                    System.out.println("Modo en controlador: lectura, Titulo: Detalles del Ticket");
                } else if ("edicion".equals(modoTrimmed)) {
                    model.addAttribute("modo", "edicion");
                    model.addAttribute("tituloPagina", "Editar Ticket");
                    System.out.println("Modo en controlador: edicion, Titulo: Editar Ticket");
                } else {
                    // Si hay un ID pero el modo no es explícitamente lectura o edición,
                    // podemos considerar lectura como predeterminado o un error.
                    model.addAttribute("modo", "lectura");
                    model.addAttribute("tituloPagina", "Detalles del Ticket");
                    System.out.println("Modo en controlador: lectura (default con ID), Titulo: Detalles del Ticket");
                }
                return "ticket";
            } else {
                return "error"; // O una página de ticket no encontrado
            }
        } else if ("inserccion".equals(modoTrimmed)) {
            model.addAttribute("modo", "inserccion");
            model.addAttribute("tituloPagina", "Nuevo Ticket");
            model.addAttribute("ticket", new TicketJPA());
            System.out.println("Modo en controlador: inserccion, Titulo: Nuevo Ticket");
            return "ticket";
        } else {
            // Si no hay ID y el modo no es inserccion, por defecto mostramos el formulario para crear uno nuevo.
            model.addAttribute("modo", "inserccion");
            model.addAttribute("tituloPagina", "Nuevo Ticket");
            model.addAttribute("ticket", new TicketJPA());
            System.out.println("Modo en controlador: inserccion (default), Titulo: Nuevo Ticket");
            return "ticket";
        }
    }

    @PostMapping("/guardarTicket") // Este método manejará tanto la creación como la actualización
    public String guardarOActualizarTicket(@ModelAttribute TicketJPA ticket,
            @RequestParam(value = "comentario", required = false) String comentario,
            HttpSession session) {
        UsuarioJPA usuarioLogueado = (UsuarioJPA) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            System.err.println("No se encontró información del usuario en la sesión.");
            return "redirect:/login"; // O a una página de error
        }

        // Si el ticket no tiene ID, es un ticket nuevo
        if (ticket.getId() == null) {
            ticket.setUsuario_id(usuarioLogueado.getId());
            ticket.setFecha_creacion(new Timestamp(System.currentTimeMillis()));
            ticket.setGrupoId(usuarioLogueado.getGrupoId());
            // Para un nuevo ticket, puedes establecer un estado inicial por defecto si no viene ya
            if (ticket.getEstado_id() == null) {
                ticket.setEstado_id(1); // Por ejemplo, estado 1 = Abierto
            }
            ticketService.guardarTicket(ticket); // Guarda el nuevo ticket primero
            
             ticketService.guardarTicket(ticket);
                NotificacionJPA noti = new NotificacionJPA();
                noti.setAccion("Asignaccion de ticket");
                noti.setDescripcion("Se te ha asignado un nuevo ticket con NO" + ticket.getNumero());
                noti.setUsuarioId(ticket.getAsignadoA());
                
                notificacionService.guardarNotificacion(noti);

            
        } else {
            // Es una actualización, recuperamos el ticket existente para preservar campos no editables si es necesario
            TicketJPA existingTicket = ticketService.obtenerTicketPorId(ticket.getId());
            if (existingTicket != null) {
                // Actualizar solo los campos que se permiten editar desde el formulario
                existingTicket.setTitulo(ticket.getTitulo());
                existingTicket.setNumero(ticket.getNumero());
                existingTicket.setEstado_id(ticket.getEstado_id());
                existingTicket.setCategoria_id(ticket.getCategoria_id());
                existingTicket.setSeveridad(ticket.getSeveridad());
                existingTicket.setAsignadoA(ticket.getAsignadoA());
                existingTicket.setDescripcion(ticket.getDescripcion());
                // No actualizamos fecha_creacion, usuario_id, o grupoId ya que son del ticket original
                ticket = existingTicket; // Usamos el ticket existente con los campos actualizados

                // Primero guarda el ticket para que el trigger genere el historial
                ticketService.guardarTicket(ticket);
                NotificacionJPA noti = new NotificacionJPA();
                noti.setAccion("Actualizacion de ticket");
                noti.setDescripcion("Se ha actualizado al ticket con el id NO" + ticket.getNumero());
                noti.setUsuarioId(ticket.getAsignadoA());
                
                notificacionService.guardarNotificacion(noti);
                
                // Ahora, busca el último historial generado por el trigger para este ticket
                Optional<HistorialJPA> ultimoHistorialOpt = historialService.obtenerUltimoHistorialPorTicketId(ticket.getId());

                if (ultimoHistorialOpt.isPresent()) {
                    HistorialJPA ultimoHistorial = ultimoHistorialOpt.get();
                    // Actualiza el comentario y el usuario que modificó en ese registro de historial
                    ultimoHistorial.setComentario(comentario);
                    ultimoHistorial.setUsuarioQueModifico(usuarioLogueado.getId());
                    historialService.guardarHistorial(ultimoHistorial); // Guarda la actualización del historial
                    System.out.println("Historial actualizado con comentario y usuario para ticket: " + ticket.getId());
                } else {
                    System.err.println("No se encontró ningún historial para el ticket " + ticket.getId() + " después de la actualización.");
                    // Esto podría indicar un problema con el trigger o la temporización
                }

            } else {
                System.err.println("Intento de actualizar un ticket que no existe con ID: " + ticket.getId());
                return "error"; // O redirigir a una página de error
            }
        }

        // El ticketService.guardarTicket(ticket) ya se llamó dentro de los bloques if/else
        // si se trata de una actualización o creación de ticket
        if (usuarioLogueado.getRol().equals("admin")) {
            return "redirect:/admin";
        } else {
            return "redirect:/cliente";
        }

        // Redirige a la página de administración después de guardar/actualizar
    }

    @PostMapping("/ticket/cerrar")
    public String cerrarTicket(@RequestParam("id") Integer ticketId,
            HttpServletRequest request) {
        TicketJPA ticket = ticketService.obtenerTicketPorId(ticketId);
        if (ticket != null) {
            ticket.setEstado_id(3); // Estado 3 = Cerrado
            ticket.setFecha_cierre(new Timestamp(System.currentTimeMillis())); // Marca de tiempo actual
            ticketService.guardarTicket(ticket);
        }

        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/admin");
    }
}
