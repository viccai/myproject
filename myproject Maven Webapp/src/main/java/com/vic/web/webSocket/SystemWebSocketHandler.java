package com.vic.web.webSocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

/**
 * @author vic
 */
@Component
public class SystemWebSocketHandler implements WebSocketHandler {

	// private static CopyOnWriteArraySet<WebSocketSession> webSocketSet = new
	// CopyOnWriteArraySet<WebSocketSession>();
	public static Map<Object, WebSocketSession> webSocketMap = new HashMap();

	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		System.out.println("connect to the websocket success......");
		session.sendMessage(new TextMessage("Server:connected OK!"));
		System.out.println("user:" + session.getAttributes().get("user"));
		// webSocketSet.add(session);
		webSocketMap.put(session.getAttributes().get("user"), session);
	}

	@Override
	public void handleMessage(WebSocketSession wss, WebSocketMessage<?> wsm)
			throws Exception {
		String s = (String) wsm.getPayload();
		
		String start = s.substring(0,2);
		System.out.println("start="+start);
		if("to".endsWith(start)){
			System.out.println("ss="+s);
			
			String str[] = s.split(",");
			System.out.println("str[0]="+str[0]);
			System.out.println("str[1]="+str[1]);
			
			String uid = str[0].replace("to", "");
			System.out.println("uid="+uid);
			
			TextMessage returnMessage = new TextMessage(str[1]);
			
			webSocketMap.get(uid).sendMessage(returnMessage);
			
		}else{
		
			TextMessage returnMessage = new TextMessage(wsm.getPayload()
					+ " received at server");
			// System.out.println(wss.getHandshakeHeaders().getFirst("Cookie"));
			// wss.sendMessage(returnMessage);
			// 群发消息
			/*
			 * for(WebSocketSession item: webSocketSet){ try {
			 * System.out.println(item.getHandshakeHeaders().getFirst("Cookie"));
			 * 
			 * item.getAttributes()
			 * 
			 * System.out.println(item.getAttributes().get("user"));
			 * item.sendMessage(returnMessage); } catch (IOException e) {
			 * e.printStackTrace(); continue; } }
			 */
			
			for (Map.Entry<Object, WebSocketSession> entry : webSocketMap
					.entrySet()) {
				System.out.println("key= " + entry.getKey() + " and value= "
						+ entry.getValue());
				try {
					System.out.println(entry.getValue().getHandshakeHeaders()
							.getFirst("Cookie"));
	
					System.out
							.println(entry.getValue().getAttributes().get("user"));
					entry.getValue().sendMessage(returnMessage);
				} catch (IOException e) {
					e.printStackTrace();
					continue;
				}
	
			}
		}
	}

	@Override
	public void handleTransportError(WebSocketSession wss, Throwable thrwbl)
			throws Exception {
		if (wss.isOpen()) {
			wss.close();
		}
		System.out.println("websocket connection closed......");
	}

	@Override
	public void afterConnectionClosed(WebSocketSession wss, CloseStatus cs)
			throws Exception {
		System.out.println("websocket connection closed......");
		// webSocketSet.remove(wss);
		webSocketMap.remove(wss.getAttributes().get("user"));
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

}
