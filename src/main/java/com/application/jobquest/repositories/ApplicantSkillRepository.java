package com.application.jobquest.repositories;

import com.application.jobquest.entities.ApplicantSkill;
import com.application.jobquest.entities.ApplicantSkillId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ApplicantSkillRepository extends JpaRepository<ApplicantSkill, ApplicantSkillId> {
}