package com.application.jobquest.dto;

import com.application.jobquest.enums.LocationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * DTO for {@link com.application.jobquest.entities.Job}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class JobDto implements Serializable {
    private String title;
    private String jobType;
    private Integer yearOfExperience;
    private Float ctc;
    private Instant dateOfPosting;
    private Instant deadline;
    private String location;
    private String description;
    private LocationType locationType;
    private Set<com.application.jobquest.dto.SkillDTO> skills = new LinkedHashSet<>();
}