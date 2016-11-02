package com.vic.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
 
@Controller("chat")
public class ChatAction {

    @MessageMapping("/hello")
    @SendTo("/tweet/fuck")
    public String chat(String message) throws Exception {
        System.out.println("==========="+message);
        return message;
    }
    
    @MessageMapping("/message")
    @SendToUser("/message")
    public String userMessage(String userMessage) throws Exception {
        return userMessage;
    }
 
}