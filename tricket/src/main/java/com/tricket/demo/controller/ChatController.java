/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 
package com.tricket.demo.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private MensajeService mensajeService;

    @GetMapping("/conversacion")
    @ResponseBody
    public List<Mensaje> obtenerConversacion(@RequestParam Long emisorId, @RequestParam Long receptorId) {
        return mensajeService.obtenerConversacion(emisorId, receptorId);
    }

    @PostMapping("/enviar")
    @ResponseBody
    public ResponseEntity<?> enviarMensaje(@RequestParam Long emisorId, @RequestParam Long receptorId, @RequestParam String contenido) {
        mensajeService.enviarMensaje(emisorId, receptorId, contenido);
        return ResponseEntity.ok().build();
    }
}
*/