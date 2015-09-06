package com.chen.spring.rest.model;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
@RooJson
public class Comment {

//    /**
//     */
//    @NotNull
//    @GeneratedValue(strategy = GenerationType.AUTO)
//    @Column(name = "ID")
//    private Integer id;

    /**
     */
    @NotNull
    @Column(name = "COMMENT")
    private String comment;

    /**
     */
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    @Column(name = "COMMENT_DATE")
    private Date commentDate;
}
