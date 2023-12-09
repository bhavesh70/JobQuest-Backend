package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * DTO for {@link com.application.jobquest.entities.Company}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompanyDto implements Serializable {
    private Integer id;
    private String name;
    private String description;
    private String websiteLink;
}