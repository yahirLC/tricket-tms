package com.tricket.demo.repository;

import com.tricket.demo.model.entity.NotificacionJPA;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificacionRepository extends JpaRepository<NotificacionJPA, Integer> {

    List<NotificacionJPA> findAllByOrderByIdDesc();

    List<NotificacionJPA> findByUsuarioIdOrderByIdDesc(Integer usuarioId);
    
}
