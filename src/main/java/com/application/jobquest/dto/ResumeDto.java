package com.application.jobquest.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * DTO for {@link com.application.jobquest.entities.Resume}
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResumeDto implements Serializable {
    private String pdf;
}