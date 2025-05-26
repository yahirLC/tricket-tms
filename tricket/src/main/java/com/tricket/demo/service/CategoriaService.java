package com.tricket.demo.service;


import com.tricket.demo.model.entity.CategoriaJPA;
import com.tricket.demo.repository.CategoriaRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;


    public List<CategoriaJPA> listarCategorias() {
        return categoriaRepository.findAll();
    }
    
    
    
}
    