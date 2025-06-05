package com.tricket.demo.repository;

import com.tricket.demo.model.entity.HistorialJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HistorialRepository extends JpaRepository<HistorialJPA, Integer> {
    List<HistorialJPA> findByTicketIdOrderByFechaModificacionDesc(Integer ticketId);

    Optional<HistorialJPA> findTopByTicketIdOrderByFechaModificacionDesc(Integer ticketId);
}