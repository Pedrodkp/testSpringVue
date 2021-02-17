package com.upiara.poc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.upiara.poc.exception.ResourceNotFoundException;
import com.upiara.poc.model.User;
import com.upiara.poc.repository.UserRepository;

@RestController
@RequestMapping("/api/v1")
public class UserController {
	@Autowired
	private UserRepository userRepository;
	
	@GetMapping("/users")
	public List <User> getAllUsers() {
		return userRepository.findAll();
	}
	
	@GetMapping("/users/{id}")
	public ResponseEntity <User> getUserById(@PathVariable(value = "id") Long userId)
	throws ResourceNotFoundException {
		User user = userRepository.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("Usuário não existe para o id: "+userId));
		return ResponseEntity.ok().body(user);
	}
	
	@PostMapping("/users")
	public User createUser(@RequestBody User user) {
		user.setId(null); //ORA-32575
		userRepository.save(user);
		return userRepository.findTopByOrderByIdDesc();
	}
}
