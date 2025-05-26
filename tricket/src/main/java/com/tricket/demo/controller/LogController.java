package com.tricket.demo.controller;

import com.tricket.demo.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogController {

    @Autowired
    private LogService logService;

    @GetMapping("/log")
    public String listar(Model model) {
        model.addAttribute("logs", logService.listarLogs());
        return "log";
    }

  
}
