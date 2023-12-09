package com.application.jobquest.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class AppSecurityConfig{

    @Autowired
    JwtRequestFilter jwtRequestFilter;
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http.csrf(csrf-> csrf.disable())
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/applicant/register").permitAll()
                        .requestMatchers("/applicant/login").permitAll()
                        .requestMatchers("/recruiter/register").permitAll()
                        .requestMatchers("/recruiter/login").permitAll()
                        .requestMatchers("/applicant/**").hasAuthority("Role.Applicant.name()")
                        .requestMatchers("/recruiter/**").hasAuthority("Role.Recruiter.name()")
                        .anyRequest().authenticated()
                )
                .sessionManagement(session-> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}