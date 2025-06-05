package com.tricket.demo.controller;

import com.tricket.demo.model.entity.HistorialJPA;
import com.tricket.demo.model.entity.TicketJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.service.HistorialService;
import com.tricket.demo.service.TicketService;
import com.tricket.demo.service.UsuarioService; // Para obtener el nombre del usuario que modificó
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HistorialController {

    @Autowired
    private HistorialService historialService;

    @Autowired
    private TicketService ticketService; // Para obtener detalles del ticket original

    @Autowired
    private UsuarioService usuarioService; // Para obtener nombres de usuarios


}