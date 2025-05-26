package com.tricket.demo.repository;

import com.tricket.demo.model.entity.ComentarioJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComentarioRepository extends JpaRepository<ComentarioJPA, Integer> {
}