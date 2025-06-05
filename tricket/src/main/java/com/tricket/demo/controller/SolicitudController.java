package com.tricket.demo.controller;

import com.tricket.demo.service.EstadoService;
import com.tricket.demo.service.SolicitudService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class SolicitudController {

    @Autowired

    private SolicitudService solicitudService;

    @PostMapping("/rechazarsolicitud")
    public String rechazarSolicitud(@RequestParam("iduser") Integer iduser,
            @RequestParam("idgroup") Integer idgroup,
            RedirectAttributes redirectAttributes) {

        // Puedes agregar validaciones similares a las de aceptar solicitud aquí.
        boolean rejected = solicitudService.rechazarSolicitud(iduser, idgroup);

        if (rejected) {
        
// Puedes agregar validaciones similares a las de aceptar solicitud aquí.
            redirectAttributes.addFlashAttribute("mensaje", "Solicitud rechazada exitosamente.");
        } else {
            redirectAttributes.addFlashAttribute("mensaje", "Error al rechazar la solicitud o no encontrada.");
        }
        return "redirect:/admin"; // Redirige de vuelta al dashboard del administrador
    }
    
     @PostMapping("/aceptarsolicitud")
    public String aceptarSolicitud(@RequestParam("iduser") Integer iduser,
                                   @RequestParam("idgroup") Integer idgroup,
                                   RedirectAttributes redirectAttributes) {

        boolean accepted = solicitudService.aceptarSolicitud(iduser, idgroup);

        if (accepted) {
            redirectAttributes.addFlashAttribute("mensaje", "Solicitud aceptada y usuario asignado al grupo exitosamente.");
        } else {
            redirectAttributes.addFlashAttribute("mensaje", "Error al aceptar la solicitud o no encontrada. O el usuario no pudo ser asignado al grupo.");
        }
        return "redirect:/admin"; // Redirige de vuelta al dashboard del administrador
    }

}
