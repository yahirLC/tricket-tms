package com.tricket.demo.repository;


import com.tricket.demo.model.entity.LogJPA;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LogRepository extends JpaRepository<LogJPA, Integer> {
}