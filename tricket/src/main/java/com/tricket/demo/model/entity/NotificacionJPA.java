package com.tricket.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.sql.Timestamp;

@Entity
@Table(name = "notificacion") // Ensure this matches your actual table name
public class NotificacionJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    // --- IMPORTANT CHANGE HERE ---
    // Rename the Java field to 'usuarioId' (camelCase)
    // Keep @Column(name = "usuario_id") to map it to the database column with underscore
    @Column(name = "usuario_id", nullable = false)
    private Integer usuarioId; // Changed from usuario_id to usuarioId

    @Column(name = "accion", nullable = false)
    private String accion;

    @Column(name = "fecha")
    private Timestamp fecha;

    @Column(name = "descripcion")
    private String descripcion;

    public NotificacionJPA() {
        // Default constructor is important for JPA
    }

    // You might want to update this constructor if you use it,
    // or create a new one that includes 'descripcion'
    public NotificacionJPA(Integer id, Integer usuarioId, String accion, Timestamp fecha, String descripcion) {
        this.id = id;
        this.usuarioId = usuarioId; // Use the new field name
        this.accion = accion;
        this.fecha = fecha;
        this.descripcion = descripcion;
    }

    // --- Getters and Setters for the new 'usuarioId' field ---
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    // Getter for 'usuarioId'
    public Integer getUsuarioId() {
        return usuarioId;
    }

    // Setter for 'usuarioId'
    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}