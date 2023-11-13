package com.application.jobquest.utils;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ModelMapperConverter implements ObjectConverter{

    @Autowired
    ModelMapper modelMapper;
    @Override
    public <S, T> List<T> convertList(List<S> source, Class<T> targetClass) {
        return source
                .stream()
                .map(element -> modelMapper.map(element, targetClass))
                .collect(Collectors.toList());
    }

    @Override
    public <S, T> T convertObject(S source, Class<T> targetClass) {
        return modelMapper.map(source, targetClass);
    }
}
