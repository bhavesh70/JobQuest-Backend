package com.application.jobquest.dto;

import com.application.jobquest.entities.Education;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApplicantRegistrationRequest {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phoneNumber;
    private Set<SkillDTO> skills;
    private Set<EducationDTO> educations;
    private ResumeDto resume;
}
