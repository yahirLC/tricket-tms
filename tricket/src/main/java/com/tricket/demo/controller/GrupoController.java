package com.tricket.demo.controller;

import com.tricket.demo.service.GrupoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GrupoController {

    @Autowired
    private GrupoService grupoService;

    @GetMapping("/grupo")
    public String listar(Model model) {
        model.addAttribute("grupos", grupoService.listarGrupos());
        return "grupo";
    }

  
}
