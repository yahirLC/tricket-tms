package com.tricket.demo.repository;

import com.tricket.demo.model.entity.GrupoJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GrupoRepository extends JpaRepository<GrupoJPA, Integer> {
}