package com.tricket.demo.repository;

import com.tricket.demo.model.entity.EstadoJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstadoRepository extends JpaRepository<EstadoJPA, Integer> {
}