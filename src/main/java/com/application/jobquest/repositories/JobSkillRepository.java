package com.application.jobquest.repositories;

import com.application.jobquest.entities.JobSkill;
import com.application.jobquest.entities.JobSkillId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JobSkillRepository extends JpaRepository<JobSkill, JobSkillId> {
}