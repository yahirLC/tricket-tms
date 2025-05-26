package com.tricket.demo.controller;

import com.tricket.demo.service.EstadoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EstadoController {

    @Autowired
 
    private EstadoService estadoService;

    @GetMapping("/estado")
    public String listar(Model model) {
        model.addAttribute("estados", estadoService.listarEstados());
        return "estado";
    }

}
