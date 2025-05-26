package com.tricket.demo.controller;

import com.tricket.demo.service.HistorialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HistorialController {
    
    @Autowired
    private HistorialService historialService;

    @GetMapping("/historial")
    public String listar(Model model) {
        model.addAttribute("historiales", historialService.listarHistoriales());
        return "historial";
    }

  
}
