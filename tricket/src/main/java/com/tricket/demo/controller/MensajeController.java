package com.tricket.demo.controller;

import com.tricket.demo.model.entity.MensajeJPA;
import com.tricket.demo.model.entity.NotificacionJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.MensajeService;
import com.tricket.demo.service.NotificacionService;
import com.tricket.demo.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/chat")
public class MensajeController {

    @Autowired
    private MensajeService mensajeService;

    @Autowired
    private NotificacionService notificacionService;

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/enviar")
    public void enviarMensaje(@RequestParam String emisor, @RequestParam String receptor, @RequestParam String contenido) {
        mensajeService.guardarMensaje(emisor, receptor, contenido);

        NotificacionJPA noti = new NotificacionJPA();
        noti.setAccion("Nuevo Mensaje");
        noti.setDescripcion("Has recibido un nuevo mensaje del usuario con id " + receptor);
        noti.setUsuarioId(Integer.valueOf(receptor));
        
        notificacionService.guardarNotificacion(noti);
    }

    @GetMapping("/conversacion")
    public List<MensajeJPA> obtenerConversacion(@RequestParam String usuario1, @RequestParam String usuario2) {
        return mensajeService.obtenerConversacion(usuario1, usuario2);
    }
}
