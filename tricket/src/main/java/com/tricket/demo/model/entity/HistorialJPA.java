package com.tricket.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDateTime;

@Entity
@Table(name = "historial")
public class HistorialJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "historial_id")
    private Integer historialId; // Mapea a historial_id

    @Column(name = "ticket_id", nullable = false)
    private Integer ticketId; // FK a la tabla 'ticket' (id del ticket original)

    private String numero; // Copia del 'numero' del ticket
    
    @Column(name = "categoria_id")
    private Integer categoriaId; // Copia de 'categoria_id'
    
    @Column(name = "estado_id")
    private Integer estadoId; // Copia de 'estado_id'

    private String severidad; // Copia de 'severidad'
    
    @Column(name = "grupo_id")
    private Integer grupoId; // Copia de 'grupo_id'

    private String titulo; // Copia de 'titulo'
    private String descripcion; // Copia de 'descripcion'
    
    @Column(name = "asignado_a")
    private Integer asignadoA; // Copia de 'asignado_a'
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion; // Copia de 'fecha_creacion'
    
    @Column(name = "fecha_cierre")
    private LocalDateTime fechaCierre; // Copia de 'fecha_cierre'
    
    @Column(name = "usuario_id")
    private Integer usuarioId; // Copia de 'usuario_id' (quien lo reportó originalmente)

    // Campos específicos del historial
    @Column(name = "fecha_modificacion", nullable = false)
    private LocalDateTime fechaModificacion; // Timestamp del momento en que se registró el cambio
    
    @Column(name = "usuario_que_modifico")
    private Integer usuarioQueModifico; // FK al usuario que realizó la modificación
    
    private String comentario; // Comentario sobre la modificación (ej. "Estado cambiado a Resuelto")

    // Constructor vacío (necesario para JPA)
    public HistorialJPA() {
    }

    // --- Getters y Setters ---

    public Integer getHistorialId() {
        return historialId;
    }

    public void setHistorialId(Integer historialId) {
        this.historialId = historialId;
    }

    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Integer getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(Integer categoriaId) {
        this.categoriaId = categoriaId;
    }

    public Integer getEstadoId() {
        return estadoId;
    }

    public void setEstadoId(Integer estadoId) {
        this.estadoId = estadoId;
    }

    public String getSeveridad() {
        return severidad;
    }

    public void setSeveridad(String severidad) {
        this.severidad = severidad;
    }

    public Integer getGrupoId() {
        return grupoId;
    }

    public void setGrupoId(Integer grupoId) {
        this.grupoId = grupoId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getAsignadoA() {
        return asignadoA;
    }

    public void setAsignadoA(Integer asignadoA) {
        this.asignadoA = asignadoA;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public LocalDateTime getFechaCierre() {
        return fechaCierre;
    }

    public void setFechaCierre(LocalDateTime fechaCierre) {
        this.fechaCierre = fechaCierre;
    }

    public Integer getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }

    public LocalDateTime getFechaModificacion() {
        return fechaModificacion;
    }

    public void setFechaModificacion(LocalDateTime fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }

    public Integer getUsuarioQueModifico() {
        return usuarioQueModifico;
    }

    public void setUsuarioQueModifico(Integer usuarioQueModifico) {
        this.usuarioQueModifico = usuarioQueModifico;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    @Override
    public String toString() {
        return "HistorialJPA{" +
               "historialId=" + historialId +
               ", ticketId=" + ticketId +
               ", numero='" + numero + '\'' +
               ", categoriaId=" + categoriaId +
               ", estadoId=" + estadoId +
               ", severidad='" + severidad + '\'' +
               ", grupoId=" + grupoId +
               ", titulo='" + titulo + '\'' +
               ", descripcion='" + descripcion + '\'' +
               ", asignadoA=" + asignadoA +
               ", fechaCreacion=" + fechaCreacion +
               ", fechaCierre=" + fechaCierre +
               ", usuarioId=" + usuarioId +
               ", fechaModificacion=" + fechaModificacion +
               ", usuarioQueModifico=" + usuarioQueModifico +
               ", comentario='" + comentario + '\'' +
               '}';
    }
}