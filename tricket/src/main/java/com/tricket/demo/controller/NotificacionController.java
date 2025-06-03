package com.tricket.demo.controller;

import com.tricket.demo.service.NotificacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NotificacionController {

    @Autowired
    private NotificacionService logService;

    @GetMapping("/notificaciones")
    public String listar(Model model) {
        model.addAttribute("logs", logService.listarNotificaciones());
        return "log";
    }

  
}
