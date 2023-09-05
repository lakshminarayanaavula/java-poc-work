package com.lwl.pdfgensvc;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.Assert;

@SpringBootTest
class PdfGenSvcApplicationTests {

	@Test
	void contextLoads() {
	}
	@Test
	void sampleTest(){
		Assert.isTrue(1==1,"Hello");
	}

}
