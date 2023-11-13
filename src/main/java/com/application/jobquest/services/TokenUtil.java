package com.application.jobquest.services;

import com.application.jobquest.constant.Role;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Map;

public interface TokenUtil {
    Map<String, String> getTokens(final String username, final Role role);
    String getUsernameFromToken(String token);
    Boolean validateToken(String token, UserDetails userDetails, Role role);
}
