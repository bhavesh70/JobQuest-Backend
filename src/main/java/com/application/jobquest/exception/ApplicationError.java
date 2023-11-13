package com.application.jobquest.exception;

public class ApplicationError extends RuntimeException {
    public ApplicationError(String message) {
        super(message);
    }
}
