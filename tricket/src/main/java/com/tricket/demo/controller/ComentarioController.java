package com.tricket.demo.controller;

import com.tricket.demo.service.ComentarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ComentarioController {

    @Autowired
    private ComentarioService comentarioService;

    @GetMapping("/comentario")
    public String listar(Model model) {
        model.addAttribute("comentarios", comentarioService.listarComentarios());
        return "comentario";
    }

}
