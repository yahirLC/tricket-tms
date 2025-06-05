package com.tricket.demo.service;

import com.tricket.demo.model.entity.SolicitudJPA;
import com.tricket.demo.model.entity.UsuarioJPA; // Asegúrate de importar UsuarioJPA
import com.tricket.demo.repository.SolicitudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SolicitudService {

    @Autowired
    private SolicitudRepository solicitudRepository;

    @Autowired
    private UsuarioService usuarioService; // ¡Inyección Correcta!

    public List<SolicitudJPA> listarSolicitudes(int idgroup) {
        // Modificado para obtener solicitudes por idgroup y donde idestado es NULL
        return solicitudRepository.findByIdgroupAndIdestadoIsNull(idgroup);
    }

    public boolean rechazarSolicitud(Integer iduser, Integer idgroup) {
        Optional<SolicitudJPA> solicitudOptional = solicitudRepository.findByIduserAndIdgroup(iduser, idgroup);
        if (solicitudOptional.isPresent()) {
            SolicitudJPA solicitud = solicitudOptional.get();
            solicitud.setIdestado(false); // Establece el estado a 'false' para rechazar
            solicitudRepository.save(solicitud); // Guarda los cambios en la base de datos
            return true;
        }
        return false; // La solicitud no fue encontrada
    }

    public boolean aceptarSolicitud(Integer iduser, Integer idgroup) {
        Optional<SolicitudJPA> solicitudOptional = solicitudRepository.findByIduserAndIdgroup(iduser, idgroup);
        if (solicitudOptional.isPresent()) {
            SolicitudJPA solicitud = solicitudOptional.get();
            solicitud.setIdestado(true); // Establece el estado a 'true' para aceptar
            solicitudRepository.save(solicitud); // Guarda los cambios en la base de datos

            // Llama al servicio de usuario para asignar el grupo
            boolean usuarioAsignado = usuarioService.asignarUsuarioAGrupo(iduser, idgroup);

            // Opcionalmente, puedes eliminar la solicitud después de aceptarla
            // solicitudRepository.delete(solicitud);
            return usuarioAsignado; // Retorna true si ambos pasos fueron exitosos
        }
        return false; // La solicitud no fue encontrada
    }

    public boolean crearSolicitud(Integer iduser, Integer idgroup) {
        // Opcional: Verificar si ya existe una solicitud pendiente del mismo usuario para el mismo grupo
        Optional<SolicitudJPA> existingSolicitud = solicitudRepository.findByIduserAndIdgroup(iduser, idgroup);
        if (existingSolicitud.isPresent()) {
            // Ya existe una solicitud. Puedes decidir si la actualizas, la ignoras o la rechazas.
            // Por ahora, simplemente retornamos false si ya existe para evitar duplicados.
            return false;
        }

        SolicitudJPA nuevaSolicitud = new SolicitudJPA();
        nuevaSolicitud.setIduser(iduser);
        nuevaSolicitud.setIdgroup(idgroup);
        nuevaSolicitud.setIdestado(null); // O false, para indicar "pendiente" o "no aceptada"
        // Dependerá de cómo manejes los estados en tu DB y lógica.
        // Si usas NULL para pendiente y TRUE/FALSE para aceptado/rechazado.

        solicitudRepository.save(nuevaSolicitud);
        return true;
    }
}
