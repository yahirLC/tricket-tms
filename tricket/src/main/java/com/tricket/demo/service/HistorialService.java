package com.tricket.demo.service;

import com.tricket.demo.model.entity.HistorialJPA;
import com.tricket.demo.repository.HistorialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class HistorialService {

    @Autowired
    private HistorialRepository historialRepository;

    public HistorialJPA guardarHistorial(HistorialJPA historial) {
        return historialRepository.save(historial);
    }

    public List<HistorialJPA> obtenerHistorialPorTicketId(Integer ticketId) {
        return historialRepository.findByTicketIdOrderByFechaModificacionDesc(ticketId);
    }

    // Nuevo método
    public Optional<HistorialJPA> obtenerUltimoHistorialPorTicketId(Integer ticketId) {
        return historialRepository.findTopByTicketIdOrderByFechaModificacionDesc(ticketId);
    }
}