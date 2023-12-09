package com.application.jobquest.services;

import com.application.jobquest.entities.Job;
import com.application.jobquest.repositories.JobRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JobService {

    private final JobRepository jobRepository;


    public JobService(JobRepository jobRepository) {
        this.jobRepository = jobRepository;
    }


    public List<Job> getJobs() {
        return jobRepository.findAll();
    }

    public Job getJobById(int id) {
        return jobRepository.findById(id).orElseThrow();
    }
}
