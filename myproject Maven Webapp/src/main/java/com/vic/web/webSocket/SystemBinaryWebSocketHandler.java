package com.vic.web.webSocket;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

public class SystemBinaryWebSocketHandler extends AbstractWebSocketHandler {

	public static Map<Object, WebSocketSession> webSocketMap = new HashMap();
	
	@Override
	public void afterConnectionClosed(WebSocketSession wss,
			CloseStatus status) throws Exception {
		System.out.println("websocket connection closed......");
		// webSocketSet.remove(wss);
		webSocketMap.remove(wss.getAttributes().get("user"));
	}

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
	public void handleMessage(WebSocketSession session,
			WebSocketMessage<?> message) throws Exception {
		
		if (message instanceof TextMessage) {
            handleTextMessage(session, (TextMessage) message);
        }
        else if (message instanceof BinaryMessage) {
            handleBinaryMessage(session, (BinaryMessage) message);
        }
        else if (message instanceof PongMessage) {
            handlePongMessage(session, (PongMessage) message);
        }
        else {
            throw new IllegalStateException("Unexpected WebSocket message type: " + message);
        }

	}
	
	@Override
	protected void handleBinaryMessage(WebSocketSession session,
			BinaryMessage message) throws Exception {
		System.out.println("=======handleBinaryMessage========");
		
		for (Map.Entry<Object, WebSocketSession> entry : webSocketMap.entrySet()) {
			//System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
			try {
				//System.out.println(entry.getValue().getHandshakeHeaders().getFirst("Cookie"));
				System.out.println("推送图片");
				//System.out.println(entry.getValue().getAttributes().get("user"));
				entry.getValue().sendMessage(message);
			} catch (IOException e) {
				e.printStackTrace();
				continue;
			}

		}
		
		//ByteBuffer buffer = message.getPayload();
		//byte[] b = buffer.array();
		//ByteArrayOutputStream out = new ByteArrayOutputStream();
		//for(b)
		//out.write(b);
		//System.out.println(out);
		
		//super.handleBinaryMessage(session, message);
	}

	@Override
	protected void handlePongMessage(WebSocketSession session,
			PongMessage message) throws Exception {
		System.out.println("=======handlePongMessage========");
		super.handlePongMessage(session, message);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session,
			TextMessage message) throws Exception {
		System.out.println("=======handleTextMessage========");

		String s = (String) message.getPayload();
		
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
		
			TextMessage returnMessage = new TextMessage(message.getPayload()
					+ " received at server");
			
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
	public void handleTransportError(WebSocketSession wss,
			Throwable exception) throws Exception {
		if (wss.isOpen()) {
			wss.close();
		}
		System.out.println("websocket connection closed......");
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

}
