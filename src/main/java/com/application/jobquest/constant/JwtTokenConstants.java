package com.application.jobquest.constant;

public class JwtTokenConstants {
    protected static final long ACCESS_TOKEN_EXPIRY_IN_DAYS = 150;
    protected static final long ACCESS_TOKEN_EXPIRY_IN_HOURS = ACCESS_TOKEN_EXPIRY_IN_DAYS * 24;
    protected static final long REFRESH_TOKEN_EXPIRY_IN_DAYS = 150;
    protected static final long REFRESH_TOKEN_EXPIRY_IN_HOURS = REFRESH_TOKEN_EXPIRY_IN_DAYS * 24;
    public static final String ACCESS_TOKEN = "access_token";
    public static final String REFRESH_TOKEN = "refresh_token";
}
