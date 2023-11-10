package com.application.jobquest.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class ApplicantSkillId implements Serializable {
    private static final long serialVersionUID = 4019066826083109382L;
    @Column(name = "applicant_id", nullable = false)
    private Integer applicantId;

    @Column(name = "skill_id", nullable = false)
    private Integer skillId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ApplicantSkillId entity = (ApplicantSkillId) o;
        return Objects.equals(this.skillId, entity.skillId) &&
                Objects.equals(this.applicantId, entity.applicantId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(skillId, applicantId);
    }

}