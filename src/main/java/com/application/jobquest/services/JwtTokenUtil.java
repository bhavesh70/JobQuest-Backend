package com.application.jobquest.services;

import com.application.jobquest.constant.ApplicationConstants;
import com.application.jobquest.constant.JwtTokenConstants;
import com.application.jobquest.constant.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import io.jsonwebtoken.io.Encoders;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;


@Service
public class JwtTokenUtil extends JwtTokenConstants implements TokenUtil {

    private String jwtTokenSecret="afafasfafafasfasfasfafacasdasfasxASFACASDFACASDFASFASFDAFASFASDAADSCSDFADCVSGCFVADXCcadwavfsfarvf";



    @Override
    public Map<String, String> getTokens(String username, Role role) {
        Map<String, String> token = new HashMap<>();
        token.put(JwtTokenConstants.ACCESS_TOKEN, generateToken(username, role, JwtTokenConstants.ACCESS_TOKEN_EXPIRY_IN_HOURS));
        token.put(JwtTokenConstants.REFRESH_TOKEN, generateToken(username, role, JwtTokenConstants.REFRESH_TOKEN_EXPIRY_IN_HOURS));
        return token;
    }


    private String generateToken(String username, Role role, long expiration) {
        Map<String, Object> claims = new HashMap<>(){
            {
            put(ApplicationConstants.JWT_ROLE_CLAIM, String.valueOf(role));
        }
    };
        return doGenerateToken(claims, username, expiration);
    }

    private String doGenerateToken(Map<String, Object> claims, String subject, long expiration) {
        return Jwts.builder().setClaims(claims).setSubject(subject).setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expiration * 60 * 60 * 1000))
                .signWith(SignatureAlgorithm.HS512, jwtTokenSecret).compact();
    }


    @Override
    public String getUsernameFromToken(String token) {

        return getClaimFromToken(token, Claims::getSubject);
    }

    public <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = getAllClaimsFromToken(token);
        return claimsResolver.apply(claims);
    }

    private Claims getAllClaimsFromToken(String token) {
        return Jwts.parser().setSigningKey(jwtTokenSecret).parseClaimsJws(token).getBody();
    }

    @Override
    public Boolean validateToken(String token, UserDetails userDetails, Role role) {
        final String username = getUsernameFromToken(token);
        return (username.equals(userDetails.getUsername()) && getRoleFromToken(token).equals(String.valueOf(role)) && !isTokenExpired(token));
    }

    public Boolean validateTokenWithoutRole(String token, UserDetails userDetails) {
        final String username = getUsernameFromToken(token);
        return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }

    public String getRoleFromToken(String token){
        return getClaimFromToken(token, (claim) -> {
            return claim.get(ApplicationConstants.JWT_ROLE_CLAIM, String.class);
        });
    }

    private Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }

    public Date getExpirationDateFromToken(String token) {
        return getClaimFromToken(token, Claims::getExpiration);
    }
}
