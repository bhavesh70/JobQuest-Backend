package com.application.jobquest.services;

import com.application.jobquest.constant.Role;
import com.application.jobquest.dto.ApplicantLoginRequest;
import com.application.jobquest.dto.ApplicantRegistrationRequest;
import com.application.jobquest.dto.EducationDTO;
import com.application.jobquest.dto.SkillDTO;
import com.application.jobquest.entities.*;
import com.application.jobquest.exception.EmailAlreadyExistException;
import com.application.jobquest.exception.InvalidEmailOrPasswordException;
import com.application.jobquest.repositories.*;
import com.application.jobquest.utils.ObjectConverter;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static com.application.jobquest.constant.JwtTokenConstants.ACCESS_TOKEN;

@Service("applicantService")
public class ApplicantService implements UserDetailsService {


    private final ApplicantRepository applicantRepository;


    private final SkillRepository skillRepository;

    private final EducationRepository educationRepository;

    private final CollegeRepository collegeRepository;

    private final DegreeRepository degreeRepository;

    private final ResumeRepository resumeRepository;


    private final PasswordEncoder passwordEncoder;


    private final TokenUtil tokenUtil;


    private final ObjectConverter objectConverter;


    public ApplicantService(ApplicantRepository applicantRepository, SkillRepository skillRepository, EducationRepository educationRepository, CollegeRepository collegeRepository, DegreeRepository degreeRepository, ResumeRepository resumeRepository, PasswordEncoder passwordEncoder, TokenUtil tokenUtil, ObjectConverter objectConverter) {
        this.applicantRepository = applicantRepository;
        this.skillRepository = skillRepository;
        this.educationRepository = educationRepository;
        this.collegeRepository = collegeRepository;
        this.degreeRepository = degreeRepository;
        this.resumeRepository = resumeRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenUtil = tokenUtil;
        this.objectConverter = objectConverter;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Applicant> optionalApplicant = applicantRepository.findByEmail(username);

        Applicant applicant = optionalApplicant.orElseThrow(InvalidEmailOrPasswordException::new);

        return applicant;
    }


    public String getAccessTokenFromId(int applicantId) {
        Applicant applicant = applicantRepository.findById(applicantId).orElseThrow(() -> new UsernameNotFoundException("Applicant not found"));
        return tokenUtil.getTokens(applicant.getEmail(), Role.Applicant).get(ACCESS_TOKEN);
    }

    @Transactional
    public Applicant addApplicant(ApplicantRegistrationRequest applicantRegistrationRequest) {


        applicantRepository.findByEmail(applicantRegistrationRequest.getEmail()).ifPresent(applicant -> {
            throw new EmailAlreadyExistException(applicantRegistrationRequest.getEmail());
        });


        Applicant applicant = new Applicant();
        applicant.setFirstName(applicantRegistrationRequest.getFirstName());
        applicant.setLastName(applicantRegistrationRequest.getLastName());
        applicant.setEmail(applicantRegistrationRequest.getEmail());
        applicant.setPassword(passwordEncoder.encode(applicantRegistrationRequest.getPassword()));
        applicant.setPhoneNumber(applicantRegistrationRequest.getPhoneNumber());
        Resume resume = objectConverter.convertObject(applicantRegistrationRequest.getResume(), Resume.class);
        resumeRepository.save(resume);
        applicant.setResume(resume);
        Set<SkillDTO> skillDTOSet = applicantRegistrationRequest.getSkills();
        List<SkillDTO> skillDTOList = new ArrayList<>(skillDTOSet);
        List<Skill> skillList = objectConverter.convertList(skillDTOList, Skill.class);
        Set<Skill> skillSet = new HashSet<>(skillList);
        skillRepository.saveAll(skillSet);
        applicant.setSkills(skillSet);



        Set<EducationDTO> EducationDTOSet =  applicantRegistrationRequest.getEducations();
        List<EducationDTO> EducationDTOList = new ArrayList<>(EducationDTOSet);

        List<Education> educationList = objectConverter.convertList(EducationDTOList, Education.class);

        for (Education education : educationList) {
            College college = education.getCollege();
            Degree degree = education.getDegree();
            collegeRepository.save(college);
           degreeRepository.save(degree);
           education.setApplicant(applicant);
        }

        applicant.setEducations(new HashSet<>(educationList));
        applicantRepository.save(applicant);
        Set<Education> educationSet = new HashSet<>(educationList);



        educationRepository.saveAll(educationSet);



    return applicant;

    }

    public Map<String, String> getJWTtokens(ApplicantLoginRequest applicantLoginRequest) {
        Applicant applicant = applicantRepository.findByEmail(applicantLoginRequest.getEmail()).orElseThrow(InvalidEmailOrPasswordException::new);

        if(passwordEncoder.matches(applicantLoginRequest.getPassword(), applicant.getPassword())) {
            return tokenUtil.getTokens(applicant.getEmail(), Role.Applicant);
        }
        throw new InvalidEmailOrPasswordException();
    }

    public Applicant getApplicantByUsername(String username){
        return applicantRepository.findByEmail(username).orElseThrow(InvalidEmailOrPasswordException::new);
    }

}
