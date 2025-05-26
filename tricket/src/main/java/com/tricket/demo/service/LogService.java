package com.tricket.demo.service;

import com.tricket.demo.model.entity.LogJPA;
import com.tricket.demo.repository.LogRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class LogService {

    @Autowired
    private LogRepository logRepository;


    public List<LogJPA> listarLogs() {
        return logRepository.findAll();
    }
    
    
    
}
    