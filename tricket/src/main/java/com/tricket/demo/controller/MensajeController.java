package com.tricket.demo.controller;

import com.tricket.demo.model.entity.MensajeJPA;
import com.tricket.demo.service.MensajeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/chat")
public class MensajeController {

    @Autowired
    private MensajeService mensajeService;

    @PostMapping("/enviar")
    public void enviarMensaje(@RequestParam String emisor, @RequestParam String receptor, @RequestParam String contenido) {
        mensajeService.guardarMensaje(emisor, receptor, contenido);
    }

    @GetMapping("/conversacion")
    public List<MensajeJPA> obtenerConversacion(@RequestParam String usuario1, @RequestParam String usuario2) {
        return mensajeService.obtenerConversacion(usuario1, usuario2);
    }
}
