package com.vic.web.webSocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

@Configuration
@EnableWebMvc
@EnableWebSocket
public class WsConfig extends WebMvcConfigurerAdapter implements
		WebSocketConfigurer {

	public WsConfig() {
	}

	/*@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(systemWebSocketHandler(), "/websck")
				.addInterceptors(new HandshakeInterceptor());

		System.out.println("registed!");
		registry.addHandler(systemWebSocketHandler(), "/sockjs/websck")
				.addInterceptors(new HandshakeInterceptor()).withSockJS();

	}

	@Bean
	public WebSocketHandler systemWebSocketHandler() {
		// return new InfoSocketEndPoint();
		return new SystemWebSocketHandler();
	}*/
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(binaryWebSocketHandler(), "/websck")
				.addInterceptors(new HandshakeInterceptor());

		System.out.println("registed!");
		registry.addHandler(binaryWebSocketHandler(), "/sockjs/websck")
				.addInterceptors(new HandshakeInterceptor()).withSockJS();

	}
	
	@Bean
	public WebSocketHandler binaryWebSocketHandler() {
		// return new InfoSocketEndPoint();
		return new SystemBinaryWebSocketHandler();
		//return new BinaryWebSocketHandler();
	}

}
