package com.application.jobquest.security;

import com.application.jobquest.constant.ApplicationError;
import com.application.jobquest.constant.Role;
import com.application.jobquest.repositories.ApplicantRepository;
import com.application.jobquest.repositories.RecruiterRepository;
import com.application.jobquest.services.JwtTokenUtil;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.SignatureException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

import static com.application.jobquest.utils.HttpResponseUtil.setErrorResponse;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {

    @Autowired
    @Qualifier("applicantService")
    private UserDetailsService applicantService;


    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String requestTokenHeader = request.getHeader("Authorization");

        String username = null;
        String jwtToken = null;
        UserDetails userDetails  = null;
        // JWT Token is in the form "Bearer token". Remove Bearer word and get
        // only the Token
        if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer ")) {
            jwtToken = requestTokenHeader.substring(7);
            try {
                username = jwtTokenUtil.getUsernameFromToken(jwtToken);
            } catch (IllegalArgumentException e) {
                setErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED, ApplicationError.INVALID_TOKEN);
                return;
            } catch (ExpiredJwtException e) {
                setErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED, ApplicationError.TOKEN_EXPIRED);
                return;
            } catch (SignatureException e) {
                setErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED,  ApplicationError.INVALID_TOKEN);
                return;
            } catch (Exception e) {
                logger.error("Exception thrown of "+e.getClass().getName()+": "+e.getMessage());
                setErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED,  ApplicationError.UNKNOWN_ERROR);
                return;
            }
        }

        // Once we get the token validate it.
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            userDetails = getUserDetailsServiceBasedOnJwtToken(jwtToken).loadUserByUsername(username);

            // if token is valid configure Spring Security to manually set
            // authentication
            boolean validToken = false;
            if(isRequestBelongsToRecruiter(request)){
                validToken = jwtTokenUtil.validateToken(jwtToken, userDetails, Role.Recruiter);
            }else if(isRequestBelongsToApplicant(request)){
                validToken = jwtTokenUtil.validateToken(jwtToken, userDetails, Role.Applicant);
            }else{
                validToken = jwtTokenUtil.validateTokenWithoutRole(jwtToken, userDetails);
            }

            if (validToken) {

                UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                        userDetails, null, userDetails.getAuthorities());
                usernamePasswordAuthenticationToken
                        .setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                // After setting the Authentication in the context, we specify
                // that the current user is authenticated. So it passes the
                // Spring Security Configurations successfully.
                SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
            }else{
                setErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED,  ApplicationError.INVALID_TOKEN);
                return;
            }
        }
        filterChain.doFilter(request, response);
    }

    private UserDetailsService getUserDetailsServiceBasedOnJwtToken(final String jwtToken){

        return applicantService;
    }

    private boolean isRequestBelongsToRecruiter(HttpServletRequest request){
        if(request.getServletPath().startsWith("/recruiter")){
            return true;
        }
        return false;
    }

    private boolean isRequestBelongsToApplicant(HttpServletRequest request){
        if(request.getServletPath().startsWith("/applicant")){
            return true;
        }
        return false;
    }
}
