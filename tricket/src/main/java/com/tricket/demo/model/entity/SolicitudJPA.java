package com.tricket.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "solicitud")
public class SolicitudJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "id_user")
    private Integer iduser;

    @Column(name = "id_group")
    private Integer idgroup;

    @Column(name = "estado")
    private Boolean idestado;

    public SolicitudJPA() {
    }

    public SolicitudJPA(Integer id, Integer iduser, Integer idgroup, Boolean idestado) {
        this.id = id;
        this.iduser = iduser;
        this.idgroup = idgroup;
        this.idestado = idestado;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIduser() {
        return iduser;
    }

    public void setIduser(Integer iduser) {
        this.iduser = iduser;
    }

    public Integer getIdgroup() {
        return idgroup;
    }

    public void setIdgroup(Integer idgroup) {
        this.idgroup = idgroup;
    }

    public Boolean getIdestado() {
        return idestado;
    }

    public void setIdestado(Boolean idestado) {
        this.idestado = idestado;
    }

    

    
}
