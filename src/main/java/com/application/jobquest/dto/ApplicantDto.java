package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * DTO for {@link com.application.jobquest.entities.Applicant}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApplicantDto implements Serializable {
    private Integer id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private ResumeDto resume;
    private Set<SkillDTO> skills = new LinkedHashSet<>();
    private Set<EducationDTO> educations = new LinkedHashSet<>();
    private String phoneNumber;
}