package com.tricket.demo.controller;

import com.tricket.demo.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/categoria")
    public String listar(Model model) {
        model.addAttribute("categorias", categoriaService.listarCategorias());
        return "categoria";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "Estoy vivo";
    }
}
