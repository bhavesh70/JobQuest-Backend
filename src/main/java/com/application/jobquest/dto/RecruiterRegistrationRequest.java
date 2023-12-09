package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecruiterRegistrationRequest {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private CompanyDto company;
    private String phoneNumber;
}
