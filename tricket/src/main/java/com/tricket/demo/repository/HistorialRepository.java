package com.tricket.demo.repository;

import com.tricket.demo.model.entity.HistorialJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HistorialRepository extends JpaRepository<HistorialJPA, Integer> {
}