package com.application.jobquest.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "resumes")
public class Resume {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "pdf", nullable = false, length = Integer.MAX_VALUE)
    private String pdf;

    @OneToOne(mappedBy = "resume")
    private Applicant applicant;

    @OneToMany(mappedBy = "resume")
    private Set<Application> applications = new LinkedHashSet<>();

}