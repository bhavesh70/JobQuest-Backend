package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * DTO for {@link com.application.jobquest.entities.Recruiter}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecruiterDto implements Serializable {
    private Integer id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private CompanyDto company;
    private String phoneNumber;
}