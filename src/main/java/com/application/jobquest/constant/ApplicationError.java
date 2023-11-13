package com.application.jobquest.constant;

public enum ApplicationError {
    UNKNOWN_ERROR{
        @Override
        public String getMessage(){
            return "An unknown error has occurred";
        }
    },

    APPLICATION_ERROR{
        @Override
        public String getMessage() {
            return "Application error";
        }
    },
    FAILED_TO_APPLY_REFERRAL_CODE{
        @Override
        public String getMessage(){
            return "Failed to apply referral code";
        }
    },

    INVALID_TOKEN{
        @Override
        public String getMessage(){
            return "Invalid token provided";
        }
    },

    TOKEN_EXPIRED{
        @Override
        public String getMessage(){
            return "Token expired";
        }
    },

    TOKEN_AND_ID_MISMATCH{
        @Override
        public String getMessage(){
            return "Token didn't match with provided id";
        }
    },
    INVALID_SERVICE{
        @Override
        public String getMessage() {
            return "Provided service doesn't exist";
        }
    },

    CONSTRAINT_VIOLATED{
        @Override
        public String getMessage() {
            return "Violated constraint";
        }
    },

    INVALID_ARGUMENTS_PASSED{
        @Override
        public String getMessage() {
            return "One or more arguments are invalid";
        }
    },

    AUTH_FAILED{
        @Override
        public String getMessage() {
            return "Authentication Failed";
        }
    },

    INVALID_CITY_ARGUMENT_PASSED{
        @Override
        public String getMessage() {
            return "We are not open yet in this city";
        }
    },

    INTERNAL_SERVER_ERROR{
        @Override
        public String getMessage() {
            return "Something went wrong. Please try again later.";
        }
    },

    EMAIL_ALREADY_EXIST{
        @Override
        public String getMessage() {
            return "The email account already exists.";
        }
    },

    INVALID_EMAIL_OR_PASSWORD{
        @Override
        public String getMessage() {
            return "Incorrect Email or Password.";
        }
    },

    USER_DOES_NOT_EXIST{
        @Override
        public String getMessage() {
            return "Username doesn't exist.";
        }
    },

    INVALID_REQUEST{
        @Override
        public String getMessage() {
            return "Invalid request. Try again after sometime";
        }
    };

    public abstract String getMessage();
}
