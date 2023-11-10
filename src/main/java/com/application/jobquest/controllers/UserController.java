package com.application.jobquest.controllers;

import com.application.jobquest.entities.Applicant;
import com.application.jobquest.repositories.ApplicantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
public class UserController {

    @Autowired
    ApplicantRepository applicantRepository;

    @GetMapping("/applicant/{id}")
    public Optional<Applicant> findApplicant(@PathVariable int id) {
        return applicantRepository.findById(id);
    }
}
