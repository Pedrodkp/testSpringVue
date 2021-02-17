package com.upiara.poc.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "VW_USERS")
public class User {
	@Id 
	@GenericGenerator(name = "UseExistingIdOtherwiseGenerateUsingIdentity", strategy = "com.upiara.poc.generator.UseExistingIdOtherwiseGenerateUsingIdentity")
	@GeneratedValue(generator = "UseExistingIdOtherwiseGenerateUsingIdentity")
	@Column(name = "id", unique = true, nullable = false, columnDefinition = "serial")
	private Long id;
	private String name;
	private Date birthday;
	private String language_code;
	private String language_description;
	
	public void setId(Long ig) {
		this.id = 1L; //ORA-32575
	}
}
