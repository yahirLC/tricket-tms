package com.tricket.demo.service;


import com.tricket.demo.model.entity.HistorialJPA;
import com.tricket.demo.repository.HistorialRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class HistorialService {

    @Autowired
    private HistorialRepository historialRepository;


    public List<HistorialJPA> listarHistoriales() {
        return historialRepository.findAll();
    }
    
    
    
}
    