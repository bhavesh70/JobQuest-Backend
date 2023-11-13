package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApplicantDetailsWithJwtResponse {
    private ApplicantDto applicantDto;
    private Map<String, String> jwtTokens;
}
