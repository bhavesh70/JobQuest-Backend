package com.application.jobquest.entities;

import com.application.jobquest.enums.LocationType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "jobs")
public class Job {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false, length = Integer.MAX_VALUE)
    private String title;

    @Column(name = "job_type", nullable = false, length = Integer.MAX_VALUE)
    private String jobType;

    @Column(name = "year_of_experience")
    private Integer yearOfExperience;

    @Column(name = "ctc", nullable = false)
    private Float ctc;

    @Column(name = "date_of_posting", nullable = false)
    private Instant dateOfPosting;

    @Column(name = "deadline", nullable = false)
    private Instant deadline;

    @Column(name = "location", length = Integer.MAX_VALUE)
    private String location;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "recruiter_id", nullable = false)
    private Recruiter recruiter;
    @Column(name = "description", length = Integer.MAX_VALUE)
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(name = "location_type")
    private LocationType locationType;

    @OneToMany(mappedBy = "job")
    private Set<Application> applications = new LinkedHashSet<>();

    @ManyToMany
    @JoinTable(name = "job_skills",
            joinColumns = @JoinColumn(name = "job_id"),
            inverseJoinColumns = @JoinColumn(name = "skill_id"))
    private Set<Skill> skills = new LinkedHashSet<>();

}