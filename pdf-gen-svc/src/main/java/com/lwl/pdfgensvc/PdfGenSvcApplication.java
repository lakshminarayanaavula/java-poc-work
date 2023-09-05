package com.lwl.pdfgensvc;

import com.lwl.pdfgensvc.service.PdfGeneration;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RequiredArgsConstructor
public class PdfGenSvcApplication implements CommandLineRunner {

	private final PdfGeneration pdfGeneration;
	public static void main(String[] args) {
		SpringApplication.run(PdfGenSvcApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
				pdfGeneration.convertToPDF();
	}
}
