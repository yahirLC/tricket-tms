package com.tricket.demo.service;

import com.tricket.demo.model.entity.EstadoJPA;
import com.tricket.demo.repository.CategoriaRepository;
import com.tricket.demo.repository.EstadoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class EstadoService {

    @Autowired
    private EstadoRepository estadoRepository;


    public List<EstadoJPA> listarEstados() {
        return estadoRepository.findAll();
    }
    
    
    
}
    