package com.tricket.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.sql.Timestamp;

@Entity
@Table(name = "historial")
public class HistorialJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "ticket_id", nullable = false)
    private Integer ticket_id;

    @Column(name = "usuario_id", nullable = false)
    private Integer usuario_id;

    @Column(name = "accion", nullable = false)
    private String accion;

    @Column(name = "fecha")
    private Timestamp fecha;

    public HistorialJPA() {
    }

    public HistorialJPA(Integer id, Integer ticket_id, Integer usuario_id, String accion, Timestamp fecha) {
        this.id = id;
        this.ticket_id = ticket_id;
        this.usuario_id = usuario_id;
        this.accion = accion;
        this.fecha = fecha;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTicket_id() {
        return ticket_id;
    }

    public void setTicket_id(Integer ticket_id) {
        this.ticket_id = ticket_id;
    }

    public Integer getUsuario_id() {
        return usuario_id;
    }

    public void setUsuario_id(Integer usuario_id) {
        this.usuario_id = usuario_id;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

}
