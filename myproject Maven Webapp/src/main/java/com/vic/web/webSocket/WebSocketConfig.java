package com.vic.web.webSocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.config.annotation.*;
 
//@Configuration
//@EnableWebMvc
//@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
 
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
    	System.out.println("==========configureMessageBroker===========");
        config.enableSimpleBroker("/tweet");//这句表示在tweet域上可以向客户端发消息
        config.setApplicationDestinationPrefixes("/websocket");//这句表示客户端向服务端发送时的主题上面需要加"/websocket"作为前缀
        config.setUserDestinationPrefix("/user/");//这句表示给指定用户发送（一对一）的主题前缀是“/user/”
    }
 
    public void registerStompEndpoints(StompEndpointRegistry registry) {
    	System.out.println("==========registerStompEndpoints===========");
        registry.addEndpoint("/hello").withSockJS();//这个和客户端创建连接时的url有关
    }
 
}
