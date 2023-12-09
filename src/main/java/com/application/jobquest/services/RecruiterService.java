package com.application.jobquest.services;

import com.application.jobquest.constant.Role;
import com.application.jobquest.dto.ApplicantLoginRequest;
import com.application.jobquest.dto.JobDto;
import com.application.jobquest.dto.RecruiterLoginRequest;
import com.application.jobquest.dto.RecruiterRegistrationRequest;
import com.application.jobquest.entities.Applicant;
import com.application.jobquest.entities.Company;
import com.application.jobquest.entities.Job;
import com.application.jobquest.entities.Recruiter;
import com.application.jobquest.exception.InvalidEmailOrPasswordException;
import com.application.jobquest.repositories.CompanyRepository;
import com.application.jobquest.repositories.RecruiterRepository;
import com.application.jobquest.utils.ObjectConverter;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import static com.application.jobquest.constant.JwtTokenConstants.ACCESS_TOKEN;

@Service("recruiterService")
public class RecruiterService implements UserDetailsService {
    private final PasswordEncoder passwordEncoder;

    private final RecruiterRepository recruiterRepository;
    private final TokenUtil tokenUtil;


    private final ObjectConverter objectConverter;
    private final CompanyRepository companyRepository;

    public RecruiterService(PasswordEncoder passwordEncoder, RecruiterRepository recruiterRepository, TokenUtil tokenUtil, ObjectConverter objectConverter,
                            CompanyRepository companyRepository) {
        this.passwordEncoder = passwordEncoder;
        this.recruiterRepository = recruiterRepository;
        this.tokenUtil = tokenUtil;
        this.objectConverter = objectConverter;
        this.companyRepository = companyRepository;
    }

    @Transactional
    public Recruiter addRecruiter(RecruiterRegistrationRequest recruiterRegistrationRequest) {
        if(recruiterRepository.findByEmail(recruiterRegistrationRequest.getEmail()).isPresent()) {
            throw new InvalidEmailOrPasswordException();
        }
        Recruiter recruiter = objectConverter.convertObject(recruiterRegistrationRequest, Recruiter.class);
        recruiter.setPassword(passwordEncoder.encode(recruiterRegistrationRequest.getPassword()));
        Company company = objectConverter.convertObject(recruiterRegistrationRequest.getCompany(), Company.class);
        companyRepository.save(company);
        recruiter.setCompany(company);
        return recruiterRepository.save(recruiter);
    }
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Recruiter> optionalRecruiter = recruiterRepository.findByEmail(username);
        Recruiter recruiter = optionalRecruiter.orElseThrow(InvalidEmailOrPasswordException::new);
        return recruiter;
    }


    public Map<String, String> getJWTtokens(RecruiterLoginRequest recruiterLoginRequest) {
        Recruiter recruiter = recruiterRepository.findByEmail(recruiterLoginRequest.getEmail()).orElseThrow(InvalidEmailOrPasswordException::new);

        if(passwordEncoder.matches(recruiterLoginRequest.getPassword(), recruiter.getPassword())) {
            return tokenUtil.getTokens(recruiter.getEmail(), Role.Recruiter);
        }
        throw new InvalidEmailOrPasswordException();
    }

    public String getAccessTokenFromId(int recruiterId) {
        Recruiter recruiter = recruiterRepository.findById(recruiterId).orElseThrow(() -> new UsernameNotFoundException("Recruiter not found"));
        return tokenUtil.getTokens(recruiter.getEmail(), Role.Recruiter).get(ACCESS_TOKEN);
    }

    public Recruiter getRecruiterByUsername(String username){
        return recruiterRepository.findByEmail(username).orElseThrow(InvalidEmailOrPasswordException::new);
    }

    public Set<Job> getRecruiterJobs(Integer Recruiterid) {
        return recruiterRepository.findById(Recruiterid).orElseThrow(InvalidEmailOrPasswordException::new).getJobs();
    }

    public Job getJobById(Integer recruiterid, Integer jobId) {
        return recruiterRepository.findById(recruiterid).orElseThrow(InvalidEmailOrPasswordException::new).getJobs().stream().filter(job -> job.getId().equals(jobId)).findFirst().orElseThrow(InvalidEmailOrPasswordException::new);
    }

    public int  addJob(Integer recruiterid, JobDto jobDto) {
        Recruiter recruiter = recruiterRepository.findById(recruiterid).orElseThrow(InvalidEmailOrPasswordException::new);
        Job job = objectConverter.convertObject(jobDto, Job.class);
        job.setRecruiter(recruiter);
        recruiter.getJobs().add(job);
        return recruiterRepository.save(recruiter).getId();
    }
}
