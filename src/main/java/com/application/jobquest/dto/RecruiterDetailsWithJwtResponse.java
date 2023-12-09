package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecruiterDetailsWithJwtResponse {
    private RecruiterDto recruiterDto;
    private Map<String, String> jwtTokens;
}
