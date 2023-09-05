package com.lwl.emailapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class EmailServiceAppApplication {

	@Autowired
	private EmailFactoryConfig emailFactoryConfig;
	public static void main(String[] args) {
		SpringApplication.run(EmailServiceAppApplication.class, args);
	}

	@Bean
	public CommandLineRunner commandLineRunner(){
			return (args)->{
				EmailProvider obj = emailFactoryConfig.getProvider(EmailProviderType.SES);
				System.out.println(obj);
			};
	}
}
