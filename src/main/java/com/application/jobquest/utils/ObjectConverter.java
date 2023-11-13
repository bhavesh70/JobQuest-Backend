package com.application.jobquest.utils;

import com.application.jobquest.dto.SkillDTO;
import com.application.jobquest.entities.Skill;

import java.util.List;
import java.util.Set;

public interface ObjectConverter {
    public <S, T> List<T> convertList(List<S> source, Class<T> targetClass);

    public <S, T> T convertObject(S source, Class<T> targetClass);


}
