package com.application.jobquest.exception;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class EmailAlreadyExistException extends RuntimeException{
    public EmailAlreadyExistException(String email){
        super(email+" already exists");
    }
}
