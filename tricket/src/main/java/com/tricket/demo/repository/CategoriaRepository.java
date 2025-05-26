package com.tricket.demo.repository;

import com.tricket.demo.model.entity.CategoriaJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoriaRepository extends JpaRepository<CategoriaJPA, Integer> {
}