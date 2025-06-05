package com.tricket.demo.service;

import com.tricket.demo.model.entity.GrupoJPA;
import com.tricket.demo.repository.GrupoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class GrupoService {

    @Autowired
    private GrupoRepository grupoRepository;

    public List<GrupoJPA> listarGrupos() {
        return grupoRepository.findAll();
    }

    public GrupoJPA crearGrupo(String nombre) {
        GrupoJPA grupo = new GrupoJPA();
        grupo.setNombre(nombre);
        return grupoRepository.save(grupo);
    }

    public GrupoJPA obtenerGrupoPorId(Integer id) {
        // Optional es una buena práctica para manejar la ausencia de un resultado
        Optional<GrupoJPA> grupoOptional = grupoRepository.findById(id);
        return grupoOptional.orElse(null); // Devuelve el grupo o null si no se encuentra
    }
}
