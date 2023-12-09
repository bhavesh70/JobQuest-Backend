package com.application.jobquest.repositories;

import com.application.jobquest.entities.Recruiter;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RecruiterRepository extends JpaRepository<Recruiter, Integer> {
    Optional<Recruiter> findByEmail(String email);
}