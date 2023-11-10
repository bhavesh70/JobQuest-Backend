package com.application.jobquest.repositories;

import com.application.jobquest.entities.Degree;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DegreeRepository extends JpaRepository<Degree, Integer> {
}