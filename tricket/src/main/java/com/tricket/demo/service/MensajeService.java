package com.tricket.demo.service;

import com.tricket.demo.model.entity.MensajeJPA;
import com.tricket.demo.model.entity.UsuarioJPA; // Asegúrate que sea la entidad correcta
import com.tricket.demo.repository.MensajeRepository;
import com.tricket.demo.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Importa esta anotación

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional; // Importa Optional

@Service
public class MensajeService {

    @Autowired
    private MensajeRepository mensajeRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Transactional // Agrega @Transactional para asegurar que las operaciones de DB se manejen correctamente
    public MensajeJPA guardarMensaje(String emisorId, String receptorId, String contenido) {
        // Los IDs son BIGINT en tu DB, por lo que Long es el tipo adecuado en Java
        Long emisorIdLong = Long.valueOf(emisorId);
        Long receptorIdLong = Long.valueOf(receptorId);

        // **Paso clave: Obtener los objetos UsuarioJPA completos**
        Optional<UsuarioJPA> emisorOptional = usuarioRepository.findById(emisorIdLong);
        Optional<UsuarioJPA> receptorOptional = usuarioRepository.findById(receptorIdLong);

        // Manejar el caso de que los usuarios no existan (importante para evitar NullPointerException)
        if (emisorOptional.isEmpty() || receptorOptional.isEmpty()) {
            // Podrías lanzar una excepción personalizada, registrar un error, etc.
            // Por ahora, lanzaremos una RuntimeException.
            throw new RuntimeException("Emisor o Receptor no encontrado.");
        }

        UsuarioJPA emisor = emisorOptional.get();
        UsuarioJPA receptor = receptorOptional.get();

        MensajeJPA mensaje = new MensajeJPA();
        mensaje.setRemitente(emisor); // Ahora se guarda el objeto UsuarioJPA completo
        mensaje.setDestinatario(receptor); // Ahora se guarda el objeto UsuarioJPA completo
        mensaje.setContenido(contenido);
        mensaje.setFechaEnvio(LocalDateTime.now());
        mensaje.setLeido(false);
        return mensajeRepository.save(mensaje);
    }

    @Transactional(readOnly = true) // readOnly=true es una buena práctica para métodos de solo lectura
    public List<MensajeJPA> obtenerConversacion(String usuario1Id, String usuario2Id) {
        Long usuario1IdLong = Long.valueOf(usuario1Id);
        Long usuario2IdLong = Long.valueOf(usuario2Id);

        // **Paso clave: Obtener los objetos UsuarioJPA para la consulta del repositorio**
        Optional<UsuarioJPA> user1Optional = usuarioRepository.findById(usuario1IdLong);
        Optional<UsuarioJPA> user2Optional = usuarioRepository.findById(usuario2IdLong);

        if (user1Optional.isEmpty() || user2Optional.isEmpty()) {
            throw new RuntimeException("Uno de los usuarios no encontrado para la conversación.");
        }

        UsuarioJPA usuario1 = user1Optional.get();
        UsuarioJPA usuario2 = user2Optional.get();

        // Tu método de repositorio debe ser adaptado para recibir objetos UsuarioJPA
        // En lugar de findByEmisorNombreAndReceptorNombreOrReceptorNombreAndEmisorNombreOrderByFechaEnvio
        // Ahora debería ser algo como:
        // findByRemitenteAndDestinatarioOrDestinatarioAndRemitenteOrderByFechaEnvio
        return mensajeRepository.findByRemitenteAndDestinatarioOrDestinatarioAndRemitenteOrderByFechaEnvio(
                usuario1, usuario2,
                usuario2, usuario1
        );
    }

    @Transactional // También se necesita @Transactional para las actualizaciones
    public void marcarComoLeido(Long mensajeId) {
        mensajeRepository.findById(mensajeId).ifPresent(mensaje -> {
            mensaje.setLeido(true);
            mensajeRepository.save(mensaje);
        });
    }
}