package com.application.jobquest.services;

import com.application.jobquest.constant.Role;
import com.application.jobquest.dto.ApplicantLoginRequest;
import com.application.jobquest.dto.ApplicantRegistrationRequest;
import com.application.jobquest.dto.EducationDTO;
import com.application.jobquest.dto.SkillDTO;
import com.application.jobquest.entities.Applicant;
import com.application.jobquest.entities.Education;
import com.application.jobquest.entities.Resume;
import com.application.jobquest.entities.Skill;
import com.application.jobquest.exception.InvalidEmailOrPasswordException;
import com.application.jobquest.repositories.ApplicantRepository;
import com.application.jobquest.repositories.EducationRepository;
import com.application.jobquest.repositories.ResumeRepository;
import com.application.jobquest.repositories.SkillRepository;
import com.application.jobquest.utils.ObjectConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import static com.application.jobquest.constant.JwtTokenConstants.ACCESS_TOKEN;

@Service("applicantService")
public class ApplicantService implements UserDetailsService {


    private final ApplicantRepository applicantRepository;


    private final SkillRepository skillRepository;


    private final EducationRepository educationRepository;


    private final ResumeRepository resumeRepository;


    private final PasswordEncoder passwordEncoder;


    private final TokenUtil tokenUtil;


    private final ObjectConverter objectConverter;


    public ApplicantService(ApplicantRepository applicantRepository, SkillRepository skillRepository, EducationRepository educationRepository, ResumeRepository resumeRepository, PasswordEncoder passwordEncoder, TokenUtil tokenUtil, ObjectConverter objectConverter) {
        this.applicantRepository = applicantRepository;
        this.skillRepository = skillRepository;
        this.educationRepository = educationRepository;
        this.resumeRepository = resumeRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenUtil = tokenUtil;
        this.objectConverter = objectConverter;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Applicant applicant = applicantRepository.findByEmail(username);
        if(applicant == null) {
            throw new UsernameNotFoundException("Applicant not found");
        }
        return applicant;
    }


    public String getAccessTokenFromId(int applicantId) {
        Applicant applicant = applicantRepository.findById(applicantId).orElseThrow(() -> new UsernameNotFoundException("Applicant not found"));
        return tokenUtil.getTokens(applicant.getEmail(), Role.Applicant).get(ACCESS_TOKEN);
    }

    public Applicant addApplicant(ApplicantRegistrationRequest applicantRegistrationRequest) {
        Applicant applicant = new Applicant();
        applicant.setFirstName(applicantRegistrationRequest.getFirstName());
        applicant.setLastName(applicantRegistrationRequest.getLastName());
        applicant.setEmail(applicantRegistrationRequest.getEmail());
        applicant.setPassword(passwordEncoder.encode(applicantRegistrationRequest.getPassword()));
        applicant.setPhoneNumber(applicantRegistrationRequest.getPhoneNumber());
        List<SkillDTO> skillDTOList = (List<SkillDTO>) applicantRegistrationRequest.getSkills();
        Set<Skill> skillSet = (Set<Skill>)objectConverter.convertList(skillDTOList, Skill.class);
        applicant.setSkills(skillSet);
        for (Skill skill : skillSet) {
            skill.getApplicants().add(applicant);
        }
        skillRepository.saveAll(skillSet);

        List<EducationDTO> EducationDTOList = (List<EducationDTO>) applicantRegistrationRequest.getEducations();
        Set<Education> educationSet = (Set<Education>)objectConverter.convertList(EducationDTOList, Education.class);
        applicant.setEducations(educationSet);
        for (Education education : educationSet) {
            education.setApplicant(applicant);
        }

        educationRepository.saveAll(educationSet);

        Resume resume = objectConverter.convertObject(applicantRegistrationRequest.getResume(), Resume.class);
        resume.setApplicant(applicant);
        applicant.setResume(resume);
        resumeRepository.save(resume);
        applicantRepository.save(applicant);
    return applicant;

    }

    public Map<String, String> getJWTtokens(ApplicantLoginRequest applicantLoginRequest) {
        Applicant applicant = applicantRepository.findByEmail(applicantLoginRequest.getEmail());
        //match password without passeord encoder

        if(applicantLoginRequest.getPassword().equals(applicant.getPassword())){
            return tokenUtil.getTokens(applicant.getEmail(), Role.Applicant);
        }
        throw new InvalidEmailOrPasswordException();
    }

    public Applicant getApplicantByUsername(String username){
        return applicantRepository.findByEmail(username);
    }

}
