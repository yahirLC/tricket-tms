package com.tricket.demo.repository;

import com.tricket.demo.model.entity.SolicitudJPA;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SolicitudRepository extends JpaRepository<SolicitudJPA, Integer> {

     List<SolicitudJPA> findByIdgroupAndIdestadoIsNull(int idgroup);

    Optional<SolicitudJPA> findByIduserAndIdgroup(Integer iduser, Integer idgroup);
}
