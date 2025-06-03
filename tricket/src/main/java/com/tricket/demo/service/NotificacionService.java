package com.tricket.demo.service;

import com.tricket.demo.model.entity.NotificacionJPA;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import com.tricket.demo.repository.NotificacionRepository;

@Service
public class NotificacionService {

    @Autowired
    private NotificacionRepository notificacionRepository;

    public List<NotificacionJPA> listarNotificaciones() {
        return notificacionRepository.findAllByOrderByIdDesc(); // o el campo que elijas
    }

}
