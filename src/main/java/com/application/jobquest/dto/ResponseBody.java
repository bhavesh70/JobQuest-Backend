package com.application.jobquest.dto;

import com.application.jobquest.constant.ApplicationError;
import com.application.jobquest.constant.RequestStatus;
import lombok.Data;


@Data
public class ResponseBody {
    private RequestStatus status;
    private String error;
    private String error_code;
    private Object data;

    public ResponseBody(){
        this.status = RequestStatus.SUCCESS;
    }

    public ResponseBody(Object data) {
        this.data = data;
        this.status = RequestStatus.SUCCESS;
    }

    public ResponseBody(ApplicationError applicationError) {
        this.status = RequestStatus.FAILED;
        this.error = applicationError.getMessage();
        this.error_code = applicationError.name();
    }

    public ResponseBody(ApplicationError applicationError, String customMessage) {
        this.status = RequestStatus.FAILED;
        this.error = customMessage;
        this.error_code = applicationError.name();
    }
}
