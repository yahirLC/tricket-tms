package com.tricket.demo.service;


import com.tricket.demo.model.entity.ComentarioJPA;
import com.tricket.demo.repository.ComentarioRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ComentarioService {

    @Autowired
    private ComentarioRepository comentarioRepository;


    public List<ComentarioJPA> listarComentarios() {
        return comentarioRepository.findAll();
    }
    
    
    
}
    