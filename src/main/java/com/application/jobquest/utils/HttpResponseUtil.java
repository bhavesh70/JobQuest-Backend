package com.application.jobquest.utils;

import com.application.jobquest.constant.ApplicationError;
import com.application.jobquest.dto.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

public class HttpResponseUtil {
    public static void setErrorResponse(HttpServletResponse response, int httpStatus, String message, ApplicationError applicationError) throws IOException {
        response.setContentType(APPLICATION_JSON_VALUE);
        response.setStatus(httpStatus);
        new ObjectMapper().writeValue(response.getOutputStream(), new ResponseBody(applicationError, message));
    }

    public static void setErrorResponse(HttpServletResponse response, int httpStatus, ApplicationError applicationError) throws IOException {
        response.setContentType(APPLICATION_JSON_VALUE);
        response.setStatus(httpStatus);
        new ObjectMapper().writeValue(response.getOutputStream(), new ResponseBody(applicationError));
    }
}
