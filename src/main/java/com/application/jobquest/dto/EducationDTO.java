package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EducationDTO {
    private CollegeDTO college;
    private DegreeDTO degree;

    private LocalDate collegeStartDate;

    private LocalDate collegeEndDate;
}
