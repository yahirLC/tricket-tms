package com.tricket.demo.service;

import com.tricket.demo.model.entity.GrupoJPA;
import com.tricket.demo.repository.GrupoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class GrupoService {

    @Autowired
    private GrupoRepository grupoRepository;


    public List<GrupoJPA> listarGrupos() {
        return grupoRepository.findAll();
    }
    
    
    
}
    