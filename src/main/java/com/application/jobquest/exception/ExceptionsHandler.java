package com.application.jobquest.exception;

import com.application.jobquest.dto.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import com.application.jobquest.constant.ApplicationError;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;




@ControllerAdvice
public class ExceptionsHandler {
    Logger logger = (Logger) LoggerFactory.getLogger(ExceptionsHandler.class);

    @ExceptionHandler(com.application.jobquest.exception.ApplicationError.class)
    public ResponseEntity<ResponseBody> handleApplicationError(com.application.jobquest.exception.ApplicationError exception){
        // write this logger in updated way logger.error(exception.getMessage());
        logger.error(exception.getMessage());
        return new ResponseEntity<>(new ResponseBody(ApplicationError.APPLICATION_ERROR, exception.getMessage()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(UserDoesNotExistException.class)
    public ResponseEntity<ResponseBody> handleUsernameDoesNotExistException(UserDoesNotExistException exception){
        logger.error(exception.getMessage());
        return new ResponseEntity<>(new ResponseBody(ApplicationError.USER_DOES_NOT_EXIST), HttpStatus.FORBIDDEN);
    }
}
