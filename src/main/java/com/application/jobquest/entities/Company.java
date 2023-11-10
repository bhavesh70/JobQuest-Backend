package com.application.jobquest.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "companies")
public class Company {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "name", nullable = false, length = Integer.MAX_VALUE)
    private String name;

    @Column(name = "description", length = Integer.MAX_VALUE)
    private String description;

    @Column(name = "website_link", length = Integer.MAX_VALUE)
    private String websiteLink;

    @OneToMany(mappedBy = "company")
    private Set<Recruiter> recruiters = new LinkedHashSet<>();

}