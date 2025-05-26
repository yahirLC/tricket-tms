package com.tricket.demo.service;

import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<UsuarioJPA> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    public UsuarioJPA autenticar(String correo, String contrasena) {
        return usuarioRepository.findByCorreoAndContrasena(correo, contrasena);
    }
    
    public List<UsuarioJPA> obtenerUsuariosPorGrupo(int grupoId) {
        return (List<UsuarioJPA>) usuarioRepository.findByGrupoId(grupoId);
    }
    

}
