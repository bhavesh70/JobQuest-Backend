package com.application.jobquest.repositories;

import com.application.jobquest.entities.Resume;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResumeRepository extends JpaRepository<Resume, Integer> {
}