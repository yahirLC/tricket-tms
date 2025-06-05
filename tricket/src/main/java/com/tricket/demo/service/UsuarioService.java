package com.tricket.demo.service;

import com.tricket.demo.model.entity.UsuarioJPA;
import com.tricket.demo.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; // ¡Importa esta!
import org.springframework.security.crypto.password.PasswordEncoder; // Y esta interfaz

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Declara e inicializa directamente el PasswordEncoder
    // NO LO HAGAS @Autowired, porque no lo tendrás como Bean si no usas spring-boot-starter-security completo.
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public List<UsuarioJPA> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    public UsuarioJPA autenticar(String correo, String contrasenaPlana) {
        Optional<UsuarioJPA> usuarioOptional = usuarioRepository.findByCorreo(correo);

        System.out.println("Correo ingresado: " + correo);
        System.out.println("Contraseña ingresada (plana): " + contrasenaPlana);

        String hashed = passwordEncoder.encode("1234");
        System.out.println("ahi te vaHash: " + hashed);
        System.out.println("ahitevaMatch? " + passwordEncoder.matches("1234", hashed));

        if (usuarioOptional.isPresent()) {
            UsuarioJPA usuario = usuarioOptional.get();
            System.out.println("Contraseña almacenada (hasheada): " + usuario.getContrasena());
            System.out.println("contraseña verificacion " + passwordEncoder.encode(contrasenaPlana));

            if (passwordEncoder.matches(contrasenaPlana, usuario.getContrasena())) {
                System.out.println("✅ Contraseña válida");
                return usuario;
            } else {
                System.out.println("❌ Contraseña inválida");
            }
        } else {
            System.out.println("❌ Usuario no encontrado con ese correo");
        }

        return null;
    }

    public List<UsuarioJPA> obtenerUsuariosPorGrupo(int grupoId) {
        return usuarioRepository.findByGrupoId(grupoId);
    }

    // Método para guardar un usuario (hasheando la contraseña antes de guardar)
    public void guardar(UsuarioJPA usuario) {
        // Hashear la contraseña antes de guardarla en la base de datos
        String hashedPassword = passwordEncoder.encode(usuario.getContrasena());
        usuario.setContrasena(hashedPassword); // Asigna la contraseña hasheada al objeto
        usuarioRepository.save(usuario); // Guarda el usuario con la contraseña hasheada
    }
    
     public void actualizar(UsuarioJPA usuario) {
        // Hashear la contraseña antes de guardarla en la base de datos
  
        usuarioRepository.save(usuario); // Guarda el usuario con la contraseña hasheada
    }

    public Optional<UsuarioJPA> findUsuarioById(Integer userId) {
        return usuarioRepository.findById(userId);
    }

    public boolean asignarUsuarioAGrupo(Integer userId, Integer groupId) {
        Optional<UsuarioJPA> usuarioOptional = findUsuarioById(userId);
        if (usuarioOptional.isPresent()) {
            UsuarioJPA usuario = usuarioOptional.get();
            usuario.setGrupoId(groupId);
            usuarioRepository.save(usuario);
            return true;
        }
        return false;
    }

    public Optional<UsuarioJPA> buscarPorCorreo(String correo) {
        return usuarioRepository.findByCorreo(correo);
    }

    public Optional<UsuarioJPA> buscarPorUsuario(String username) {
        return usuarioRepository.findByUsuario(username);
    }
}
