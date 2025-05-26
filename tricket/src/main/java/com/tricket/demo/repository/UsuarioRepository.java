package com.tricket.demo.repository;

import com.tricket.demo.model.entity.UsuarioJPA;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<UsuarioJPA, Integer> {

    UsuarioJPA findByCorreoAndContrasena(String correo, String contrasena);
    List<UsuarioJPA> findByGrupoId(int grupoId);


}
