package com.application.jobquest.repositories;

import com.application.jobquest.entities.Applicant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ApplicantRepository extends JpaRepository<Applicant, Integer> {
    Optional<Applicant> findByEmail(String email);
}