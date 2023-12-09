package com.application.jobquest.controllers.applicant;

import com.application.jobquest.dto.*;
import com.application.jobquest.dto.ResponseBody;
import com.application.jobquest.entities.Recruiter;
import com.application.jobquest.services.RecruiterService;
import com.application.jobquest.services.TokenUtil;
import com.application.jobquest.utils.ObjectConverter;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/recruiter")
public class RecruiterController {

    private final RecruiterService recruiterService;


    private final ObjectConverter objectConverter;

    public RecruiterController(RecruiterService recruiterService, ObjectConverter objectConverter) {
        this.recruiterService = recruiterService;
        this.objectConverter = objectConverter;
    }

    @PostMapping("/register")
    public ResponseBody registerRecruiter(@RequestBody RecruiterRegistrationRequest recruiterRegistrationRequest) {
        return new ResponseBody(
                new RecruiterDetailsWithJwtResponse(
                        objectConverter.convertObject(recruiterService.addRecruiter(recruiterRegistrationRequest), RecruiterDto.class),
                        recruiterService.getJWTtokens(new RecruiterLoginRequest(recruiterRegistrationRequest.getEmail(), recruiterRegistrationRequest.getPassword()))
                )
        );
    }

    @PostMapping("/login")
    public ResponseBody login(@RequestBody RecruiterLoginRequest recruiterLoginRequest)  {
        return new ResponseBody(
                new RecruiterDetailsWithJwtResponse(
                        objectConverter.convertObject(recruiterService.getRecruiterByUsername(recruiterLoginRequest.getEmail()), RecruiterDto.class),
                        recruiterService.getJWTtokens(new RecruiterLoginRequest(recruiterLoginRequest.getEmail(), recruiterLoginRequest.getPassword()))
                )
        );
    }


    @GetMapping("/{Recruiterid}/jobs")
    public ResponseBody getAllJobs(@PathVariable Integer Recruiterid) {
        return new ResponseBody(recruiterService.getRecruiterJobs(Recruiterid));
    }

    @GetMapping("/{Recruiterid}/jobs/{jobId}")
    public ResponseBody getJobById(@PathVariable Integer Recruiterid, @PathVariable Integer jobId) {
        return new ResponseBody(recruiterService.getJobById(Recruiterid, jobId));
    }

    @PostMapping("/{Recruiterid}/jobs/add")
    public ResponseBody addJob(@PathVariable Integer Recruiterid, @RequestBody JobDto jobDto) {
        return new ResponseBody(recruiterService.addJob(Recruiterid, jobDto));
    }

}
