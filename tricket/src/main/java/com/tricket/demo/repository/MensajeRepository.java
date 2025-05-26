package com.tricket.demo.repository;

import com.tricket.demo.model.entity.MensajeJPA;
import com.tricket.demo.model.entity.UsuarioJPA;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MensajeRepository extends JpaRepository<MensajeJPA, Long> {

    @Query("SELECT m FROM MensajeJPA m WHERE (m.remitente = :remitente1 AND m.destinatario = :destinatario1) OR (m.remitente = :remitente2 AND m.destinatario = :destinatario2) ORDER BY m.fechaEnvio")
    List<MensajeJPA> findByRemitenteAndDestinatarioOrDestinatarioAndRemitenteOrderByFechaEnvio(
            @Param("remitente1") UsuarioJPA remitente1,
            @Param("destinatario1") UsuarioJPA destinatario1,
            @Param("remitente2") UsuarioJPA remitente2,
            @Param("destinatario2") UsuarioJPA destinatario2
    );

}
