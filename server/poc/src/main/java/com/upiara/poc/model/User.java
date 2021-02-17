package com.upiara.poc.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class User {
	@Id
	private Long id;
	private String name;
	private Date birthday;
	private Long language_id;
}
