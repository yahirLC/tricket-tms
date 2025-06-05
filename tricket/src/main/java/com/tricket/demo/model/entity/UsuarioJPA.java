package com.tricket.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.sql.Timestamp;

@Entity
@Table(name = "usuario")
public class UsuarioJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "nombre", length = 50, nullable = false)
    private String nombre;

    @Column(name = "correo", length = 100, nullable = false)
    private String correo;

    // ...
    @Column(name = "contrasena", length = 60, nullable = false) // <--- ¡Asegúrate de que tenga al menos length=60!
    private String contrasena;
// ...

    @Column(name = "rol", nullable = false)
    private String rol;

    @Column(name = "grupo_id")
    private Integer grupoId;

    @Column(name = "fecha_registro")
    private Timestamp fecha_registro;

    @Column(name = "usuario", length = 16, nullable = false)
    private String usuario;

    @Column(name = "apellido_materno")
    private String apellido_materno;

    @Column(name = "apellido_paterno")
    private String apellido_paterno;

    public UsuarioJPA() {
    }

    public UsuarioJPA(Integer id, String nombre, String correo, String contrasena, String rol, Integer grupo_id, Timestamp fecha_registro, String usuario, String apellido_materno, String apellido_paterno) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
        this.grupoId = grupo_id;
        this.fecha_registro = fecha_registro;
        this.usuario = usuario;
        this.apellido_materno = apellido_materno;
        this.apellido_paterno = apellido_paterno;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Integer getGrupoId() {
        return grupoId;
    }

    public void setGrupoId(Integer grupoId) {
        this.grupoId = grupoId;
    }

    public Timestamp getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(Timestamp fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getApellido_materno() {
        return apellido_materno;
    }

    public void setApellido_materno(String apellido_materno) {
        this.apellido_materno = apellido_materno;
    }

    public String getApellido_paterno() {
        return apellido_paterno;
    }

    public void setApellido_paterno(String apellido_paterno) {
        this.apellido_paterno = apellido_paterno;
    }

}
