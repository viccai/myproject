package com.vic.demo;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan
public class TestApplication  {

	@Bean
	MessageService mockMessageService() {
		return new MessageService(){
			public String getMessage(){
				return "Hello World!";
			}
		};
	}
	
	public static void main(String[] args) {
		ApplicationContext context = 
				new AnnotationConfigApplicationContext(TestApplication.class);
		MessagePrinter printer = context.getBean(MessagePrinter.class);
		printer.printMessage();
	}

}
