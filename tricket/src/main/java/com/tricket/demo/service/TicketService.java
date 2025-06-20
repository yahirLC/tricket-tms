package com.tricket.demo.service;

import com.tricket.demo.model.entity.TicketJPA;
import com.tricket.demo.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    public List<TicketJPA> listarTickets(Integer idgrupo) {
        return ticketRepository.findByGrupoId(idgrupo);


    }

    public List<TicketJPA> listarTickets() {
        return ticketRepository.findAll();
    }

    public List<TicketJPA> listarTicketsPorAsignado(Integer idAsignado) {
        return ticketRepository.findByAsignadoA(idAsignado);
    }

    public long contarTickets() {
        return ticketRepository.count();
    }

    public long contarMisTickets(Integer idAsignado) {
        return ticketRepository.findByAsignadoA(idAsignado).size();
    }

    public long contarTicketsNoCerrados(Integer idgrupo) {
        return ticketRepository.findByGrupoId(idgrupo).stream()
                .filter(ticket -> ticket.getEstado_id() != 3)
                .count();
    }

    public long contarMisTicketsNoCerrados(Integer idAsignado) {
        return ticketRepository.findByAsignadoA(idAsignado).stream()
                .filter(ticket -> ticket.getEstado_id() != 3)
                .count();
    }

    public TicketJPA obtenerTicketPorId(Integer id) {
        Optional<TicketJPA> ticketOptional = ticketRepository.findById(id);
        return ticketOptional.orElse(null);
    }

    public void guardarTicket(TicketJPA ticket) {
        ticketRepository.save(ticket);
    }
}
