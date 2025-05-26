package com.tricket.demo.model.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mensaje") // This is correct now for your 'mensaje' table
public class MensajeJPA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Map remitente_id to a Usuario object
    @ManyToOne // A message has one sender (Usuario), but a Usuario can send many messages
    @JoinColumn(name = "remitente_id", nullable = false) // This specifies the foreign key column name
    private UsuarioJPA remitente; // Changed from emisorNombre to a Usuario object

    // Map destinatario_id to a Usuario object
    @ManyToOne // A message has one receiver (Usuario), but a Usuario can receive many messages
    @JoinColumn(name = "destinatario_id", nullable = false) // This specifies the foreign key column name
    private UsuarioJPA destinatario; // Changed from receptorNombre to a Usuario object

    @Column(name = "contenido", nullable = false) // Map 'contenido' field to 'contenido' column
    private String contenido;

    @Column(name = "fecha_envio") // Map 'fechaEnvio' field to 'fecha_envio' column
    private LocalDateTime fechaEnvio;

    @Column(name = "leido") // Map 'leido' field to 'leido' column
    private boolean leido;

    // IMPORTANT: Update your Getters and Setters for 'remitente' and 'destinatario'
    // You will no longer have getEmisorNombre/setEmisorNombre, etc.
    // Instead, you will have getRemitente()/setRemitente()
    // To get the sender's name, you would do: getRemitente().getNombre()

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    

    // New Getters and Setters for Usuario objects
    public UsuarioJPA getRemitente() {
        return remitente;
    }

    public void setRemitente(UsuarioJPA remitente) {
        this.remitente = remitente;
    }

    public UsuarioJPA getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(UsuarioJPA destinatario) {
        this.destinatario = destinatario;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public LocalDateTime getFechaEnvio() {
        return fechaEnvio;
    }

    public void setFechaEnvio(LocalDateTime fechaEnvio) {
        this.fechaEnvio = fechaEnvio;
    }

    public boolean isLeido() {
        return leido;
    }

    public void setLeido(boolean leido) {
        this.leido = leido;
    }
}