package com.tricket.demo.repository;

import com.tricket.demo.model.entity.TicketJPA;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketRepository extends JpaRepository<TicketJPA, Integer> {
    
    long count();
    
     List<TicketJPA> findByAsignadoA(Integer asignadoA);
    
}