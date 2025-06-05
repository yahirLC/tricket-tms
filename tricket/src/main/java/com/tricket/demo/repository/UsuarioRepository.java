package com.tricket.demo.repository;

import com.tricket.demo.model.entity.UsuarioJPA;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<UsuarioJPA, Integer> {

   

    List<UsuarioJPA> findByGrupoId(int grupoId);

    Optional<UsuarioJPA> findById(Long receptorIdLong);

    Optional<UsuarioJPA> findByCorreo(String correo); // Lo necesitarás para buscar el usuario por correo

    Optional<UsuarioJPA> findByUsuario(String usuario);

}
