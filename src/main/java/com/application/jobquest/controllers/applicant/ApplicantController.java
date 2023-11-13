package com.application.jobquest.controllers.applicant;

import com.application.jobquest.dto.*;
import com.application.jobquest.dto.ResponseBody;
import com.application.jobquest.services.ApplicantService;
import com.application.jobquest.utils.ObjectConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/applicant")
public class ApplicantController {


    private final ApplicantService applicantService;


    private final ObjectConverter objectConverter;

    public ApplicantController(ApplicantService applicantService, ObjectConverter objectConverter) {
        this.applicantService = applicantService;
        this.objectConverter = objectConverter;
    }

    @PostMapping("/register")
    public ResponseBody registerApplicant(@RequestBody ApplicantRegistrationRequest applicantRegistrationRequest) {
        return new ResponseBody(new ApplicantDetailsWithJwtResponse(objectConverter.convertObject(applicantService.addApplicant(applicantRegistrationRequest), ApplicantDto.class),
                applicantService.getJWTtokens(new ApplicantLoginRequest(applicantRegistrationRequest.getEmail(), applicantRegistrationRequest.getPassword()))
        )
        );
    }

    @PostMapping("/login")
    public ResponseBody login(@RequestBody ApplicantLoginRequest applicantLoginRequest)  {
        return new ResponseBody(
                new ApplicantDetailsWithJwtResponse(
                        objectConverter.convertObject(applicantService.getApplicantByUsername(applicantLoginRequest.getEmail()), ApplicantDto.class),
                        applicantService.getJWTtokens(new ApplicantLoginRequest(applicantLoginRequest.getEmail(), applicantLoginRequest.getPassword()))
                )
        );
    }
}
