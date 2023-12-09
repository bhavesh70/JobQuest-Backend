package com.application.jobquest.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "skills")
public class Skill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable =false)
    private Integer id;


    @Column(name = "name", nullable = false, length = Integer.MAX_VALUE)
    private String name;

    @ManyToMany(mappedBy = "skills")
    private Set<Applicant> applicants = new LinkedHashSet<>();

    @ManyToMany(mappedBy = "skills")
    private Set<Job> jobs = new LinkedHashSet<>();

}